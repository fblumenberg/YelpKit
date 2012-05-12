//
//  YKLText.m
//  YelpKit
//
//  Created by Gabriel Handford on 4/11/12.
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

#import "YKLText.h"
#import "YKCGUtils.h"
#import "YKLImage.h"

@implementation YKLText

@synthesize shadowColor=_shadowColor, shadowOffset=_shadowOffset;

- (id)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color lineBreakMode:(UILineBreakMode)lineBreakMode textAligment:(UITextAlignment)textAlignment {
  if ((self = [super init])) {
    _text = [text retain];
    _font = [font retain];
    _color = [color retain];
    _lineBreakMode = lineBreakMode;
    _textAlignment = textAlignment;
    _sizeThatFits = YKCGSizeNull;
    _sizeForSizeThatFits = YKCGSizeNull;
  }
  return self;
}

- (void)dealloc {
  [_text release];
  [_font release];
  [_color release];
  [_shadowColor release];
  [_image release];
  [super dealloc];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font {
  return [self text:text font:font color:nil lineBreakMode:-1];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
  return [self text:text font:font color:color lineBreakMode:-1];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font color:(UIColor *)color lineBreakMode:(UILineBreakMode)lineBreakMode {
  return [[[YKLText alloc] initWithText:text font:font color:color lineBreakMode:lineBreakMode textAligment:UITextAlignmentLeft] autorelease];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font color:(UIColor *)color lineBreakMode:(UILineBreakMode)lineBreakMode textAligment:(UITextAlignment)textAlignment {
  return [[[YKLText alloc] initWithText:text font:font color:color lineBreakMode:lineBreakMode textAligment:textAlignment] autorelease];
}

- (void)_reset {
  _sizeThatFits = YKCGSizeNull;
  _sizeForSizeThatFits = YKCGSizeNull;
}

- (void)setImage:(UIImage *)image insets:(UIEdgeInsets)insets {
  [_image release];
  _image = [[YKLImage imageWithImage:image] retain];
  _image.insets = insets;
  [self _reset];
}

- (NSString *)description {
  return _text;
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (size.width == 0) return size;
  
  if (YKCGSizeIsEqual(size, _sizeForSizeThatFits) && !YKCGSizeIsNull(_sizeThatFits)) return _sizeThatFits;
  
  if (_lineBreakMode == -1) {
    _sizeThatFits = [_text sizeWithFont:_font];
  } else {
    _sizeThatFits = [_text sizeWithFont:_font forWidth:size.width lineBreakMode:_lineBreakMode];
  }
  
  if (_image) {
    CGSize imageSize = [_image sizeThatFits:size];
    _sizeThatFits.width += imageSize.width;
    _sizeThatFits.height = MAX(_sizeThatFits.height, imageSize.height);
  }
  
  _sizeForSizeThatFits = size;
  return _sizeThatFits;
}

- (CGPoint)drawInRect:(CGRect)rect {
  if (_image) {
    CGPoint p = [_image drawInRect:rect];
    rect.origin.x = p.x;
  }
  
  if (_color) [_color setFill];
  if (_shadowColor) {
    CGContextRef context = UIGraphicsGetCurrentContext();	
    CGContextSetShadowWithColor(context, _shadowOffset, 0, _shadowColor.CGColor);
  }
  if (_textAlignment != UITextAlignmentLeft) {
    [_text drawInRect:rect withFont:_font lineBreakMode:_lineBreakMode alignment:_textAlignment];
  } else if (_lineBreakMode == -1) {
    [_text drawAtPoint:rect.origin withFont:_font];
  } else {
    [_text drawAtPoint:rect.origin forWidth:rect.size.width withFont:_font lineBreakMode:_lineBreakMode];
  }
  return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
}

@end
