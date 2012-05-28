//
//  YKTUIView.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUILayoutView.h"
#import "YKUINavigationBar.h"
#import "YKUIButton.h"

@class YKTUIViewController;

@interface YKTUIView : YKUILayoutView {
  YKUINavigationBar *_navigationBar;
  
  UINavigationController *_navigationController;
  YKTUIViewController *_viewController;
}

@property (readonly, assign, nonatomic) YKTUIViewController *viewController;
@property (assign, nonatomic) UINavigationController *navigationController;

@property (readonly, nonatomic) YKUINavigationBar *navigationBar;

/*!
 @result Returns UIViewController for this view.
 Do not override. For a custom view controller, use viewControllerForView.
 This method registers the view controller.
 */
- (YKTUIViewController *)newViewController;

/*!
 @result Returns UIViewController for this view. Subclasses can override this method.
 */
- (YKTUIViewController *)viewControllerForView;

/*!
 Push view.
 @param view
 @param animated
 */
- (void)pushView:(YKUILayoutView *)view animated:(BOOL)animated;

/*!
 Set the main view.
 @param view
 @param animated
 */
- (void)setView:(YKTUIView *)view animated:(BOOL)animated;

/*!
 Pop then push view with transition.
 */
- (void)popPushView:(YKTUIView *)view transition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration cache:(BOOL)cache;

/*!
 Pop to root view.
 */
- (void)popToRootViewAnimated:(BOOL)animated;

/*!
 Set navigation title.
 */
- (void)setNavigationTitle:(NSString *)title animated:(BOOL)animated;

/*!
 Set left navigation button with title.
 */
- (YKUIButton *)setNavigationLeftButtonWithTitle:(NSString *)title animated:(BOOL)animated target:(id)target action:(SEL)action;

/*!
 Set right navigation button with title.
 */
- (YKUIButton *)setNavigationRightButtonWithTitle:(NSString *)title animated:(BOOL)animated target:(id)target action:(SEL)action;

/*!
 Apply style for navigation button.
 Subclasses should override.
 */
- (void)applyStyleForNavigationButton:(YKUIButton *)button;

/*!
 Apply style for navigation bar.
 Subclasses should override.
 */
- (void)applyStyleForNavigationBar:(YKUINavigationBar *)navigationBar;



- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;


@end
