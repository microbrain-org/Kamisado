//
//  KMMovementManager.m
//  Kamisado
//
//  Created by Max on 24.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import "KMMovementManager.h"

static KMMovementManager *instance = nil;

@interface KMMovementManager ()
@property (nonatomic, strong) NSMutableArray *playFieldMap;
@end

@implementation KMMovementManager

+ (KMMovementManager *)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [KMMovementManager new];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    
    self.playFieldMap = [NSMutableArray arrayWithCapacity:DEFAULT_POSITION_MAP.count];
    for(NSArray *array in DEFAULT_POSITION_MAP)
        [self.playFieldMap addObject:[NSMutableArray arrayWithArray:array]];
    
    return self;
}

#pragma mark - Public Methods

- (CGPoint)convertCoordinatesIntoCellPosition:(CGPoint)coordinates
{
    int x = coordinates.x / CELL_SIZE.width;
    int y = coordinates.y / (int)CELL_SIZE.height;
    return CGPointMake( x, y);
}

- (CheckerColor)getCellColorAtPosition:(CGPoint)position
{
    return (CheckerColor)[FIELD_COLOR_MAP[(int)position.x][(int)position.y] integerValue];
}

- (CGPoint)getCellCenterAtPostion:(CGPoint)position
{
    return CGPointMake(position.x * CELL_SIZE.width + CELL_SIZE.width / 2, position.y * CELL_SIZE.height + CELL_SIZE.height / 2);
}

- (BOOL)isMoveAllowedFromPosition:(CGPoint)oldPosition toPosition:(CGPoint)newPosition withCheckerType:(CheckerType)checkerType
{
    if([self isAnyObstacleFromPosition:oldPosition toPosition:newPosition checkerType:checkerType])
        return NO;
    
    if((checkerType == CheckerBlack && newPosition.y > oldPosition.y) ||
       (checkerType == CheckerWhite && newPosition.y < oldPosition.y))
        return NO;
    
    if(abs(oldPosition.x - newPosition.x) == abs(oldPosition.y - newPosition.y))
    {
       if(checkerType == CheckerWhite && (newPosition.x > oldPosition.x || newPosition.y > oldPosition.y))
           return YES;
        
        if(checkerType == CheckerBlack && (newPosition.x < oldPosition.x || newPosition.y < oldPosition.y))
            return YES;
    }
    
    if(checkerType == CheckerWhite && newPosition.y > oldPosition.y && newPosition.x == oldPosition.x)
        return YES;
    
    if(checkerType == CheckerBlack && newPosition.y < oldPosition.y && newPosition.x == oldPosition.x)
        return YES;
    
    return NO;
}

- (void)emptyCellAtPosition:(CGPoint)position
{
    self.playFieldMap[(int)position.x][(int)position.y] = @(0);
}

- (void)occupyCellAtPosition:(CGPoint)position
{
    self.playFieldMap[(int)position.x][(int)position.y] = @(1);
}

#pragma mark - Private Methods

- (BOOL)isCellOccupied:(CGPoint)position
{
    NSNumber *field = self.playFieldMap[(int)position.x][(int)position.y];
    return [field boolValue];
}

- (BOOL)isAnyObstacleFromPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition checkerType:(CheckerType)checkerType
{
    if([self isCellOccupied:toPosition])
        return YES;
    
    if(toPosition.x == fromPosition.x)
    {
        BOOL isOccupied = NO;
        if(checkerType == CheckerWhite)
        {
            for(int i = fromPosition.y + 1; i <= toPosition.y; i++)
            {
                isOccupied = [self isCellOccupied:CGPointMake(toPosition.x, i)];
                if(isOccupied) return YES;
            }
        }
        else
        {
            for(int i = fromPosition.y - 1; i >= toPosition.y; i--)
            {
                isOccupied = [self isCellOccupied:CGPointMake(toPosition.x, i)];
                if(isOccupied) return YES;
            }
        }
    }
    else
    {
        if(fromPosition.x > toPosition.x)
        {
            int startX = fromPosition.x - 1;
            int startY = (checkerType == CheckerBlack) ? fromPosition.y - 1 : fromPosition.y + 1;
            while (startX > toPosition.x)
            {
                startX--;
                (checkerType == CheckerBlack) ? startY-- : startY++;
                if([self isCellOccupied:CGPointMake(startX, startY)])
                    return YES;
            }
        }
        else
        {
            int startX = fromPosition.x + 1;
            int startY = (checkerType == CheckerBlack) ? fromPosition.y - 1 : fromPosition.y + 1;
            while (startX < toPosition.x)
            {
                startX++;
                (checkerType == CheckerBlack) ? startY-- : startY++;
                if([self isCellOccupied:CGPointMake(startX, startY)])
                    return YES;
            }
        }
    }
    
    return NO;
}

@end
