//
//  YKLUIView.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/2/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKLUIView.h"

@implementation YKLUIView

- (void)sharedInit {
  self.userInteractionEnabled = NO;
  self.contentMode = UIViewContentModeRedraw;
  self.opaque = YES;
  self.backgroundColor = [UIColor whiteColor];
  self.layout = [YKLayout layoutForView:self];
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)coder {
  if ((self = [super initWithCoder:coder])) {
    [self sharedInit];
  }
  return self;
}

- (void)dealloc {
  [_subviews release];
  [super dealloc];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  return size;
}

- (void)addView:(id)view {
  if (!_subviews) _subviews = [[NSMutableArray alloc] init];
  [_subviews addObject:view];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)removeView:(id)view {
  [_subviews removeObject:view];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)removeAllViews {
  [_subviews removeAllObjects];
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  for (id view in _subviews) {
    BOOL isHidden = NO;
    if ([view respondsToSelector:@selector(isHidden)]) {
      isHidden = [view isHidden];
    }
    
    if (!isHidden) {
      [view drawInRect:CGRectOffset([view frame], rect.origin.x, rect.origin.y)];
    }
  }
}

- (void)addSubview:(UIView *)view {
  [NSException raise:NSObjectInaccessibleException format:@"UIView subviews are not supported in YKLUIVew. Use addView:(id)view."];
}

@end
