//
//  TransitionController.m
//  ViewControllerTransitionTest
//
//  Created by David Robles on 10/17/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import "TransitionController.h"
#import "UIView+AnimationOptionsWithCurve.h"

@implementation TransitionController {
    UINavigationController *_navigationController;
    CGFloat _startScale;
    id <UIViewControllerContextTransitioning> _context;
    CGFloat _percentComplete;
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

#pragma mark - UIViewControllerAnimatedTransitioning methods

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _context = transitionContext;
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [self fromView];
    UIView *toView = [self toView];
    
    if (_navigationOperation == UINavigationControllerOperationPush) {
        //Add 'to' view to the hierarchy with 0.0 scale
        toView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        [containerView insertSubview:toView aboveSubview:fromView];
        
        //Scale the 'to' view to to its final position
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else if (_navigationOperation == UINavigationControllerOperationPop) {
        //Add 'to' view to the hierarchy
        [containerView insertSubview:toView belowSubview:fromView];
        
        //Scale the 'from' view down until it disappears
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        } completion:^(BOOL finished) {
            BOOL didComplete = ![transitionContext transitionWasCancelled];
            [transitionContext completeTransition:didComplete]; // [UIViewControllerContextTransitioning completeTransition:] takes care of removing the from view controller's view from the view hierarchy
        }];
    }
}

- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"completed: %@", transitionCompleted ? @"YES": @"NO");
    
    _context = nil;
    _isInteractive = NO;
}

#pragma mark - UIViewControllerInteractiveTransitioning methods

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _context = transitionContext;
    _percentComplete = 0;
    UIView *containerView = [_context containerView];
    [containerView insertSubview:[self toView] belowSubview:[self fromView]];
}

- (CGFloat)completionSpeed {
    return 2.0;
}

- (UIViewAnimationCurve)completionCurve {
    return UIViewAnimationCurveEaseInOut;
}

#pragma mark - Gesture handling

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = [sender scale];
    
    switch ([sender state]) {
        case UIGestureRecognizerStateBegan:
            _startScale = scale;
            _isInteractive = YES;
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

- (BOOL)isInteractive {
    return _isInteractive;
}

#pragma mark - lib

- (UIView *)toView {
    return [[_context viewControllerForKey:UITransitionContextToViewControllerKey] view];
}

- (UIView *)fromView {
    return [[_context viewControllerForKey:UITransitionContextFromViewControllerKey] view];
}

- (void)updateWithProgress:(CGFloat)progress {
    if (!_context) {
        return;
    }
    _percentComplete = progress;
    [_context updateInteractiveTransition:progress];
    
    UIView *fromView = [self fromView];
    fromView.transform = CGAffineTransformMakeScale(1.0-_percentComplete, 1.0-_percentComplete);
}

- (void)endInteractionWithSuccess:(BOOL)success {
    if (!_context) {
        return;
    }
    
    if ((_percentComplete > 0.5) && success) {
        [_context finishInteractiveTransition];
        
        UIView *fromView = [self fromView];
        [UIView animateWithDuration:[self completionDuration] delay:0.0f options:[UIView animationOptionsWithCurve:[self completionCurve]] animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        } completion:^(BOOL finished) {
            [_context completeTransition:YES]; // [UIViewControllerContextTransitioning completeTransition:] takes care of removing the from view controller's view from the view hierarchy
        }];
    }
    else {
        [_context cancelInteractiveTransition];
        
        UIView *fromView = [self fromView];
        [UIView animateWithDuration:[self completionDuration] delay:0.0f options:[UIView animationOptionsWithCurve:[self completionCurve]] animations:^{
            fromView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [_context completeTransition:NO]; // [UIViewControllerContextTransitioning completeTransition:] takes care of removing the from view controller's view from the view hierarchy
        }];
    }
}

- (CGFloat)completionDuration {
    CGFloat retFloat = (_percentComplete * [self transitionDuration:_context]) / [self completionSpeed];
    return retFloat;
}

@end
