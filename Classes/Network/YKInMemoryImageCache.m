//
//  YKInMemoryImageCache.m
//  YelpKit
//
//  Created by Amir Haghighat on 5/16/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKInMemoryImageCache.h"
#import "YKURLCache.h"
#import "YKDefines.h"

static NSMutableDictionary *gImageNamedCaches = NULL;

@implementation YKInMemoryImageCache

@synthesize maxPixelCount=_maxPixelCount;

- (id)initWithName:(NSString *)name {
  if ((self = [super init])) {
    _name = [name copy];
    _maxPixelCount = 262144; // ~1 MB
    
    if ([YKURLCache totalMemory] > (220 * 1000 * 1000)) { // 256 MB Device
      _maxPixelCount *= 4; // ~4 MB
    }
    
    if ([YKURLCache totalMemory] > (500 * 1000 * 1000)) { // 512 MB Device
      _maxPixelCount *= 8; // ~8 MB
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
  }
  return self;
}

+ (YKInMemoryImageCache *)cacheWithName:(NSString *)name {
  YKInMemoryImageCache *cache = nil;
  @synchronized([YKInMemoryImageCache class]) {
    if (gImageNamedCaches == NULL)
      gImageNamedCaches = [[NSMutableDictionary alloc] init];
    
    cache = [gImageNamedCaches objectForKey:name];
    if (!cache) {
      cache = [[[YKInMemoryImageCache alloc] initWithName:name] autorelease];
      [gImageNamedCaches setObject:cache forKey:name];
    }
  }
  return cache;
}

+ (YKInMemoryImageCache *)sharedCache {
  return [self cacheWithName:@"YKInMemoryImageCache"];
}

- (void)didReceiveMemoryWarning:(void *)object {
  // Empty the memory cache when memory is low
  [self clearCache];
}

- (void)clearCache {
  _totalPixelCount = 0;
  [_imageCache release];
  _imageCache = nil;
  [_imageSortedList release];
  _imageSortedList = nil;
}

- (void)_expireImagesFromMemory {
  while (_imageSortedList.count) {
    NSString *key = [_imageSortedList objectAtIndex:0];
    UIImage *image = [_imageCache objectForKey:key];
    
    YKDebug(@"Expiring image, key=%@, pixels=%.0f", key, (image.size.width * image.size.height));
    _totalPixelCount -= image.size.width * image.size.height;
    [_imageCache removeObjectForKey:key];
    [_imageSortedList removeObjectAtIndex:0];
    
    if (_totalPixelCount <= _maxPixelCount) {
      break;
    }
  }
  if (_totalPixelCount < 0) _totalPixelCount = 0;
}

- (BOOL)cacheImage:(UIImage *)image forKey:(NSString *)key {
  YKParameterAssert(image);
  YKParameterAssert(key);
  if (!image || !key) return NO;
  
  // Already in cache (We don't bump it forward)
  if ([_imageCache objectForKey:key]) return NO;

  int pixelCount = image.size.width * image.size.height;
  
  static const CGFloat kLargeImageSize = 600 * 400;
  
  if (pixelCount >= kLargeImageSize) {
    YKDebug(@"NOT caching image in in memory (too large, pixelCount=%d > %.0f)", pixelCount, kLargeImageSize);
    return NO;
  }
  
  _totalPixelCount += pixelCount;
  
  if (_totalPixelCount > _maxPixelCount && _maxPixelCount) {
    [self _expireImagesFromMemory];
  }
  
  if (!_imageCache) {
    _imageCache = [[NSMutableDictionary alloc] init];
  }
  
  if (!_imageSortedList) {
    _imageSortedList = [[NSMutableArray alloc] init];
  }
  
  [_imageSortedList addObject:key];
  [_imageCache setObject:image forKey:key];
  return YES;
}

- (UIImage *)memoryCachedImageForKey:(NSString *)key {
  if (!key) return nil;
  UIImage *image = [_imageCache objectForKey:key];
  return image;
}

@end
