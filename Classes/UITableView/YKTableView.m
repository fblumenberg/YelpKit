//
//  YKTableView.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTableView.h"

@implementation YKTableView

@dynamic dataSource;

- (void)sharedInit {
  dataSource_ = [[YKTableViewDataSource alloc] init];
  self.dataSource = dataSource_;
  self.delegate = dataSource_;
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
  [dataSource_ release];
  [super dealloc];
}

- (YKTableViewDataSource *)tableViewDataSource {
  return dataSource_;
}

@end
