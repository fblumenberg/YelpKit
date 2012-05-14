//
//  YKJSONRequest.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/1/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKJSONRequest.h"

@implementation YKJSONRequest

- (id)init {
  if ((self = [super init])) {
    self.JSONEnabled = YES;
  }
  return self;
}

@end
