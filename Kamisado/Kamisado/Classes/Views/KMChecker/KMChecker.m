//
//  KMChecker.m
//  Kamisado
//
//  Created by Max on 22.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#import "KMChecker.h"
#import "Definitions.h"

@interface KMChecker ()
@property (nonatomic, readwrite) CheckerColor color;
@property (nonatomic, readwrite) CheckerType type;

@property (nonatomic, strong) UIView *bacgroundView;
@property (nonatomic, strong) CALayer *backroundLayer;
@property (nonatomic, strong) CALayer *imageLayer;
@end

@implementation KMChecker

- (instancetype)initWithColor:(CheckerColor)color type:(CheckerType)type position:(CGPoint)position
{
    self = [super init];
    
    if(self)
    {
        self.color = color;
        self.type = type;
        self.position = position;
    
        [self setup];
    }
    
    return self;
}


#pragma mark - Setters

- (void)setActive:(BOOL)active
{
    _active = active;
    
    self.userInteractionEnabled = _active;
    //[self showGlowAnimation:_active];
}

#pragma mark - Private Methods

- (void)showGlowAnimation:(BOOL)show
{
    self.backroundLayer.shadowOpacity = show ? 1.0 : 0.0;
    self.backroundLayer.shadowColor = show ? [UIColor whiteColor].CGColor : [UIColor clearColor].CGColor;
    self.backroundLayer.shadowRadius = show ? 10.0 : 0.0;
    self.backroundLayer.shadowOffset = CGSizeZero;
    self.backroundLayer.backgroundColor = show ? [UIColor whiteColor].CGColor : [UIColor clearColor].CGColor;
    
    if(show)
    {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = @(0);
        animation.toValue = @(0.6);
        animation.repeatCount = HUGE_VAL;
        animation.duration = 1.0;
        animation.autoreverses = YES;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.backroundLayer addAnimation:animation forKey:@"pulse"];
    }
    else
        [self.backroundLayer removeAllAnimations];
}

#pragma mark - Setup View

- (void)setup
{
    self.frame = CGRectMake(self.position.x * CELL_SIZE.width + 1, self.position.y * CELL_SIZE.height + 1, CELL_SIZE.width - 2, CELL_SIZE.height - 2);
    
    [self setupImageLayer];
    
    self.backroundLayer = [CALayer layer];
    self.backroundLayer.frame = self.layer.bounds;
    [self.layer insertSublayer:self.backroundLayer atIndex:0];
    
}

- (void)setupImageLayer
{
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = self.layer.bounds;
    self.imageLayer.contents = (id)[self prepareForegroundImage].CGImage;
    self.imageLayer.backgroundColor = (self.type == CheckerBlack) ? [UIColor blackColor].CGColor : [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageLayer.cornerRadius = 18.0;
    
    self.imageLayer.shadowColor = [UIColor blackColor].CGColor;
    self.imageLayer.shadowRadius = 4.0;
    self.imageLayer.shadowOpacity = 0.9;
    self.imageLayer.shadowOffset = CGSizeZero;
    self.imageLayer.masksToBounds = NO;
    
    [self.layer insertSublayer:self.imageLayer atIndex:1];
}

- (UIImage *)prepareForegroundImage
{
    UIImage *image = [UIImage imageNamed:@"checker_mask.png"];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [[self getColor] CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIColor *)getColor
{
    UIColor *color = [UIColor clearColor];
    switch (self.color) {
        case kBlue:    color = [UIColor blueColor];         break;
        case kBrown:   color = [UIColor brownColor];        break;
        case kGreen:   color = [UIColor greenColor];        break;
        case kMagenta: color = [UIColor magentaColor];      break;
        case kOrange:  color = [UIColor orangeColor];       break;
        case kRed:     color = [UIColor redColor];          break;
        case kCyan:    color = [UIColor cyanColor];         break;
        case kYellow:  color = [UIColor colorWithRed:0.85
                                               green:0.85
                                                blue:0.0
                                               alpha:1.0];  break;
        default:                                            break;
    }
    
    return color;
}

@end
