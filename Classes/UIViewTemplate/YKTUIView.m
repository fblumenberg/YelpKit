//
//  YKTUIView.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTUIView.h"
#import "YKTUIViewController.h"

@implementation YKTUIView

@synthesize viewController=_viewController;

- (YKTUIViewController *)newViewController { 
  YKTUIViewController *viewController = [[self viewControllerForView] retain];
  _viewController = viewController;
  return viewController;
}

- (YKTUIViewController *)viewControllerForView {
  YKTUIViewController *viewController = [[YKTUIViewController alloc] init];  
  viewController.view = self;
  return [viewController autorelease];
}

- (void)pushView:(YKTUIView *)view animated:(BOOL)animated {
  YKTUIViewController *viewController = [view newViewController];
  [self.viewController.navigationController pushViewController:viewController animated:animated];
  [viewController release];
}

@end
