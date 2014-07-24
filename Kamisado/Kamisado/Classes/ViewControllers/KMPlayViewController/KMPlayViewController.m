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

@interface KMPlayViewController () <KMCheckerDelegate>

@property (nonatomic, strong) NSArray *whiteCheckers;
@property (nonatomic, strong) NSArray *blackCheckers;

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
                                                         type:kWhite
                                                     position:CGPointMake(i, 0)
                                                     delegate:self];
        [self addGestureRecognizerToView:checker];
        [array addObject:checker];
    }
    self.whiteCheckers = [array copy];
    [array removeAllObjects];
    
    for(int i = 0; i < 8; i++)
    {
        CheckerColor color = (CheckerColor)[colors[7 - i] integerValue];
        KMChecker *checker = [[KMChecker alloc] initWithColor:color
                                                         type:kBlack
                                                     position:CGPointMake(i, 7)
                                                     delegate:self];
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

#pragma mark - Private Methods

- (void)findNextActiveCheckerWithColor:(CheckerColor)color andType:(CheckerType)type
{
    KMChecker *checker = nil;
    NSArray *filteredArray = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"color == %i", color];
    if(type == kBlack)
        filteredArray = [self.blackCheckers filteredArrayUsingPredicate:predicate];
    else
        filteredArray = [self.whiteCheckers filteredArrayUsingPredicate:predicate];
    
    if(filteredArray && filteredArray.count > 0)
        checker = [filteredArray firstObject];
    
    checker.active = YES;
}

#pragma mark - KMCheckerDelegate

- (void)moveFinished:(KMChecker *)checker
{
    [self findNextActiveCheckerWithColor:checker.color andType:checker.type];
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
        //if(self.active) [self showGlowAnimation:NO];
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
        
        //if(self.active) [self showGlowAnimation:YES];
        [self moveFinished:checker];
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:checker.superview];
}

@end
