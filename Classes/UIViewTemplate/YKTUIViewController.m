//
//  YKTUIViewController.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTUIViewController.h"
#import "YKUIButton.h"
#import "YKLocalized.h"

@implementation YKTUIViewController

@synthesize templateView=_templateView, viewDelegate=_viewDelegate;

- (void)loadView {
  if (!_templateView) {
    _templateView = [[YKTUIInternalView alloc] init];
  }
  self.view = _templateView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if ([_viewDelegate respondsToSelector:@selector(viewController:viewWillAppear:)]) {
    [_viewDelegate viewController:self viewWillAppear:animated];
  }
  [_templateView viewWillAppear:animated];
  
  // Set back button on navigation bar if not left button
  if (self.navigationController && _templateView.view.navigationBar) {
    if (!_templateView.view.navigationBar.leftButton) {
      NSUInteger index = [[self.navigationController viewControllers] indexOfObject:self];
      if (index > 0 && index != NSNotFound) {      
        
        UIViewController *previousViewController = [[self.navigationController viewControllers] objectAtIndex:(index - 1)];
        NSString *backTitle = previousViewController.title;
        if (!backTitle || [backTitle length] > 8) backTitle = NSLocalizedString(@"Back", nil);
        YKUIButton *backButton = [[YKUIButton alloc] init];
        backButton.title = backTitle;
        backButton.borderStyle = YKUIBorderStyleRoundedBack;
        [_templateView.view applyStyleForNavigationButton:backButton style:YKUINavigationButtonStyleBack];
        [backButton setTarget:self action:@selector(_back)];
        _templateView.view.navigationBar.leftButton = backButton;
        [backButton release];
      }
    }
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if ([_viewDelegate respondsToSelector:@selector(viewController:viewDidAppear:)]) {
    [_viewDelegate viewController:self viewDidAppear:animated];
  }
  [_templateView viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if ([_viewDelegate respondsToSelector:@selector(viewController:viewWillDisappear:)]) {
    [_viewDelegate viewController:self viewWillDisappear:animated];
  }
  [_templateView viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  if ([_viewDelegate respondsToSelector:@selector(viewController:viewDidDisappear:)]) {
    [_viewDelegate viewController:self viewDidDisappear:animated];
  }
  [_templateView viewDidDisappear:animated];
}

- (void)setCloseBlock:(UIControlTargetBlock)closeBlock {
  [self view];  
  YKUIButton *closeButton = [[YKUIButton alloc] init];
  closeButton.title = NSLocalizedString(@"Close", nil);
  closeButton.borderStyle = YKUIBorderStyleRounded;
  [_templateView.view applyStyleForNavigationButton:closeButton style:YKUINavigationButtonStyleClose];
  closeButton.targetBlock = closeBlock;
  _templateView.view.navigationBar.leftButton = closeButton;
}

- (void)_back {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)setContentView:(YKTUIView *)view {
  [self view];
  [_templateView setView:view];
}

- (BOOL)isContentView:(YKTUIView *)view {
  return ([view isEqual:[_templateView view]]);
}

@end


@implementation YKTUIInternalView

@synthesize view=_view, progressView=_progressView, headerView=_headerView, footerView=_footerView;

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
  [_headerView release];
  [_footerView release];
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

- (void)setView:(YKTUIView *)view {
  [_view removeFromSuperview];
  [view retain];
  [_view release];  
  _view = view;
  [self addSubview:_view];

  // Navigation bar
  [self addSubview:_view.navigationBar];
  
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
