//
//  KMViewController.m
//  Kamisado
//
//  Created by Max on 22.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import "KMPlayViewController.h"
#import "Definitions.h"
#import "KMChecker.h"
#import "KMPlayField.h"
#import "KMMovementManager.h"

@interface KMPlayViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *whiteCheckers;
@property (nonatomic, strong) NSArray *blackCheckers;

@property (nonatomic, assign) BOOL isFirstMoveDone;

@property (nonatomic, weak) IBOutlet KMPlayField *playField;

@end

@implementation KMPlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareCheckers];
}

#pragma mark - Setup

- (void)prepareCheckers
{
    NSArray *colors = @[@(kOrange), @(kBlue), @(kCyan), @(kMagenta), @(kYellow), @(kRed), @(kGreen), @(kBrown)];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:8];
    for(int i = 0; i < 8; i++)
    {
        CheckerColor color = (CheckerColor)[colors[i] integerValue];
        KMChecker *checker = [[KMChecker alloc] initWithColor:color
                                                         type:CheckerWhite
                                                     position:CGPointMake(i, 0)];
        [self addGestureRecognizerToView:checker];
        [array addObject:checker];
    }
    self.whiteCheckers = [array copy];
    [array removeAllObjects];
    
    for(int i = 0; i < 8; i++)
    {
        CheckerColor color = (CheckerColor)[colors[7 - i] integerValue];
        KMChecker *checker = [[KMChecker alloc] initWithColor:color
                                                         type:CheckerBlack
                                                     position:CGPointMake(i, 7)];
        checker.active = YES;
        [self addGestureRecognizerToView:checker];
        [array addObject:checker];
    }
    self.blackCheckers = [array copy];
    array = nil;
    
    [self placeCheckersOnTheField];
}

- (void)placeCheckersOnTheField
{
    for(KMChecker *checker in self.whiteCheckers)
        [self.playField addSubview:checker];
    
    for (KMChecker *checker in self.blackCheckers)
        [self.playField addSubview:checker];
}

- (void)resetCheckersPosition
{
    for(KMChecker *checker in self.blackCheckers)
        [checker removeFromSuperview];
    
    for(KMChecker *checker in self.whiteCheckers)
        [checker removeFromSuperview];
    
    self.blackCheckers = nil;
    self.whiteCheckers = nil;
    
    [self placeCheckersOnTheField];
}

#pragma mark - Private Methods

- (void)findNextActiveCheckerWithColor:(CheckerColor)color andType:(CheckerType)type
{
    NSArray *checkersArray = (type == CheckerBlack) ? self.whiteCheckers : self.blackCheckers;
    
    for(KMChecker *checker in checkersArray)
    {
        if(checker.color == color)
        {
            checker.active = YES;
            break;
        }
    }
}

- (void)placeChecker:(KMChecker *)checker atPoint:(CGPoint)point animated:(BOOL)animated
{
    if(animated)
        [UIView beginAnimations:@"placeAnimation" context:nil];
    
    checker.center = point;
    
    if(animated)
        [UIView commitAnimations];
    
}

- (BOOL)isEndOfTheGameWithChecker:(KMChecker *)checker
{
    if(checker.type == CheckerBlack && checker.position.y == 0)
    {
        [self endGame];
        return YES;
    }
    
    if(checker.type == CheckerWhite && checker.position.y == 7)
    {
        
        [self endGame];
        return YES;
    }
    
    return NO;
}

- (void)endGame
{
    [self showAlertWithMessage:@"Game Ended"];
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - KMCheckerDelegate

- (void)moveFinished:(KMChecker *)checker atPoint:(CGPoint)point
{
    if(!self.isFirstMoveDone)
    {
        self.isFirstMoveDone = YES;
        for(KMChecker *checker in self.blackCheckers)
            checker.active = NO;
    }
    
    KMMovementManager *manager = [KMMovementManager instance];
    
    if(![manager isMoveAllowed])
    {
        [self placeChecker:checker atPoint:[manager getCellCenterAtPostion:checker.position] animated:YES];
    }
        
    checker.active = NO;
    checker.position = [manager convertCoordinatesIntoCellPosition:point];
    [self placeChecker:checker atPoint:[manager getCellCenterAtPostion:checker.position] animated:YES];
    
    if([self isEndOfTheGameWithChecker:checker])
        return;
    
    CheckerColor color = [[KMMovementManager instance] getColorAtPosition:checker.position];
    [self findNextActiveCheckerWithColor:color andType:checker.type];
}

#pragma mark - Gesture Recognizer

- (void)addGestureRecognizerToView:(UIView *)view
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [view addGestureRecognizer:panGesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    KMChecker *checker = (KMChecker *)[recognizer view];

    CGPoint translation = [recognizer translationInView:checker.superview];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        [checker.superview bringSubviewToFront:checker];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [recognizer velocityInView:checker];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        
        float slideFactor = 0.1 * slideMult;
        
        CGFloat finalX = checker.center.x;
        CGFloat finalY = checker.center.y;
        [UIView animateWithDuration: slideFactor
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGPoint finalPoint = CGPointMake(finalX, finalY);
                             recognizer.view.center = finalPoint; }
                         completion:nil];
        
        [self moveFinished:checker atPoint:CGPointMake(finalX, finalY)];
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:checker.superview];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self resetCheckersPosition];
}

@end
