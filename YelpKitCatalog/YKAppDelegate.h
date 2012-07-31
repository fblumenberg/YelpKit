//
//  YKAppDelegate.h
//  YelpKitCatalog
//
//  Created by Gabriel Handford on 7/23/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKAppDelegate : UIResponder <UIApplicationDelegate> {
  YKUIViewStack *_viewStack;
}

@property (strong, nonatomic) UIWindow *window;

@end
