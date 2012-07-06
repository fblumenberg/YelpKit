//
//  YKSUIStack.h
//  YelpKit
//
//  Created by Gabriel Handford on 7/5/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKSUIView.h"

@interface YKSUIStack : NSObject {
  NSMutableArray *_stack;
  UIView *_parentView;
}

- (id)initWithParentView:(UIView *)parentView;

- (void)pushView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options;

- (void)setView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options;

- (void)popView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options;

- (void)popToView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options;

- (void)swapView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options;

- (YKSUIView *)visibleView;

- (BOOL)isRootView:(YKSUIView *)view;

- (BOOL)isVisibleView:(YKSUIView *)view;

- (NSInteger)indexOfView:(YKSUIView *)view;

@end
