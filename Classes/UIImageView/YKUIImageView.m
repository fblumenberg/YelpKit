//
//  YKUIImageView.m
//  YelpKit
//
//  Created by Gabriel Handford on 12/30/08.
//  Copyright 2008 Yelp. All rights reserved.
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

#import "YKUIImageView.h"
#import "YKCGUtils.h"
#import "YKLocalized.h"
#import "YKDefines.h"
#import "UIImage+YKUtils.h"

@implementation YKUIImageBaseView

@synthesize image=_image, status=_status, delegate=_delegate, imageLoader=_imageLoader, statusBlock=_statusBlock, renderInBackground=_renderInBackground;

- (void)sharedInit {
  self.opaque = NO;
  self.backgroundColor = [UIColor whiteColor];
  self.contentMode = UIViewContentModeScaleAspectFit;

  [self setIsAccessibilityElement:YES];
  [self setAccessibilityTraits:UIAccessibilityTraitImage];
}

- (id)initWithImage:(UIImage *)image {
  if ((self = [self initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)])) {
    self.image = image;
  }
  return self;
}

- (id)initWithURLString:(NSString *)URLString loadingImage:(UIImage *)loadingImage defaultImage:(UIImage *)defaultImage {
  if ((self = [self initWithFrame:CGRectZero])) {
    [self setURLString:URLString loadingImage:loadingImage defaultImage:defaultImage];
  }
  return self;
}

- (void)dealloc {
  Block_release(_statusBlock);
  _imageLoader.delegate = nil;
  [_imageLoader release];
  [_image release];
  [super dealloc];
}

- (void)cancel {
  [_imageLoader cancel];
}

- (void)reset {
  [_imageLoader cancel];
  _imageLoader.delegate = nil;
  [_imageLoader release];
  _imageLoader = nil;
  [_image release];
  _image = nil;
  _status = YKUIImageViewStatusNone;
  [self setNeedsDisplay];
  [self setNeedsLayout];
}

- (void)setURLString:(NSString *)URLString loadingImage:(UIImage *)loadingImage defaultImage:(UIImage *)defaultImage errorImage:(UIImage *)errorImage {
  if ([URLString isEqual:[NSNull null]]) URLString = nil;

  [self reset];
  if (URLString) {
    _imageLoader = [[YKImageLoader alloc] initWithLoadingImage:loadingImage defaultImage:defaultImage errorImage:errorImage delegate:self];
    [_imageLoader setURL:[YKURL URLString:URLString]];
  } else if (defaultImage) {
    self.image = defaultImage;
  }
}

- (void)setURLString:(NSString *)URLString loadingImage:(UIImage *)loadingImage defaultImage:(UIImage *)defaultImage {
  [self setURLString:URLString loadingImage:loadingImage defaultImage:defaultImage errorImage:nil];
}

- (void)setURLString:(NSString *)URLString defaultImage:(UIImage *)defaultImage {
  [self setURLString:URLString loadingImage:nil defaultImage:defaultImage];
}

- (void)setURLString:(NSString *)URLString {
  [self setURLString:URLString defaultImage:nil];
}

- (NSString *)URLString {
  return _imageLoader.URL.URLString;
}

- (void)setImage:(UIImage *)image {
  [self reset];
  [image retain];
  [_image release];
  _image = image;
  [self setNeedsDisplay];
  [self setNeedsLayout];
}

- (UIImage *)loadingImage {
  return _imageLoader.loadingImage;
}

- (CGSize)size {
  if (!_image) return CGSizeZero;
  return _image.size;
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize sizeThatFits = [self size];
  if (sizeThatFits.width > size.width || sizeThatFits.height > size.height) {
    CGRect scale = YKCGRectScaleAspectAndCenter(sizeThatFits, size, YES);
    sizeThatFits.width = scale.size.width;
    sizeThatFits.height = scale.size.height;
  }
  return sizeThatFits;
}

