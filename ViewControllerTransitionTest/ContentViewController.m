//
//  ViewController.m
//  ViewControllerTransitionTest
//
//  Created by David Robles on 10/17/13.
//  Copyright (c) 2013 955 Dreams. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews {
    
}

- (void)viewDidLayoutSubviews {
    
}

- (IBAction)pushMoreContentButtonTapped:(id)sender {
    UIViewController *parent = self.parentViewController;
    
    if ([parent respondsToSelector:@selector(pushViewController:animated:)]) {
//        [self performSegueWithIdentifier:@"ContentViewControllerBSegue" sender:sender];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ContentViewController *contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewControllerBScene"];
        
        UINavigationController *navController = (UINavigationController *)parent;
        
        [navController pushViewController:contentViewController animated:YES];
    }
}

- (IBAction)backButtonTapped:(id)sender {
    UIViewController *parent = self.parentViewController;
    
    if ([parent respondsToSelector:@selector(popViewControllerAnimated:)]) {
        UINavigationController *navController = (UINavigationController *)parent;
        [navController popViewControllerAnimated:YES];
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
}

- (void)removeFromParentViewController {
    [super removeFromParentViewController];
}

@end
