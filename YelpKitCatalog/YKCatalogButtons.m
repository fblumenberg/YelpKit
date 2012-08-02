//
//  YKCatalogButtons.m
//  YelpKit
//
//  Created by Gabriel Handford on 8/2/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKCatalogButtons.h"

@implementation YKCatalogButtons

- (void)sharedInit {
  [super sharedInit];
  self.layout = [YKLayout layoutForView:self];
  self.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
  
  _listView = [[YKUIListView alloc] init];
  _listView.insets = UIEdgeInsetsMake(10, 10, 10, 10);
  
  YKUIButton *button = [[YKUIButton alloc] init];
  button.title = @"Button (icon, accessory, center, linear shading)";
  button.titleAlignment = UITextAlignmentCenter;
  button.titleColor = [UIColor darkGrayColor];
  button.titleFont = [UIFont boldSystemFontOfSize:15];
  button.borderColor = [UIColor darkGrayColor];
  button.cornerRadius = 10.0f;
  button.color = [UIColor whiteColor];
  button.color2 = [UIColor colorWithWhite:0.84 alpha:1.0];
  button.shadingType = YKUIShadingTypeLinear;
  button.borderWidth = 1.0f;
  button.highlightedColor = [UIColor colorWithWhite:0.92 alpha:1.0];
  button.highlightedColor2 = [UIColor whiteColor];
  button.highlightedShadingType = YKUIShadingTypeLinear;
  button.insets = UIEdgeInsetsMake(10, 10, 10, 10);
  button.titleInsets = UIEdgeInsetsMake(0, 10, 0, 0);
  button.accessoryImage = [UIImage imageNamed:@"button_accessory_image.png"];
  button.highlightedAccessoryImage = [UIImage imageNamed:@"button_accessory_image_selected.png"];
  button.iconImage = [UIImage imageNamed:@"button_icon.png"];
  [button setTarget:self action:@selector(_buttonSelected:)];
  [_listView addView:button];
  [button release];
  
  YKUIButton *button2 = [self button];
  button2.title = @"Button (Rounded top)";
  button2.borderStyle = YKUIBorderStyleRoundedTop;
  button2.cornerRadius = 6.0f;
  button2.borderWidth = 1.0f;
  [_listView addView:button2];
  
  YKUIButton *button3 = [self button];
  button3.title = @"Button (Top left right)";
  button3.borderStyle = YKUIBorderStyleTopLeftRight;
  button3.cornerRadius = 6.0f;
  button3.borderWidth = 1.0f;
  [_listView addView:button3];
  
  YKUIButton *button4 = [self button];
  button4.title = @"Button (Rounded bottom)";
  button4.borderStyle = YKUIBorderStyleRoundedBottom;
  button4.cornerRadius = 6.0f;
  button4.borderWidth = 1.0f;
  [_listView addView:button4];
  
  YKUIButton *button5 = [self button];
  button5.title = @"Button";
  button5.secondaryTitle = @"Secondary text, centered, multiline will not ellipsis";
  button5.secondaryTitlePosition = YKUIButtonSecondaryTitlePositionBottom;
  button5.secondaryTitleFont = [UIFont systemFontOfSize:13];
  button5.secondaryTitleColor = [UIColor grayColor];
  [_listView addView:button5];

  YKUIButton *button6 = [self button];
  button6.secondaryTitle = @" Secondary text";
  // TODO(gabe): This does nothing for secondary text, using space
  button6.titleInsets = UIEdgeInsetsMake(0, 0, 0, 6);
  button6.secondaryTitlePosition = YKUIButtonSecondaryTitlePositionDefault;
  button6.secondaryTitleFont = [UIFont systemFontOfSize:14];
  button6.secondaryTitleColor = [UIColor grayColor];
  [_listView addView:button6];
  
  YKUIButton *button7 = [self button];
  button7.secondaryTitle = @"Secondary text, bottom left align single line, will ellipsis";
  button7.secondaryTitlePosition = YKUIButtonSecondaryTitlePositionBottomLeftSingle;
  button7.secondaryTitleFont = [UIFont systemFontOfSize:14];
  button7.secondaryTitleColor = [UIColor grayColor];
  [_listView addView:button7];
  
  YKUIButton *button8 = [self button];
  button8.secondaryTitle = @"Secondary text, right align";
  button8.secondaryTitlePosition = YKUIButtonSecondaryTitlePositionRightAlign;
  button8.secondaryTitleFont = [UIFont systemFontOfSize:14];
  button8.secondaryTitleColor = [UIColor grayColor];
  [_listView addView:button8];
  
  _scrollView = [[YKUIScrollView alloc] init];
  _scrollView.backgroundColor = [UIColor whiteColor];
  [self addSubview:_scrollView];
  [_scrollView release];
  
  [_scrollView addSubview:_listView];
  [_listView release];
  
  /*
  _buttons = [[YKUIButtons alloc] initWithButtons:buttons style:YKUIButtonsStyleVertical apply:^(YKUIButton *button, NSInteger index) {
    
  }];
  _buttons.insets = UIEdgeInsetsMake(0, 0, 20, 0);
  _buttons.backgroundColor = [UIColor clearColor];
  [self addSubview:_buttons];
  [_buttons release];
  [buttons release];
   */
}

- (YKUIButton *)button {
  YKUIButton *button = [[YKUIButton alloc] init];
  button.title = @"Button";
  button.titleColor = [UIColor darkGrayColor];
  button.titleFont = [UIFont boldSystemFontOfSize:15];
  button.color = [UIColor whiteColor];
  button.shadingType = YKUIShadingTypeNone;
  button.borderColor = [UIColor darkGrayColor];
  button.insets = UIEdgeInsetsMake(10, 10, 10, 10);
  button.borderStyle = YKUIBorderStyleRounded;
  button.cornerRadius = 10.0f;
  button.borderWidth = 0.5f;
  button.highlightedColor = [UIColor lightGrayColor];
  [button setTarget:self action:@selector(_buttonSelected:)];
  return button;
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  [layout setFrame:CGRectMake(0, 0, size.width, size.height) view:_scrollView];
  
  CGFloat y = 0;
  CGRect listViewFrame = [layout setFrame:CGRectMake(0, y, size.width, 0) view:_listView sizeToFit:YES];
  y += listViewFrame.size.height;
  
  if (![layout isSizing]) {
    [_scrollView setContentSize:CGSizeMake(size.width, y)];
  }
  
  return CGSizeMake(size.width, size.height);
}

- (void)_buttonSelected:(id)sender {
  
}

@end