- (void)reload {
  [self setURLString:_imageLoader.URL.URLString loadingImage:_imageLoader.loadingImage defaultImage:_imageLoader.defaultImage];
}

- (void)didLoadImage:(UIImage *)image { }

- (void)renderInBackgroundWithCompletion:(void (^)())completion { }

#pragma mark Delegates (YKImageLoader)

- (void)imageLoaderDidStart:(YKImageLoader *)imageLoader {
  if ([self.delegate respondsToSelector:@selector(imageViewDidStart:)])
    [self.delegate imageViewDidStart:self];
}

- (void)imageLoader:(YKImageLoader *)imageLoader didUpdateStatus:(YKImageLoaderStatus)status image:(UIImage *)image {
  switch (status) {
    case YKImageLoaderStatusNone: _status = YKUIImageViewStatusNone; break;
    case YKImageLoaderStatusLoading: _status = YKUIImageViewStatusLoading; break;
    case YKImageLoaderStatusLoaded: _status = YKUIImageViewStatusLoaded; break;
    default:
      break;
  }

  [image retain];
  [_image release];
  _image = image;
  if (_renderInBackground) {
    if (image) {
      [self renderInBackgroundWithCompletion:^{
        [self didLoadImage:image];
        if ([self.delegate respondsToSelector:@selector(imageView:didLoadImage:)])
          [self.delegate imageView:self didLoadImage:image];
        if (_statusBlock) _statusBlock(self, _status, image);
        [self setNeedsDisplay];
      }];
    }
  } else {
    if (image) {
      [self didLoadImage:image];
      if ([self.delegate respondsToSelector:@selector(imageView:didLoadImage:)])
        [self.delegate imageView:self didLoadImage:self.image];
    }
    if (_statusBlock) _statusBlock(self, _status, image);
    [self setNeedsLayout];
    [self setNeedsDisplay];
  }
}

- (void)imageLoader:(YKImageLoader *)imageLoader didError:(YKError *)error {
  _status = YKUIImageViewStatusErrored;
  [self setNeedsDisplay];

  if ([self.delegate respondsToSelector:@selector(imageView:didError:)])
    [self.delegate imageView:self didError:error];
  if (_statusBlock) _statusBlock(self, _status, nil);
}

- (void)imageLoaderDidCancel:(YKImageLoader *)imageLoader {
  _status = YKUIImageViewStatusNone;
  if ([self.delegate respondsToSelector:@selector(imageViewDidCancel:)])
    [self.delegate imageViewDidCancel:self];
}

@end



@implementation YKUIImageView

@synthesize strokeColor=_strokeColor, strokeWidth=_strokeWidth, cornerRadius=_cornerRadius, color=_color, color2=_color2, overlayColor=_overlayColor, imageContentMode=_imageContentMode, shadowColor=_shadowColor, shadowBlur=_shadowBlur;

+ (dispatch_queue_t)backgroundRenderQueue {
  static dispatch_queue_t BackgroundRenderQueue = NULL;
  if (!BackgroundRenderQueue) {
    BackgroundRenderQueue = dispatch_queue_create("com.YelpKit.YKUIImageBaseView.backgroundRenderQueue", 0);
  }
  return BackgroundRenderQueue;
}

- (void)sharedInit {
  [super sharedInit];
  _imageContentMode = -1;
}

- (void)dealloc {
  [_strokeColor release];
  [_color release];
  [_color2 release];
  [_overlayColor release];
  [_shadowColor release];
  [_renderedContents release];
  [_renderedBlankContents release];
  [super dealloc];
}

- (UIViewContentMode)imageContentMode {
  if (_imageContentMode == -1) return self.contentMode;
  return _imageContentMode;
}

#pragma mark Overrides

- (void)reset {
  [super reset];
  [_renderedContents release];
  _renderedContents = nil;
}

- (void)renderInBackgroundWithCompletion:(void (^)())completion {
  [self backgroundRenderForRect:self.bounds contentMode:self.contentMode completion:completion];
}

