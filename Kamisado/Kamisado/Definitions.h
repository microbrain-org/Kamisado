//
//  Definitions.h
//  Kamisado
//
//  Created by Max on 22.07.14.
//  Copyright (c) 2014 Noname. All rights reserved.
//

#ifndef Kamisado_Definitions_h
#define Kamisado_Definitions_h

#define DEFAULT_POSITION_MAP @[@[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)],\
                               @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(1)]]

#define FIELD_COLOR_MAP @[@[@(kOrange),@(kRed),@(kGreen),@(kMagenta),@(kYellow),@(kBlue),@(kCyan),@(kBrown)],\
                          @[@(kBlue),@(kOrange),@(kMagenta),@(kCyan),@(kRed),@(kYellow),@(kBrown),@(kGreen)],\
                          @[@(kCyan),@(kMagenta),@(kOrange),@(kBlue),@(kGreen),@(kBrown),@(kYellow),@(kRed)],\
                          @[@(kMagenta),@(kGreen),@(kRed),@(kOrange),@(kBrown),@(kCyan),@(kBlue),@(kYellow)],\
                          @[@(kYellow),@(kBlue),@(kCyan),@(kBrown),@(kOrange),@(kRed),@(kGreen),@(kMagenta)],\
                          @[@(kRed),@(kYellow),@(kBrown),@(kGreen),@(kBlue),@(kOrange),@(kMagenta),@(kCyan)],\
                          @[@(kGreen),@(kBrown),@(kYellow),@(kRed),@(kCyan),@(kMagenta),@(kOrange),@(kBlue)],\
                          @[@(kBrown),@(kCyan),@(kBlue),@(kYellow),@(kMagenta),@(kGreen),@(kRed),@(kOrange)]]

#define CELL_SIZE CGSizeMake(40.0, 40.0)

typedef enum : NSUInteger {
    kBrown = 0,
    kCyan,
    kBlue,
    kYellow,
    kMagenta,
    kGreen,
    kRed,
    kOrange
} CheckerColor;

typedef enum : NSUInteger {
    CheckerBlack,
    CheckerWhite
} CheckerType;

#endif
