//
//  YKUISwitch.h
//  YelpKit
//
//  Created by Gabriel Handford on 3/1/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

@protocol YKUISwitch <NSObject>
- (void)setOn:(BOOL)on animated:(BOOL)animated;

/*!
 Set the state of the button. When ignoreControlEvents is YES, the button won't call any registered
 target for UIControlEventValueChanged. This is useful for setting the button programatically without
 executing code that should only happen when the switch is changed from a user event.

 @param newOn Button state
 @param animated Whether to animate the transition
 @param ignoreControlEvents If YES, any target set for UIControlEventValueChanged will not be called
*/
- (void)setOn:(BOOL)on animated:(BOOL)animated ignoreControlEvents:(BOOL)ignoreControlEvents;

- (BOOL)isOn;
@end


@protocol YKUISwitchCustom
- (void)setOnText:(NSString *)onText;
- (void)setOffText:(NSString *)offText;
@end