#pragma mark Drawing

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
  CGContextRef context = UIGraphicsGetCurrentContext();

  if (self.backgroundColor) {
    YKCGContextDrawRect(context, rect, self.backgroundColor.CGColor, NULL, 0);
  }

  UIColor *color = _color;
  if (!color) color = self.backgroundColor;
  
  if (_color && _color2) {
    CGContextSaveGState(context);
    YKCGContextAddStyledRect(context, rect, YKUIBorderStyleRounded, _strokeWidth, _strokeWidth, _cornerRadius);  
    CGContextClip(context);
    YKCGContextDrawShading(context, _color.CGColor, _color2.CGColor, NULL, NULL, rect.origin, CGPointMake(rect.origin.x, CGRectGetMaxY(rect)), YKUIShadingTypeLinear, NO, NO);
    CGContextRestoreGState(context);
    color = nil;
  }

  YKCGContextDrawRoundedRectImageWithShadow(context, image.CGImage, image.size, rect, _strokeColor.CGColor, _strokeWidth, _cornerRadius, contentMode, color.CGColor, _shadowColor.CGColor, _shadowBlur);

  if (_overlayColor) {
    YKCGContextDrawRoundedRect(context, rect, _overlayColor.CGColor, NULL, _strokeWidth, _cornerRadius);
  }
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
  CGContextRef context = UIGraphicsGetCurrentContext();
  // Size has changed since _renderedContents was last created
  if (_renderedContents && !CGSizeEqualToSize(rect.size, [_renderedContents size])) {
    YKAssert(NO, @"Rendered YKUIImageView content size has changed");
    [_renderedContents release];
    _renderedContents = nil;
  }

  if (_renderedContents) {
    // If we have a rendered version of ourself, draw that
    CGContextDrawImage(context, rect, _renderedContents.CGImage);
  } else if (_renderedBlankContents) {
    // If we have a rendered blank version of ourself, draw that
    CGContextDrawImage(context, rect, _renderedBlankContents.CGImage);
  } else if (_renderInBackground) {
    // Render, save, and draw a blank version of ourself
    UIImage *renderedImage = [UIImage imageFromDrawOperations:^(CGContextRef context) {
      [self drawImage:nil inRect:YKCGRectZeroOrigin(rect) contentMode:contentMode];
    } size:rect.size opaque:self.opaque];
    [renderedImage retain];
    [_renderedBlankContents release];
    _renderedBlankContents = renderedImage;
    CGContextDrawImage(context, rect, _renderedBlankContents.CGImage);
  } else {
    [self drawImage:self.image inRect:rect contentMode:contentMode];
  }
}

- (void)drawInRect:(CGRect)rect {
  [self drawInRect:rect contentMode:self.imageContentMode];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  [self drawInRect:self.bounds];
}

- (void)backgroundRenderForRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode completion:(void (^)())completion {
  UIImage *image = _image;
  dispatch_async([YKUIImageView backgroundRenderQueue], ^{
    // If the image has changed since this block was created, bail out
    if (!_image || image != _image) {
      YKDebug(@"Image has changed since block was created. image=%@ _image=%@ _renderedContents=%@", image, _image, _renderedContents);
      return;
    }
    UIImage *renderedImage = [UIImage imageFromDrawOperations:^(CGContextRef context) {
      [self drawImage:image inRect:YKCGRectZeroOrigin(rect) contentMode:contentMode];
    } size:rect.size opaque:self.opaque];
    // Because image rendering is slow, we might thread switch back to the main thread while the view was background rendering.
    // That means renderedImage is now incorrect. Let's just check again and bail out if the image has changed since render.
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!_image || image != _image) {
        YKDebug(@"Image has changed since render. image=%@ _image=%@ _renderedContents=%@", image, _image, _renderedContents);
        return;
      }
      [renderedImage retain];
      [_renderedContents release];
      _renderedContents = renderedImage;
      completion();
    });
  });
}

@end
