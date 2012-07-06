//
//  YKSUIInternalView.m
//  YelpKit
//
//  Created by Gabriel Handford on 7/5/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKSUIInternalView.h"
#import "YKSUIView.h"
#import "YKSUIStack.h"

@implementation YKSUIInternalView

@synthesize view=_view;

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
  [_view release];
  [super dealloc];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat y = 0;
  CGSize contentSize = size;
  
  UIView *navigationBar = _view.navigationBar;
  if (navigationBar && !navigationBar.hidden) {
    CGRect navigationBarFrame = [layout setFrame:CGRectMake(0, y, size.width, 0) view:navigationBar sizeToFit:YES];    
    y += navigationBarFrame.size.height;
    contentSize.height -= navigationBarFrame.size.height;
  }
  
  CGRect contentFrame = CGRectMake(0, y, contentSize.width, contentSize.height);
  // This prevents UIScrollViews from causing a layoutSubviews call after setFrame.
  //if (!YKCGRectIsEqual(contentFrame, _contentView.frame)) {
  [layout setFrame:contentFrame view:_view];    
  
  return size;
}

- (void)setView:(YKSUIView *)view {
  [_view removeFromSuperview];
  [view retain];
  [_view release];  
  _view = view;
  [self addSubview:_view];
  
  // Navigation bar
  if (_view.navigationBar) {
    [self addSubview:_view.navigationBar];
  }
  
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)viewWillAppear:(BOOL)animated {
  [_view _viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [_view viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [_view viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [_view viewDidDisappear:animated];
}

@end

