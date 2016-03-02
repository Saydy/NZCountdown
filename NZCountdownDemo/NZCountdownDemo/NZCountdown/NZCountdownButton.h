//
//  NZCountdownButton.h
//  Countdown
//
//  Created by DaysSummer on 16/3/1.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZCountdownButton : UIButton
/**
 *  初始化倒计时按钮
 *  @param title 按钮标题(获取验证码)
 *  @param captcha 倒计时时间
 */
- (instancetype)initWithTitle:(NSString *)title Captcha:(NSInteger)captcha;
@end
