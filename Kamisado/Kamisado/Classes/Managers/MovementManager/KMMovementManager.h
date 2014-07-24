//
//  KMMovementManager.h
//  Kamisado
//
//  Created by Max on 24.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definitions.h"

@interface KMMovementManager : NSObject

+ (KMMovementManager *)instance;

- (CGPoint)convertCoordinatesIntoCellPosition:(CGPoint)coordinates;
- (CheckerColor)getCellColorAtPosition:(CGPoint)position;
- (CGPoint)getCellCenterAtPostion:(CGPoint)position;

- (BOOL)isMoveAllowedFromPosition:(CGPoint)oldPosition toPosition:(CGPoint)newPosition withCheckerType:(CheckerType)checkerType;

- (void)occupyCellAtPosition:(CGPoint)position;
- (void)emptyCellAtPosition:(CGPoint)position;

@end
