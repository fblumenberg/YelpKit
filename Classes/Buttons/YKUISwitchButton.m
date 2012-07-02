//
//  YKUISwitchButton.m
//  YelpKit
//
//  Created by Gabriel Handford on 6/26/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUISwitchButton.h"

@implementation YKUISwitchButton

@synthesize button=_button, switchControl=_switchControl;

- (void)sharedInit {
  _button = [[YKUIButton alloc] init];
  [self addSubview:_button];
  [_button release];
  
  _switchControl = [[UISwitch alloc] init];
  [_switchControl addTarget:self action:@selector(_switchChanged) forControlEvents:UIControlEventValueChanged];
  [self addSubview:_switchControl];
  [_switchControl release];
  
  _button.titleInsets = UIEdgeInsetsMake(10, 10, 10, _switchControl.frame.size.width - 10);
  _button.titleAlignment = UITextAlignmentLeft;
  _button.targetDisabled = YES;
  [_button addTarget:self action:@selector(_didTouchUpInside)];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _button.frame = YKCGRectZeroOrigin(self.bounds);
  _switchControl.frame = CGRectMake(self.frame.size.width - _switchControl.frame.size.width - 10, roundf(self.frame.size.height/2.0f - _switchControl.frame.size.height/2.0f), _switchControl.frame.size.width, _switchControl.frame.size.height);
}

- (void)_switchChanged {
  [_button callTarget];
}

- (void)_didTouchUpInside {
  [_switchControl setOn:!_switchControl.on animated:YES];
  [_button callTarget];
}

@end
