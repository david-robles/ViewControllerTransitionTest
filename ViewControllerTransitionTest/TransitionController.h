//
//  TransitionController.h
//  ViewControllerTransitionTest
//
//  Created by David Robles on 10/17/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PercentDrivenTransitionController.h"

@interface TransitionController : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic) UINavigationControllerOperation navigationOperation;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (BOOL)isInteractive;

@end
