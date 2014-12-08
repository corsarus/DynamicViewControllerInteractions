//
//  CCRTransitionAnimator.h
//  DynamicViewControllerInteractions
//
//  Created by admin on 04/12/14.
//  Copyright (c) 2014 corsarus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCRTransitionDelegate <NSObject>

- (void)didFinishTransition;

@end

@interface CCRTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id<CCRTransitionDelegate> delegate;

@end
