//
//  YKTUIInternalView.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/12/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTUIInternalView.h"

@implementation YKTUIInternalView

@synthesize view=_view, progressView=_progressView, headerView=_headerView, footerView=_footerView, navigationView=_navigationView;

- (void)sharedInit {
  self.backgroundColor = [UIColor blackColor];
  self.opaque = YES;
  self.layout = [YKLayout layoutForView:self];
}

- (id)initWithCoder:(NSCoder *)coder {
  if ((self = [super initWithCoder:coder])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
  }
  return self;
}

- (void)dealloc {
  [_navigationView release];
  [_headerView release];
  [_footerView release];
  [_view release];
  [super dealloc];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat y = 0;
  CGSize contentSize = size;
  
  if (_navigationView && !_navigationView.hidden) {
    CGRect navigationViewFrame = [layout setFrame:CGRectMake(0, y, size.width, 0) view:_navigationView sizeToFit:YES];    
    y += navigationViewFrame.size.height;
    contentSize.height -= navigationViewFrame.size.height;
  }
  
  if (_progressView && !_progressView.hidden) {    
    CGRect progressViewFrame = [layout setFrame:CGRectMake(0, y, size.width, 0) view:_progressView sizeToFit:YES];
    y += progressViewFrame.size.height;
    contentSize.height -= progressViewFrame.size.height;
  }
  
  if (_headerView && !_headerView.hidden) {    
    CGRect headerViewFrame = [layout setFrame:CGRectMake(0, y, size.width, 0) view:_headerView sizeToFit:YES];
    y += headerViewFrame.size.height;
    contentSize.height -= headerViewFrame.size.height;
  }
  
  if (_footerView) {
    CGRect footerViewFrame = [layout setFrame:CGRectMake(0, y, size.width, 0) view:_footerView sizeToFit:YES];
    contentSize.height -= footerViewFrame.size.height;
  }
  
  CGRect contentFrame = CGRectMake(0, y, contentSize.width, contentSize.height);
  // This prevents UIScrollViews from causing a layoutSubviews call after setFrame.
  //if (!YKCGRectIsEqual(contentFrame, _contentView.frame)) {
  [layout setFrame:contentFrame view:_view];    
  
  return size;
}

- (void)setNavigationView:(UIView *)navigationView {
  [_navigationView removeFromSuperview];
  [navigationView retain];
  [_navigationView release];  
  _navigationView = navigationView;
  [self addSubview:_navigationView];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)setHeaderView:(UIView *)headerView {
  [_headerView removeFromSuperview];
  [headerView retain];
  [_headerView release];  
  _headerView = headerView;
  [self addSubview:_headerView];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)setFooterView:(UIView *)footerView {
  [_footerView removeFromSuperview];
  [footerView retain];
  [_footerView release];  
  _footerView = footerView;
  [self addSubview:_footerView];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)setProgressView:(UIView *)progressView {
  [_progressView removeFromSuperview];
  [progressView retain];
  [_progressView release];  
  _progressView = progressView;
  [self addSubview:_progressView];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)setView:(UIView *)view {
  [_view removeFromSuperview];
  [view retain];
  [_view release];  
  _view = view;
  [self addSubview:_view];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated {
  if ([_view respondsToSelector:@selector(viewWillAppear:)]) {
    [(id)_view viewWillAppear:animated];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  if ([_view respondsToSelector:@selector(viewDidAppear:)]) {
    [(id)_view viewDidAppear:animated];
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  if ([_view respondsToSelector:@selector(viewWillDisappear:)]) {
    [(id)_view viewWillDisappear:animated];
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  if ([_view respondsToSelector:@selector(viewDidDisappear:)]) {
    [(id)_view viewDidDisappear:animated];
  }
}

@end
