//
//  CCRTransitionAnimator.m
//  DynamicViewControllerInteractions
//
//  Created by admin on 04/12/14.
//  Copyright (c) 2014 corsarus. All rights reserved.
//

#import "CCRTransitionAnimator.h"

@implementation CCRTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerViewBackground = [[UIView alloc] initWithFrame:transitionContext.containerView.bounds];
    containerViewBackground.backgroundColor = [UIColor lightGrayColor];
    
    if ([toViewController isKindOfClass:NSClassFromString(@"CCRSecondaryViewController")]) {
        
        [transitionContext.containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
        [transitionContext.containerView insertSubview:containerViewBackground belowSubview:toViewController.view];
        
        toViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             // Increase the size of the presented view
                             toViewController.view.transform = CGAffineTransformIdentity;
                             // Push the presenting view out of the screen through the left edge
                             fromViewController.view.transform = CGAffineTransformMakeTranslation(toViewController.view.frame.size.width, 0);
                         }
                         completion:^(BOOL finished) {
                             fromViewController.view.transform = CGAffineTransformIdentity;
                             
                             if ([transitionContext transitionWasCancelled]) {
                                 // Trigger the bouncing animation if the transition was cancelled
                                 [self.delegate didFinishTransition];
                             }
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
        
    } else if ([toViewController isKindOfClass:NSClassFromString(@"CCRContainerViewController")]) {
        
        [transitionContext.containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
        toViewController.view.transform = CGAffineTransformMakeTranslation(toViewController.view.frame.size.width, 0);
        [transitionContext.containerView insertSubview:containerViewBackground belowSubview:fromViewController.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             // Slide the presenting view back onto the screen
                             toViewController.view.transform = CGAffineTransformIdentity;
                             // Reduce the size of the presented view
                             fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         }
         
                         completion:^(BOOL finished) {
                             fromViewController.view.transform = CGAffineTransformIdentity;
                             // Trigger the bouncing animation when the transition is finished
                             [self.delegate didFinishTransition];
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
        
    }
}

@end
