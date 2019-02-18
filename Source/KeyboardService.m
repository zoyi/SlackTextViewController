//
//  KeyboardService.m
//  CHSlackTextViewController
//
//  Created by Haeun Chung on 18/02/2019.
//  Copyright © 2019 Slack Technologies, Inc. All rights reserved.
//

#import "KeyboardService.h"

@implementation KeyboardService

@synthesize measureSize;

+ (id)shared {
  static KeyboardService *sharedMyManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedMyManager = [[self alloc] init];
  });
  return sharedMyManager;
}

- (id)init {
  if (self = [super init]) {
    self.measureSize = CGRectZero;
    [self observeKeyboard];
    [self observeKeyboardNotifications];
  }
  return self;
}

- (void)dealloc {
  [NSNotificationCenter.defaultCenter removeObserver:self];
}


- (CGFloat)keyboardHeight {
  CGRect keyboardSize = [self keyboardSize];
  return keyboardSize.size.height;
}

- (CGRect)keyboardSize {
  return [[KeyboardService shared] measureSize];
}

- (void)observeKeyboardNotifications {
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)observeKeyboard {
  UITextField *field = [[UITextField alloc] init];
  [[UIApplication sharedApplication].windows.firstObject addSubview:field];
  [field becomeFirstResponder];
  [field resignFirstResponder];
  [field removeFromSuperview];
}

- (void)keyboardChange:(NSNotification *)notification {
  if (!CGRectEqualToRect(self.measureSize, CGRectZero)) {
    return;
  }
  NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
  if (value == nil) {
    return;
  }
  
  self.measureSize = value.CGRectValue;
}

@end
