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
  YKTUIViewController *_viewController;
}

/*!
 Weak, set if newViewController method is used.
 */
@property (readonly, assign, nonatomic) UIViewController *viewController;
@property (readonly, nonatomic) YKUINavigationBar *navigationBar;

/*!
 Returns UIViewController for this view.
 Do not override. For a custom view controller, use viewControllerForView.
 This method registers the view controller.
 */
- (YKTUIViewController *)newViewController;

/*!
 Returns UIViewController for this view.
 */
- (YKTUIViewController *)viewControllerForView;

/*!
 Push view.
 */
- (void)pushView:(YKUILayoutView *)view animated:(BOOL)animated;

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
