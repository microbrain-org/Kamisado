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

@end
