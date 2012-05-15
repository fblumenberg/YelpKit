//
//  YKTUIView.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUILayoutView.h"

@class YKTUIViewController;

@interface YKTUIView : YKUILayoutView {
  YKTUIViewController *_viewController;
}

/*!
 Weak, set if newViewController method is used.
 */
@property (readonly, assign, nonatomic) UIViewController *viewController;

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
 @param title
 @param animated
 */
- (void)setNavigationTitle:(NSString *)title animated:(BOOL)animated;


- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

@end
