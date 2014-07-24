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
@property (nonatomic, strong) KMPlayField *playField;
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

#pragma mark - Public Methods

- (void)setPlayField:(KMPlayField *)playField
{
    _playField = playField;
}

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

- (BOOL)isMoveAllowedFromPosition:(CGPoint)oldPosition toPosition:(CGPoint)newPosition
{
    if(abs(oldPosition.x - newPosition.x) == abs(oldPosition.y - newPosition.y) &&
       (newPosition.x > oldPosition.x || newPosition.y > oldPosition.y))
        return YES;
    
    if(newPosition.y > oldPosition.y && newPosition.x == oldPosition.x)
        return YES;
    
    return NO;
}

@end
