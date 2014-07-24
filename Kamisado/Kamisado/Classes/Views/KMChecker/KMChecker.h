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

@class KMChecker;

@protocol KMCheckerDelegate <NSObject>
- (void)moveFinished:(KMChecker *)checker;
@end

@interface KMChecker : UIImageView

@property (nonatomic, assign) BOOL active;
@property (nonatomic, readonly) CheckerColor color;
@property (nonatomic, readonly) CheckerType type;

- (instancetype)initWithColor:(CheckerColor)color type:(CheckerType)type position:(CGPoint)position delegate:(id <KMCheckerDelegate>)delegate;

@end
