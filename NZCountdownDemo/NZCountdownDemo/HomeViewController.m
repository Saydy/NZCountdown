//
//  HomeViewController.m
//  NZCountdownDemo
//
//  Created by DaysSummer on 16/3/2.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
}

- (void)login {
    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}
/**
 *  检测是否被释放
 */
- (void)dealloc {
    NSLog(@"dealloc: %@" ,[self class]);
}
@end
