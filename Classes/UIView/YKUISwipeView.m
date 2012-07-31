//
//  YKUISwipeView.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/26/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "YKUISwipeView.h"

@implementation YKUISwipeView

@synthesize peekWidth=_peekWidth, insets=_insets, scrollView=_scrollView, views=_views;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.userInteractionEnabled = NO;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.directionalLockEnabled = YES;
    [self addSubview:_scrollView];
    [_scrollView release];
    
    _peekWidth = 20;
    _insets = UIEdgeInsetsMake(0, 10, 0, 10);
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  // Disable swipe when we only have 1 view.
  // Otherwise setup the peek.
  if ([_views count] == 1) {
    UIView *view = [_views objectAtIndex:0];
    view.frame = CGRectMake(_insets.left, _insets.top, self.frame.size.width - _insets.left - _insets.right, self.frame.size.height - _insets.top - _insets.bottom);
    _scrollView.alwaysBounceHorizontal = NO;    
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
  } else {
    CGFloat width = self.frame.size.width - _insets.left - _insets.right - _peekWidth;
    CGFloat x = 0;
    for (UIView *view in _views) {
      view.frame = CGRectMake(x, _insets.top, width, self.frame.size.height - _insets.top - _insets.bottom);
      x += width + _insets.right;
    }

    _scrollView.alwaysBounceHorizontal = YES;
    // ScrollView frame width defines the page width, so it must be view width + separation.
    _scrollView.frame = CGRectMake(_insets.left, 0, width + _insets.right, self.frame.size.height);
    // Subtract peekWidth so the last page doesn't leave room to peek a nonexistant view.
    _scrollView.contentSize = CGSizeMake(x - _peekWidth, self.frame.size.height);
  }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  if (self.hidden) return [super hitTest:point withEvent:event];
  // Because the scroll view frame is smaller than the view frame we need to adjust the point and call hitTest again,
  // so the swipe works from the far left and right sides.
  if ([self pointInside:point withEvent:event]) {
    if (point.x > CGRectGetMaxX(_scrollView.frame)) {
      point.x = CGRectGetMaxX(_scrollView.frame) - 1;
    } else if (point.x < CGRectGetMinX(_scrollView.frame)) {
      point.x = CGRectGetMinX(_scrollView.frame) + 1;
    }
    return [_scrollView hitTest:[_scrollView convertPoint:point fromView:self] withEvent:event];
  }
  return nil;
}

- (void)setViews:(NSArray *)views {
  [views retain];
  for (UIView *view in _views) {
    [view removeFromSuperview];
  }
  [_views release];
  _views = views;
  
  for (UIView *view in _views) {
    [_scrollView addSubview:view];
  }
  [self setNeedsDisplay];
  [self setNeedsLayout];
}

@end
