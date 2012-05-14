//
//  YKTableViewCell.h
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTableViewDataSource.h"

/*!
 */
@interface YKTableViewCell : UITableViewCell <YKTableViewCellDataSource> {
}

@property (retain, nonatomic) UIView *cellView;

/*!
 
 @param view View
 @param reuseIdentifier Identifier for reuse
 */
- (id)initWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier;

/*!
 Create a UITableViewCell from a view.
 */
+ (YKTableViewCell *)tableViewCellWithView:(UIView *)view;

+ (YKTableViewCell *)tableViewCellWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier;

@end
