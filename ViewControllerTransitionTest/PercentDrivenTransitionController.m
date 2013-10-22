//
//  PercentDrivenTransitionController.m
//  ViewControllerTransitionTest
//
//  Created by David Robles on 10/21/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import "PercentDrivenTransitionController.h"

@implementation PercentDrivenTransitionController {
    UINavigationController *_navigationController;
    CGFloat _startScale;
    BOOL _isInteractive;
}

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _navigationController = navigationController;
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [_navigationController.view addGestureRecognizer:pinchGesture];
    }
    
    return self;
}

- (BOOL)isInteractive {
    return _isInteractive;
}

#pragma mark - Gesture handling

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = [sender scale];
    
    switch ([sender state]) {
        case UIGestureRecognizerStateBegan:
            _isInteractive = YES;
            _startScale = scale;
            [_navigationController popViewControllerAnimated:YES];
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = (1.0 - scale/_startScale);
            [self updateWithProgress:(percent <= 0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self endInteractionWithSuccess:YES];
            break;
            
        case UIGestureRecognizerStateCancelled:
            [self endInteractionWithSuccess:NO];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - lib

- (void)updateWithProgress:(CGFloat)progress {
    [self updateInteractiveTransition:progress];
}


- (void)endInteractionWithSuccess:(BOOL)success {
    if ((self.percentComplete > 0.5) && success) {
        [self finishInteractiveTransition];
    }
    else {
        [self cancelInteractiveTransition];
    }
    
    _isInteractive = NO;
}

@end
