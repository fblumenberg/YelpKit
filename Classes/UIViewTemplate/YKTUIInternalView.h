//
//  YKTUIInternalView.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/12/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUILayoutView.h"

@interface YKTUIInternalView : YKUILayoutView {
  UIView *_navigationView;
  UIView *_progressView;
  UIView *_headerView;
  UIView *_footerView;
  UIView *_view;
}

@property (retain, nonatomic) UIView *navigationView;
@property (retain, nonatomic) UIView *progressView;
@property (retain, nonatomic) UIView *headerView;
@property (retain, nonatomic) UIView *view;
@property (retain, nonatomic) UIView *footerView;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

@end
