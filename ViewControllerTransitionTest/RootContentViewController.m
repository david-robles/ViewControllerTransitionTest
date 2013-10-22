//
//  RootContentViewController.m
//  ViewControllerTransitionTest
//
//  Created by David Robles on 10/17/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import "RootContentViewController.h"
#import "TransitionController.h"
#import "PercentDrivenTransitionController.h"

@interface RootContentViewController () <UINavigationControllerDelegate>

@end

@implementation RootContentViewController {
    UINavigationController *_navigationController;
    TransitionController *_animatedTransitionController;
    id _interactiveTransitionController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    _navigationController = (UINavigationController *)self.parentViewController;
    _navigationController.delegate = self;

    _animatedTransitionController = [[TransitionController alloc] initWithNavigationController:_navigationController];
//    _interactiveTransitionController = [[PercentDrivenTransitionController alloc] initWithNavigationController:_navigationController];
    _interactiveTransitionController = _animatedTransitionController;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    [_animatedTransitionController setNavigationOperation:operation];
    return _animatedTransitionController;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if ([(TransitionController *)animationController navigationOperation] == UINavigationControllerOperationPop && [_interactiveTransitionController isInteractive]) {
        return _interactiveTransitionController;
    }
    
    return nil;
}


@end
