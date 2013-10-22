//
//  UIView+AnimationOptionsWithCurve.m
//  ApplauzeDev
//
//  Created by David Robles on 1/31/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import "UIView+AnimationOptionsWithCurve.h"

@implementation UIView (AnimationOptionsWithCurve)

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve {
    return curve << 16;
}

@end
