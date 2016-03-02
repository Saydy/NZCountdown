//
//  LoginViewController.m
//  NZCountdownDemo
//
//  Created by DaysSummer on 16/3/2.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import "LoginViewController.h"
#import "NZCountdownButton.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NZCountdownButton *countdown = [[NZCountdownButton alloc] initWithTitle:@"点击获取验证码" Captcha:10];
    countdown.frame = CGRectMake(0, 100, 100, 44);
    countdown.backgroundColor = [UIColor cyanColor];
    countdown.titleLabel.font = [UIFont systemFontOfSize:14];
    [countdown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [countdown setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [countdown addTarget:self action:@selector(countdownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countdown];
}

- (void)countdownBtnClick:(UIButton *)sender {
    NSLog(@"%s 发送验证码" ,__func__);
}
/**
 *  检测是否被释放
 */
- (void)dealloc {
    NSLog(@"%s" ,__func__);
}
@end
