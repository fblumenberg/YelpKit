//
//  YKUIActivityCell.h
//  YelpKit
//
//  Created by Gabriel Handford on 6/15/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTableViewCell.h"
#import "YKUIActivityView.h"

@interface YKUIActivityCell : YKTableViewCell

@property (readonly, nonatomic) YKUIActivityView *view;

@end
