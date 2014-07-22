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

@interface KMPlayViewController ()

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

#pragma mark - Private Methods

- (void)prepareCheckers
{
    NSArray *colors = @[@(kOrange), @(kBlue), @(kCyan), @(kMagenta), @(kYellow), @(kRed), @(kGreen), @(kBrown)];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:8];
    for(int i = 0; i < 8; i++)
    {
        CheckerColor color = (CheckerColor)[colors[i] integerValue];
        KMChecker *checker = [[KMChecker alloc] initWithColor:color type:kWhite position:CGPointMake(i, 0)];
        if(i == 3)
            checker.highlighted = YES;
        [array addObject:checker];
    }
    self.whiteCheckers = [array copy];
    [array removeAllObjects];
    
    for(int i = 0; i < 8; i++)
    {
        CheckerColor color = (CheckerColor)[colors[7 - i] integerValue];
        KMChecker *checker = [[KMChecker alloc] initWithColor:color type:kBlack position:CGPointMake(i, 7)];
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


@end
