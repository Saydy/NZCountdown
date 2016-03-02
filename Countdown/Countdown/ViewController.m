//
//  ViewController.m
//  Countdown
//
//  Created by DaysSummer on 16/3/1.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// 定时器
@property (nonatomic ,strong) NSTimer *captchaTimer;
// 倒计时数值
@property (nonatomic ,assign)NSInteger captcha;
// 获取验证码的按钮
@property (weak, nonatomic) IBOutlet UIButton *captchaBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取偏好设置中保存的时间
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    // 获取当前时间和获取保存的时间的间隔
    float interva = [[NSDate date] timeIntervalSinceDate:date];
    // 判断小余60秒
    if (interva < 60) {
        // 启动倒计时,为60 - 已经度过的秒数
        [self startCaptchaWithSecond:60 - interva];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopCaptcha];
}

/**
 *  获取验证码点击
 */
- (IBAction)getCaptcha:(id)sender {
    NSLog(@"%s", __func__);
    // 获取当前时间
    NSDate *date = [NSDate date];
    // 存储当前时间到偏好设置
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date"];
    // 启动定时器,倒计时60秒
    [self startCaptchaWithSecond:60.0];
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
        self.captchaBtn.enabled = NO;
        // 创建定时器重复每间隔1秒执行captchaChange方法,并赋值到全局定义好的变量
        self.captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(captchaChange) userInfo:nil repeats:YES];
        // 定时器启动
        [self.captchaTimer fire];
    }

}
// 计时器每秒调用事件
- (void)captchaChange {
    // 记录的秒数-1
    self.captcha --;
    // 在setTitle之前给UIButton.titleLabel.text进行赋值就不会闪烁了
    self.captchaBtn.titleLabel.text =[NSString stringWithFormat:@"重新发送:%zd秒" ,self.captcha];
    // 设置按钮的标题为当前剩余秒数
    [self.captchaBtn setTitle:[NSString stringWithFormat:@"重新发送:%zd秒" ,self.captcha] forState:UIControlStateNormal];
    // 判断倒计时小余等于0的时候
    if (self.captcha <= 0) {
        // 标题恢复
        [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        // 按钮开启,可以交互点击
        self.captchaBtn.enabled = YES;
        // 停止定时器
        [self stopCaptcha];
    }
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
    NSLog(@"dealloc: %@" ,[self class]);
}
@end
