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
  
  BOOL _visible;
  BOOL _needsRefresh;
}

@property (assign, nonatomic) UINavigationController *navigationController;

@property (readonly, nonatomic) YKUINavigationBar *navigationBar;

@property (readonly, nonatomic, getter=isVisible) BOOL visible;
@property (assign, nonatomic) BOOL needsRefresh;

/*!
 @result Returns UIViewController for this view.
 Do not override. For a custom view controller, use viewControllerForView.
 This method registers the view controller.
 */
- (YKTUIViewController *)newViewController:(UINavigationController *)navigationController;

/*!
 @param create If YES, will create the view controller if it hasn't been created already.
 @result View controller
 */
//- (YKTUIViewController *)viewController:(BOOL)create;

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
 Swap the current view with transition.
 @param view
 @param transition
 @param duration
 */
- (void)swapView:(YKTUIView *)view transition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

/*!
 Pop to root view.
 @param animated
 */
- (void)popToRootViewAnimated:(BOOL)animated;

/*!
 Pop the current view.
 @param animated
 */
- (void)popViewAnimated:(BOOL)animated;

/*!
 Pop to view.
 @param view
 @param animated
 */
- (void)popToView:(YKTUIView *)view animated:(BOOL)animated;

/*!
 Set navigation title.
 */
- (void)setNavigationTitle:(NSString *)title animated:(BOOL)animated;

/*!
 Set navigation button with title.
 @param title
 @param iconImage
 @param position
 @param style
 @param animated
 */
- (YKUIButton *)setNavigationButtonWithTitle:(NSString *)title iconImage:(UIImage *)iconImage position:(YKUINavigationPosition)position style:(YKUINavigationButtonStyle)style animated:(BOOL)animated target:(id)target action:(SEL)action;

/*!
 Apply style for navigation button.
 Subclasses should override.
 */
- (void)applyStyleForNavigationButton:(YKUIButton *)button style:(YKUINavigationButtonStyle)style;

/*!
 Apply style for navigation bar.
 Subclasses should override.
 */
- (void)applyStyleForNavigationBar:(YKUINavigationBar *)navigationBar;

/*!
 View will appear.
 @param animated
 */
- (void)viewWillAppear:(BOOL)animated;

/*!
 View did appear.
 @param animated
 */
- (void)viewDidAppear:(BOOL)animated;

/*!
 View will disappear.
 @param animated
 */
- (void)viewWillDisappear:(BOOL)animated;

/*!
 View did disappear.
 @param animated
 */
- (void)viewDidDisappear:(BOOL)animated;

/*!
 Refresh. On success, you should call self.needsRefresh = NO;
 */
- (void)refresh;

/*!
 Set needs refresh. If visible, will call refresh.
 */
- (void)setNeedsRefresh;

#pragma mark Private

- (void)_viewWillAppear:(BOOL)animated;

- (void)_viewDidAppear:(BOOL)animated;

- (void)_viewWillDisappear:(BOOL)animated;

- (void)_viewDidDisappear:(BOOL)animated;

@end
