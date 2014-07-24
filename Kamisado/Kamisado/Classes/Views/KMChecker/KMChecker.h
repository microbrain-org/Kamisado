//
//  KMChecker.h
//  Kamisado
//
//  Created by Max on 22.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"

@interface KMChecker : UIImageView

@property (nonatomic, assign) BOOL active;
@property (nonatomic, readonly) CheckerColor color;
@property (nonatomic, readonly) CheckerType type;
@property (nonatomic, assign) CGPoint position;

- (instancetype)initWithColor:(CheckerColor)color type:(CheckerType)type position:(CGPoint)position;

@end
