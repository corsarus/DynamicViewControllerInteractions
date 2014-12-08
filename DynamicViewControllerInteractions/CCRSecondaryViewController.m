//
//  CCRSecondaryViewController.m
//  DynamicViewControllerInteractions
//
//  Created by admin on 04/12/14.
//  Copyright (c) 2014 corsarus. All rights reserved.
//

#import "CCRSecondaryViewController.h"
#import "CCRTransitionAnimator.h"

@interface CCRSecondaryViewController() <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) CCRTransitionAnimator *transitionAnimator;

@end

@implementation CCRSecondaryViewController

- (CCRTransitionAnimator *)transitionAnimator
{
    if (!_transitionAnimator) {
        _transitionAnimator = [[CCRTransitionAnimator alloc] init];
    }
    
    return _transitionAnimator;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // The view controller is full screen
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (IBAction)dismiss:(id)sender {
    self.transitioningDelegate = self;

    if ([self.presentingViewController conformsToProtocol:@protocol(CCRTransitionDelegate)]) {
        self.transitionAnimator.delegate = (id<CCRTransitionDelegate>)self.presentingViewController;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - Transitioning animator delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.transitionAnimator;
}


@end
