//
//  YKCatalogViewStack.m
//  YelpKit
//
//  Created by Gabriel Handford on 8/2/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKCatalogViewStack.h"
#import "YKCatalogTestView.h"

@implementation YKCatalogViewStack

- (void)sharedInit {
  [super sharedInit];

  YKTableView *tableView = [[[YKTableView alloc] init] autorelease];
  [self setView:tableView];
  [self.navigationBar setTitle:@"View Stack" animated:NO];
  
  __block id blockSelf = self;
  
  YKUIButtonCell *cell1 = [[[YKUIButtonCell alloc] init] autorelease];
  cell1.button.title = @"Slide Over";
  cell1.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:0.25 options:YKSUIViewAnimationOptionTransitionSlideOver];
  };
  [tableView.dataSource addCellDataSource:cell1 section:0];
  
  YKUIButtonCell *cell2 = [[[YKUIButtonCell alloc] init] autorelease];
  cell2.button.title = @"Slide";
  cell2.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:0.25 options:YKSUIViewAnimationOptionTransitionSlide];
  };
  [tableView.dataSource addCellDataSource:cell2 section:0];
  
  YKUIButtonCell *cell3 = [[[YKUIButtonCell alloc] init] autorelease];
  cell3.button.title = @"Curl Up";
  cell3.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionCurlUp];
  };
  [tableView.dataSource addCellDataSource:cell3 section:0];
  
  YKUIButtonCell *cell4 = [[[YKUIButtonCell alloc] init] autorelease];
  cell4.button.title = @"Curl Down";
  cell4.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionCurlDown];
  };
  [tableView.dataSource addCellDataSource:cell4 section:0];
  
  YKUIButtonCell *cell5 = [[[YKUIButtonCell alloc] init] autorelease];
  cell5.button.title = @"Flip From Left";
  cell5.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionFlipFromLeft];
  };
  [tableView.dataSource addCellDataSource:cell5 section:0];
  
  YKUIButtonCell *cell6 = [[[YKUIButtonCell alloc] init] autorelease];
  cell6.button.title = @"Flip From Right";
  cell6.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionFlipFromRight];
  };
  [tableView.dataSource addCellDataSource:cell6 section:0];

  YKUIButtonCell *cell7 = [[[YKUIButtonCell alloc] init] autorelease];
  cell7.button.title = @"Cross Dissolve";
  cell7.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionCrossDissolve];
  };
  [tableView.dataSource addCellDataSource:cell7 section:0];

  YKUIButtonCell *cell8 = [[[YKUIButtonCell alloc] init] autorelease];
  cell8.button.title = @"Flip From Top";
  cell8.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionFlipFromTop];
  };
  [tableView.dataSource addCellDataSource:cell8 section:0];

  YKUIButtonCell *cell9 = [[[YKUIButtonCell alloc] init] autorelease];
  cell9.button.title = @"Flip From Bottom";
  cell9.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackView] duration:1.0 options:YKSUIViewAnimationOptionTransitionFlipFromBottom];
  };
  [tableView.dataSource addCellDataSource:cell9 section:0];
  
  YKUIButtonCell *cell10 = [[[YKUIButtonCell alloc] init] autorelease];
  cell10.button.title = @"Multi Push (Slide Over)";
  cell10.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackViewWithName:@"View 1"] duration:0.25 options:YKSUIViewAnimationOptionTransitionSlideOver];
    [blockSelf pushView:[YKCatalogTestView testStackViewWithName:@"View 2"] duration:0.25 options:YKSUIViewAnimationOptionTransitionSlideOver];
  };
  [tableView.dataSource addCellDataSource:cell10 section:0];
  
  YKUIButtonCell *cell11 = [[[YKUIButtonCell alloc] init] autorelease];
  cell11.button.title = @"Multi Push (Slide)";
  cell11.button.targetBlock = ^() {
    [blockSelf pushView:[YKCatalogTestView testStackViewWithName:@"View 1"] duration:0.25 options:YKSUIViewAnimationOptionTransitionSlide];
    [blockSelf pushView:[YKCatalogTestView testStackViewWithName:@"View 2"] duration:0.25 options:YKSUIViewAnimationOptionTransitionSlide];
  };
  [tableView.dataSource addCellDataSource:cell11 section:0];
}

@end
