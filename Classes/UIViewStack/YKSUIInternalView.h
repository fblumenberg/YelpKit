//
//  YKSUIInternalView.h
//  YelpKit
//
//  Created by Gabriel Handford on 7/5/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUILayoutView.h"
@class YKSUIView;

@interface YKSUIInternalView : YKUILayoutView {
  YKSUIView *_view;
}

@property (retain, nonatomic) YKSUIView *view;

- (void)viewWillAppear:(BOOL)animated;

- (void)viewDidAppear:(BOOL)animated;

- (void)viewWillDisappear:(BOOL)animated;

- (void)viewDidDisappear:(BOOL)animated;

@end