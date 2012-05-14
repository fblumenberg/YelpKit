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

@synthesize navigationBar=_navigationBar, templateView=_templateView, viewDelegate=_viewDelegate;

- (void)loadView {
  [_templateView release];
  _templateView = [[YKTUIInternalView alloc] init];
  
  _navigationBar = [[YKUINavigationBar alloc] init];
  [self applyStyleForNavigationBar:_navigationBar];
  [_templateView setNavigationView:_navigationBar];
  [_navigationBar release];
  
  self.view = _templateView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if ([_viewDelegate respondsToSelector:@selector(viewController:viewWillAppear:)]) {
    [_viewDelegate viewController:self viewWillAppear:animated];
  }
  [_templateView viewWillAppear:animated];
  
  // Set back button on navigation bar if not left button
  if (self.navigationController && _navigationBar) {
    if (!_navigationBar.leftButton) {
      NSUInteger index = [[self.navigationController viewControllers] indexOfObject:self];
      if (index > 0 && index != NSNotFound) {      
        
        UIViewController *previousViewController = [[self.navigationController viewControllers] objectAtIndex:(index - 1)];
        NSString *backTitle = previousViewController.title;
        if (!backTitle || [backTitle length] > 8) backTitle = NSLocalizedString(@"Back", nil);
        YKUIButton *backButton = [[YKUIButton alloc] init];
        backButton.title = backTitle;
        backButton.borderStyle = YKUIBorderStyleRoundedBack;
        [self applyStyleForNavigationButton:backButton];
        [backButton setTarget:self action:@selector(_back)];
        _navigationBar.leftButton = backButton;
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

- (void)_back {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationTitle:(NSString *)title animated:(BOOL)animated {
  [self view];
  [_navigationBar setTitle:title animated:animated];
}

- (YKUIButton *)setNavigationLeftButtonWithTitle:(NSString *)title animated:(BOOL)animated target:(id)target action:(SEL)action {
  [self view];
  YKUIButton *button = [[YKUIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
  button.title = title;
  [button setTarget:target action:action];
  [self applyStyleForNavigationButton:button];
  [_navigationBar setLeftButton:button animated:animated];
  return button;
}

- (YKUIButton *)setNavigationRightButtonWithTitle:(NSString *)title animated:(BOOL)animated target:(id)target action:(SEL)action {
  [self view];
  YKUIButton *button = [[YKUIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
  button.title = title;
  [button setTarget:target action:action];
  [self applyStyleForNavigationButton:button];
  [_navigationBar setRightButton:button animated:animated];
  return button;
}

- (void)setContentView:(UIView *)view {
  [self view];
  [_templateView setView:view];
}

#pragma mark Style

- (void)applyStyleForNavigationButton:(YKUIButton *)button {
  button.titleFont = [UIFont boldSystemFontOfSize:12];
  button.insets = UIEdgeInsetsMake(0, 8, 0, 8);
  button.titleColor = [UIColor whiteColor];
  button.margin = UIEdgeInsetsMake(6, 0, 6, 0);
  button.cornerRadius = 4.0;
  button.borderWidth = 0.5;
  button.titleShadowColor = [UIColor colorWithWhite:0 alpha:0.5];
  button.titleShadowOffset = CGSizeMake(0, -1);
  button.shadingType = YKUIShadingTypeLinear;
  button.color = [UIColor colorWithRed:98.0f/255.0f green:120.0f/255.0f blue:170.0f/255.0f alpha:1.0];
  button.color2 = [UIColor colorWithRed:64.0f/255.0f green:90.0f/255.0f blue:136.0f/255.0f alpha:1.0];
  button.highlightedShadingType = YKUIShadingTypeLinear;
  button.highlightedColor = [UIColor colorWithRed:70.0f/255.0f green:92.0f/255.0f blue:138.0f/255.0f alpha:1.0];
  button.highlightedColor2 = [UIColor colorWithRed:44.0f/255.0f green:70.0f/255.0f blue:126.0f/255.0f alpha:1.0];
  button.borderColor = [UIColor colorWithRed:87.0f/255.0f green:100.0f/255.0f blue:153.0f/255.0f alpha:1.0];
  
  CGSize size = [button sizeThatFitsTitle:CGSizeMake(120, 999) minWidth:55];
  button.frame = CGRectMake(0, 0, size.width, 30 + button.margin.top + button.margin.bottom);
}

- (void)applyStyleForNavigationBar:(YKUINavigationBar *)navigationBar {
  navigationBar.backgroundColor = [UIColor colorWithRed:98.0f/255.0f green:120.0f/255.0f blue:170.0f/255.0f alpha:1.0];
  navigationBar.topBorderColor = [UIColor colorWithRed:87.0f/255.0f green:100.0f/255.0f blue:153.0f/255.0f alpha:1.0];
  navigationBar.bottomBorderColor = [UIColor colorWithRed:87.0f/255.0f green:100.0f/255.0f blue:153.0f/255.0f alpha:1.0];
}

@end
