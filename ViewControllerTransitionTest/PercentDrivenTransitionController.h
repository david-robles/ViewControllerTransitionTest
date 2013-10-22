//
//  PercentDrivenTransitionController.h
//  ViewControllerTransitionTest
//
//  Created by David Robles on 10/21/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentDrivenTransitionController : UIPercentDrivenInteractiveTransition

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (BOOL)isInteractive;

@end
