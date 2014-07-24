//
//  KMMovementManager.h
//  Kamisado
//
//  Created by Max on 24.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KMPlayField;

@interface KMMovementManager : NSObject

+ (KMMovementManager *)instance;
- (void)setPlayField:(KMPlayField *)playField;

@end
