//
//  YKTUIViewController.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUINavigationBar.h"
#import "YKUIButton.h"
#import "YKTUIView.h"

@class YKTUIInternalView;
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
  YKTUIInternalView *_templateView;
  
  id<YKTUIViewControllerViewDelegate> _viewDelegate;
}

@property (nonatomic, readonly) YKTUIInternalView *templateView;
@property (assign, nonatomic) id<YKTUIViewControllerViewDelegate> viewDelegate;

/*!
 Set the content view for this view controller.
 */
- (void)setContentView:(YKTUIView *)view;

@end


@interface YKTUIInternalView : YKUILayoutView {
  UIView *_progressView;
  UIView *_headerView;
  UIView *_footerView;
  
  YKTUIView *_view;
}

@property (retain, nonatomic) UIView *progressView;
@property (retain, nonatomic) UIView *headerView;
@property (retain, nonatomic) YKTUIView *view;
@property (retain, nonatomic) UIView *footerView;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

@end
