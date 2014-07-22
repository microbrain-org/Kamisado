//
//  KMChecker.h
//  Kamisado
//
//  Created by Max on 22.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kBrown,
    kCyan,
    kBlue,
    kYellow,
    kMagenta,
    kGreen,
    kRed,
    kOrange
} CheckerColor;

typedef enum : NSUInteger {
    kBlack,
    kWhite
} CheckerType;

@interface KMChecker : UIImageView

- (instancetype)initWithColor:(CheckerColor)color type:(CheckerType)type position:(CGPoint)position;

@end
