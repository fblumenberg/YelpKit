//
//  YKUIActivityCell.m
//  YelpKit
//
//  Created by Gabriel Handford on 6/15/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUIActivityCell.h"

@implementation YKUIActivityCell

@synthesize view=_view;

- (id)initWithFrame:(CGRect)frame {
  YKUIActivityView *view = [[YKUIActivityView alloc] init];
  view.backgroundColor = [UIColor clearColor];
	if ((self = [super initWithView:view reuseIdentifier:nil])) {
    self.backgroundColor = [UIColor clearColor];
    _view = view;
	}
	return self;
}

- (void)dealloc {
  [_view release];
  [super dealloc];
}

@end
