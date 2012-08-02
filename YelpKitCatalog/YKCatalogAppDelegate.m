//
//  YKCatalogAppDelegate.m
//  YelpKitCatalog
//
//  Created by Gabriel Handford on 7/23/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKCatalogAppDelegate.h"
#import "YKCatalogViewStack.h"
#import "YKCatalogButtons.h"

@implementation YKCatalogAppDelegate

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
  [mainView.navigationBar setTitle:@"Catalog" animated:NO];
  
  YKUIButtonCell *cell1 = [[[YKUIButtonCell alloc] init] autorelease];
  cell1.button.title = @"View Stack";
  cell1.button.targetBlock = ^() {
    [mainView pushView:[[[YKCatalogViewStack alloc] init] autorelease] animated:YES];
  };
  [tableView.dataSource addCellDataSource:cell1 section:0];
  
  YKUIButtonCell *cell2 = [[[YKUIButtonCell alloc] init] autorelease];
  cell2.button.title = @"Buttons";
  cell2.button.targetBlock = ^() {
    YKCatalogButtons *catalogButtons = [[[YKCatalogButtons alloc] init] autorelease];
    [mainView pushView:[YKSUIView viewWithView:catalogButtons] animated:YES];
  };
  [tableView.dataSource addCellDataSource:cell2 section:0];
  
  [_viewStack setView:mainView duration:0 options:0];  
  [self.window makeKeyAndVisible];
  return YES;
}

@end
