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
@property (nonatomic, strong) NSArray *playFieldMap;
@end

@implementation KMPlayField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [self prepare];
    
    return self;
}

- (void)prepare
{
    self.playFieldMap = [NSMutableArray arrayWithArray:DEFAULT_POSITION_MAP];
}


@end
