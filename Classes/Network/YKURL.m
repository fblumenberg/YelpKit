//
//  YKURL.m
//  YelpKit
//
//  Created by Gabriel Handford on 11/4/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "YKURL.h"

@implementation YKURL

@synthesize cacheDisabled=_cacheDisabled;

- (id)initWithURLString:(NSString *)URLString {
  if ((self = [self init])) {
    _URLString = [URLString retain];
  }
  return self;
}

- (id)initWithHost:(NSString *)host path:(NSString *)path queryParams:(NSDictionary *)queryParams secure:(BOOL)secure {
  if ([path length] > 0 && ![[path substringToIndex:1] isEqualToString:@"/"]) path = [NSString stringWithFormat:@"/%@", path];
  NSString *queryString = [queryParams gh_queryString];
  if ([queryString length] > 0 && ![[path substringToIndex:1] isEqualToString:@"?"]) queryString = [NSString stringWithFormat:@"?%@", queryString];
  if (!queryString) queryString = @"";
  NSString *URLString = [NSString stringWithFormat:@"%@%@%@%@", (secure ? @"https://" : @"http://"), host, path, queryString, nil];
  return [self initWithURLString:URLString];
}

- (void)dealloc {
  [_URLString release];
  [super dealloc];
}

+ (YKURL *)URLString:(NSString *)URLString {
  return [self URLString:URLString cacheEnabled:YES];
}

+ (YKURL *)URLString:(NSString *)URLString cacheEnabled:(BOOL)cacheEnabled {
  YKURL *URL = [[YKURL alloc] initWithURLString:URLString];
  URL.cacheDisabled = !cacheEnabled;
  return [URL autorelease];
}

+ (YKURL *)URLWithHost:(NSString *)host path:(NSString *)path queryParams:(NSDictionary *)queryParams secure:(BOOL)secure {
    return [[[self class] alloc] initWithHost:host path:path queryParams:queryParams secure:secure];
}

- (NSString *)description {
  return _URLString;
}

- (NSString *)cacheableURLString {
  if (_cacheDisabled) return nil;
  return _URLString;
}

- (NSString *)URLString {
  return _URLString;
}

@end
