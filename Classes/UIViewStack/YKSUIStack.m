//
//  YKSUIStack.m
//  YelpKit
//
//  Created by Gabriel Handford on 7/5/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKSUIStack.h"
#import "YKCGUtils.h"
#import "YKSUIInternalView.h"

@implementation YKSUIStack

- (id)init {
  if ((self = [super init])) {
    _stack = [[NSMutableArray alloc] init];
  }
  return self;
}

- (id)initWithParentView:(UIView *)parentView {
  if ((self = [self init])) {
    _parentView = parentView;
  }
  return self;
}

- (void)dealloc {
  [_stack release];
  [super dealloc];
}

- (void)pushView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options {
  [self _addView:view duration:duration options:options];
}

- (void)popToView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options {
  NSInteger index = [self indexOfView:view];
  if (index == NSNotFound) return;
  NSMutableArray *viewsToRemove = [[NSMutableArray alloc] initWithCapacity:[_stack count]];
  for (YKSUIInternalView *viewInStack in _stack) {
    if ([viewInStack isEqual:view]) break;
    [viewsToRemove addObject:viewInStack];
  }
  for (YKSUIInternalView *viewToRemove in viewsToRemove) {
    [self _removeInternalView:viewToRemove duration:0 options:0 completion:NULL];
  }
  [viewsToRemove release];
}

- (void)popView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options {
  YKSUIInternalView *internalView = [_stack lastObject];
  if (!internalView || ![internalView.view isEqual:view]) return;
  [self _removeInternalView:internalView duration:duration options:options completion:NULL];
  
}

- (void)swapView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options {
  YKSUIInternalView *internalView = [_stack lastObject];
  if (internalView) {
    [self _removeInternalView:internalView duration:0 options:0 completion:NULL];
  }
  [self _addView:view duration:0 options:0];
}

- (void)setView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options {
  for (YKSUIInternalView *internalView in _stack) {
    [self _removeInternalView:internalView duration:0 options:0 completion:NULL];
  }
  [self _addView:view duration:0 options:0];
}

- (void)_removeInternalView:(YKSUIInternalView *)internalView duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion {
  if ((options & YKSUIViewAnimationOptionSlide) == YKSUIViewAnimationOptionSlide) {
    [internalView viewWillDisappear:NO];
    [UIView animateWithDuration:duration delay:0 options:[self animationOptions:options] animations:^{
      internalView.frame = CGRectMake(_parentView.frame.size.width, 20, _parentView.frame.size.width, _parentView.frame.size.height - 20);
    } completion:^(BOOL finished) {
      [internalView removeFromSuperview];
      [internalView viewDidDisappear:NO];
      internalView.view.stack = nil;
      if (completion) completion(finished);
      [_stack removeObject:internalView];
    }];
  } else {
    [internalView viewWillDisappear:NO];
    [internalView removeFromSuperview];
    [internalView viewDidDisappear:NO];
    internalView.view.stack = nil;
    if (completion) completion(YES);
    [_stack removeObject:internalView];
  }
}

- (UIViewAnimationOptions)animationOptions:(YKSUIViewAnimationOptions)options {
  UIViewAnimationOptions animationOptions = 0;
  animationOptions |= (options & YKSUIViewAnimationOptionCurveEaseInOut);
  animationOptions |= (options & YKSUIViewAnimationOptionCurveEaseIn);
  animationOptions |= (options & YKSUIViewAnimationOptionCurveEaseOut);
  animationOptions |= (options & YKSUIViewAnimationOptionCurveLinear);
  return animationOptions;
}

- (void)_addView:(YKSUIView *)view duration:(NSTimeInterval)duration options:(YKSUIViewAnimationOptions)options {
  YKSUIInternalView *internalView = [[YKSUIInternalView alloc] init];
  [internalView setView:view];
  internalView.view.stack = self;
  [_stack addObject:internalView];
  
  if ((options & YKSUIViewAnimationOptionSlide) == YKSUIViewAnimationOptionSlide) {
    internalView.frame = CGRectMake(_parentView.frame.size.width, 20, _parentView.frame.size.width, _parentView.frame.size.height - 20);
    [internalView viewWillAppear:NO];
    [_parentView addSubview:internalView];
    [UIView animateWithDuration:duration delay:0 options:[self animationOptions:options] animations:^{
      internalView.frame = CGRectMake(0, 20, _parentView.frame.size.width, _parentView.frame.size.height - 20);
    } completion:^(BOOL finished) {
      [internalView viewDidAppear:YES];  
    }];
  } else {
    internalView.frame = CGRectMake(0, 20, _parentView.frame.size.width, _parentView.frame.size.height - 20);
    [internalView viewWillAppear:NO];
    [_parentView addSubview:internalView];
    [internalView viewDidAppear:NO];
  }
}

- (NSInteger)indexOfView:(YKSUIView *)view {
  for (NSInteger i = 0, count = [_stack count]; i < count; i++) {
    YKSUIInternalView *internalView = [_stack objectAtIndex:i];
    if ([internalView.view isEqual:view]) return i;
  }
  return NSNotFound;
}

- (BOOL)isVisibleView:(YKSUIView *)view {
  return [view isEqual:[self visibleView]];
}

- (BOOL)isRootView:(YKSUIView *)view {
  return [view isEqual:[self rootView]];
}

- (YKSUIView *)visibleView {
  YKSUIInternalView *internalView = [_stack lastObject];
  return internalView.view;
}

- (YKSUIView *)rootView {
  YKSUIInternalView *internalView = [_stack gh_firstObject];
  return internalView.view;
}

@end
