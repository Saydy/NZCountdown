//
//  NZCountdownButton.m
//  Countdown
//
//  Created by DaysSummer on 16/3/1.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import "NZCountdownButton.h"

@interface NZCountdownButton ()
// 定时器
@property (nonatomic ,strong) NSTimer *captchaTimer;
// 倒计时数值
@property (nonatomic ,assign)NSInteger captcha;
// 最大数值
@property (nonatomic ,assign)NSInteger maxCaptcha;

// 按钮显示的文本
@property (nonatomic ,copy) NSString *title;
@end

@implementation NZCountdownButton
- (instancetype)initWithTitle:(NSString *)title Captcha:(NSInteger)captcha{
    if (self = [super init]) {
        self.title = title;
        self.maxCaptcha = captcha;
        [self setTitle:title forState:UIControlStateNormal];
        
        // 获取偏好设置中保存的时间
        NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        // 获取当前时间和获取保存的时间的间隔
        float interva = [[NSDate date] timeIntervalSinceDate:date];
        // 判断小余60秒
        if (interva < captcha) {
            // 启动倒计时,为60 - 已经度过的秒数
            [self startCaptchaWithSecond:captcha - interva];
        }
        [self addTarget:self action:@selector(getCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


/**
 *  获取验证码点击
 */
- (void)getCaptcha:(id)sender {
    NSLog(@"%s", __func__);
    // 获取当前时间
    NSDate *date = [NSDate date];
    // 存储当前时间到偏好设置
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date"];
    // 启动定时器,倒计时60秒
    [self startCaptchaWithSecond:self.maxCaptcha];
}
/**
 *  启动定时器
 *  @param second 倒计时的秒数
 */
- (void)startCaptchaWithSecond:(float)second {
    // 判断定时器为空
    if (!self.captchaTimer) {
        // 记录剩余倒计时为传入的数值秒
        self.captcha = second;
        // 让按钮的启用为关闭,禁止交互
        self.enabled = NO;
        // 创建定时器重复每间隔1秒执行captchaChange方法,并赋值到全局定义好的变量
        self.captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(captchaChange) userInfo:nil repeats:YES];
        // 定时器启动
        [self.captchaTimer fire];
    }
    
}
// 计时器每秒调用事件
- (void)captchaChange {
    // 判断倒计时小余等于0的时候
    if (self.captcha <= 0 || ![self superview]) {
        // 标题恢复
        [self setTitle:self.title forState:UIControlStateNormal];
        // 按钮开启,可以交互点击
        self.enabled = YES;
        // 停止定时器
        [self stopCaptcha];
    }
    
    // 在setTitle之前给UIButton.titleLabel.text进行赋值就不会闪烁了
    self.titleLabel.text =[NSString stringWithFormat:@"重新发送:%zd秒" ,self.captcha];
    // 设置按钮的标题为当前剩余秒数
    [self setTitle:[NSString stringWithFormat:@"重新发送:%zd秒" ,self.captcha] forState:UIControlStateNormal];
    // 记录的秒数-1
    self.captcha --;
}

/**
 *  停止定时器
 */
- (void)stopCaptcha {
    [self.captchaTimer invalidate];
    self.captchaTimer = nil;
}

/**
 *  检测是否被释放
 */
- (void)dealloc {
    NSLog(@"%s" ,__func__);
}
@end
