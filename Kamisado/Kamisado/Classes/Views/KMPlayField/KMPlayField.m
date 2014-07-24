//
//  KMPlayField.m
//  Kamisado
//
//  Created by Max on 22.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import "KMPlayField.h"
#import "Definitions.h"
#import "KMMovementManager.h"

@interface KMPlayField ()
@property (nonatomic, strong) NSArray *playField;
@end

@implementation KMPlayField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [self prepare];
    [[KMMovementManager instance] setPlayField:self];
    
    return self;
}

- (void)prepare
{
    self.playField = [NSMutableArray arrayWithArray:DEFAULT_POSITION_MAP];
}


@end
