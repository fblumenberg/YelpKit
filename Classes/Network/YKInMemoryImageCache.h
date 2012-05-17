//
//  YKInMemoryImageCache.h
//  YelpKit
//
//  Created by Amir Haghighat on 5/16/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//


@interface YKInMemoryImageCache : NSObject {
  NSString *_name;
  NSMutableDictionary *_imageCache;
  NSMutableArray *_imageSortedList;
  NSInteger _totalPixelCount;
  NSUInteger _maxPixelCount;
}

/*!
 The maximum number of pixels to keep in memory for cached images.
 
 Setting this to zero will allow an unlimited number of images to be cached. The default is 262,144.
 */
@property (nonatomic) NSUInteger maxPixelCount;

/*!
 Gets a shared cache identified with a unique name.
 
 @param name Name
 */
+ (YKInMemoryImageCache *)cacheWithName:(NSString *)name;

/*!
 Get shared cache.
 */
+ (YKInMemoryImageCache *)sharedCache;

/*!
 Create cache.
 
 @param name Name
 */
- (id)initWithName:(NSString *)name;

/**
 Stores an image in the memory cache.
 */
- (BOOL)cacheImage:(UIImage *)image forKey:(NSString *)key;

/**
 Retrieves an image from the memory cache.
 */
- (UIImage *)memoryCachedImageForKey:(NSString *)key;

/*!
 Erases the cache.
 */
- (void)clearCache;

@end
