//
//  YKAppDelegate.m
//  YelpKitCatalog
//
//  Created by Gabriel Handford on 7/23/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKAppDelegate.h"

@implementation YKAppDelegate

@synthesize window=_window;

- (void)dealloc {
  [_window release];
  [_viewStack release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  self.window.backgroundColor = [UIColor blackColor];
  
  _viewStack = [[YKUIViewStack alloc] initWithParentView:self.window];
  
  YKTableView *tableView = [[[YKTableView alloc] init] autorelease];
  YKSUIView *mainView = [YKSUIView viewWithView:tableView];
  [mainView.navigationBar setTitle:@"View Stack" animated:NO];
  
  YKUIButtonCell *cell1 = [[[YKUIButtonCell alloc] init] autorelease];
  cell1.button.title = @"Slide Over";
  cell1.button.targetBlock = ^() {
    UIView *subview = [[[UIView alloc] init] autorelease];
    subview.backgroundColor = [UIColor redColor];
    YKSUIView *view = [YKSUIView viewWithView:subview];
    [mainView pushView:view duration:0.25 options:YKSUIViewAnimationOptionTransitionSlideOver];
  };
  [tableView.dataSource addCellDataSource:cell1 section:0];

  YKUIButtonCell *cell2 = [[[YKUIButtonCell alloc] init] autorelease];
  cell2.button.title = @"Slide";
  cell2.button.targetBlock = ^() {
    UIView *subview = [[[UIView alloc] init] autorelease];
    subview.backgroundColor = [UIColor greenColor];
    YKSUIView *view = [YKSUIView viewWithView:subview];
    [mainView pushView:view duration:0.25 options:YKSUIViewAnimationOptionTransitionSlide];
  };
  [tableView.dataSource addCellDataSource:cell2 section:0];
  
  YKUIButtonCell *cell3 = [[[YKUIButtonCell alloc] init] autorelease];
  cell3.button.title = @"Curl";
  cell3.button.targetBlock = ^() {
    UIView *subview = [[[UIView alloc] init] autorelease];
    subview.backgroundColor = [UIColor blueColor];
    YKSUIView *view = [YKSUIView viewWithView:subview];
    [mainView pushView:view duration:1.0 options:YKSUIViewAnimationOptionTransitionCurlUp];
  };
  [tableView.dataSource addCellDataSource:cell3 section:0];
  
  [_viewStack setView:mainView duration:0 options:0];  
  [self.window makeKeyAndVisible];
  return YES;
}

@end
