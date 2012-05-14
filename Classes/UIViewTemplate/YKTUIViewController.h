//
//  YKTUIViewController.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUINavigationBar.h"
#import "YKTUIInternalView.h"
#import "YKUIButton.h"

@class YKTUIViewController;

@protocol YKTUIViewControllerViewDelegate <NSObject>
@optional
- (void)viewController:(YKTUIViewController *)viewController viewWillAppear:(BOOL)animated;
- (void)viewController:(YKTUIViewController *)viewController viewDidAppear:(BOOL)animated;
- (void)viewController:(YKTUIViewController *)viewController viewWillDisappear:(BOOL)animated;
- (void)viewController:(YKTUIViewController *)viewController viewDidDisappear:(BOOL)animated;
@end

/*!
 View controller with template view and navigation bar.
 */
@interface YKTUIViewController : UIViewController {
@private
  YKUINavigationBar *_navigationBar;
  YKTUIInternalView *_templateView;
  
  id<YKTUIViewControllerViewDelegate> _viewDelegate;
}

@property (nonatomic, readonly) YKUINavigationBar *navigationBar;
@property (nonatomic, readonly) YKTUIInternalView *templateView;
@property (assign, nonatomic) id<YKTUIViewControllerViewDelegate> viewDelegate;

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
 Set the content view for this view controller.
 */
- (void)setContentView:(UIView *)view;

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

@end
