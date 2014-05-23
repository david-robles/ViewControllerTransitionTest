//
//  DebugNavigationController.m
//  ViewControllerTransitionTest
//
//  Created by David Robles on 5/9/14.
//  Copyright (c) 2014 955 Dreams. All rights reserved.
//

#import "DebugNavigationController.h"

@interface UINavigationController ()
- (void)_navigationTransitionView:(id)arg1 didCancelTransition:(int)arg2 fromViewController:(id)arg3 toViewController:(id)arg4 wrapperView:(id)arg5;
- (void)navigationTransitionView:(id)arg1 didEndTransition:(int)arg2 fromView:(id)arg3 toView:(id)arg4;
- (void)navigationTransitionView:(id)arg1 didStartTransition:(int)arg2;
@end

@implementation DebugNavigationController

- (void)navigationTransitionView:(id)navigationTransitionView didEndTransition:(int)transition fromView:(id)fromView toView:(id)toView {
    [super navigationTransitionView:navigationTransitionView didEndTransition:transition fromView:fromView toView:toView];
    NSLog(@"\n\nnavigationTransitionView: %@\n\ndidEndTransition: %d\n\nfromView: %@\n\ntoView: %@", navigationTransitionView, transition, fromView, toView);
}

- (void)_navigationTransitionView:(id)arg1 didCancelTransition:(int)arg2 fromViewController:(id)arg3 toViewController:(id)arg4 wrapperView:(id)arg5 {
    [super _navigationTransitionView:arg1 didCancelTransition:arg2 fromViewController:arg3 toViewController:arg4 wrapperView:arg5];
    NSLog(@"\n\n_navigationTransitionView: %@\n\ndidCancelTransition: %d\n\nfromViewController: %@\n\ntoViewController: %@\n\nwrapperView: %@", arg1, arg2, arg3, arg4, arg5);
}

@end
