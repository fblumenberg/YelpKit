//
//  YKTableViewCell.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTableViewCell.h"

@implementation YKTableViewCell

@synthesize cellView=_cellView;

- (id)initWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier {
	NSParameterAssert(view);
	if ((self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
		_cellView = [view retain];
		[self.contentView addSubview:_cellView];
	}
	return self;
}

- (void)dealloc {
	[_cellView release];
	[super dealloc];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGSize contentViewSize = self.contentView.frame.size;
  CGSize cellViewSize = [_cellView sizeThatFits:contentViewSize];
  _cellView.frame = CGRectMake(0, 0, cellViewSize.width, cellViewSize.height);
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (!_cellView) return [super sizeThatFits:size];

  CGSize sizeThatFits = [_cellView sizeThatFits:size];
  sizeThatFits.height += _cellView.frame.origin.y;
	return sizeThatFits;
}

+ (YKTableViewCell *)tableViewCellWithView:(UIView *)view {
	return [self tableViewCellWithView:view reuseIdentifier:nil];
}

+ (YKTableViewCell *)tableViewCellWithView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier {
	return [[[YKTableViewCell alloc] initWithView:view reuseIdentifier:reuseIdentifier] autorelease];
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath {
  CGSize sizeThatFits = [_cellView sizeThatFits:CGSizeMake(tableView.frame.size.width, CGFLOAT_MAX)];
  _cellView.frame = CGRectMake(0, 0, tableView.frame.size.width, sizeThatFits.height);  
	return self;
}

@end
