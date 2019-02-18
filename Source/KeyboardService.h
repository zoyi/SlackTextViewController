//
//  KeyboardService.h
//  CHSlackTextViewController
//
//  Created by Haeun Chung on 18/02/2019.
//  Copyright © 2019 Slack Technologies, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardService : NSObject {
  CGRect measureSize;
}

@property (nonatomic, assign) CGRect measureSize;

+ (id)shared;
- (CGFloat)keyboardHeight;
- (CGRect)keyboardSize;
@end

NS_ASSUME_NONNULL_END
