//
//  SecondViewController.m
//  CQCountDownButton
//
//  Created by 蔡强 on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "SecondViewController.h"
#import "CQCountDownButton.h"
#import <SVProgressHUD.h>

@interface SecondViewController ()

/** 倒计时按钮 */
@property (nonatomic, strong) CQCountDownButton *countDownButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.countDownButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(90, 90, 150, 30) duration:10 countDownStart:^{
        //------- 倒计时开始 -------//
        NSLog(@"倒计时开始");
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        [self.countDownButton setTitle:[NSString stringWithFormat:@"再次获取(%ld秒)", restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        self.countDownButton.enabled = YES;
        NSLog(@"倒计时结束");
    }];
    [self.view addSubview:self.countDownButton];
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.countDownButton addTarget:self action:@selector(countDownButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

/** 倒计时按钮点击 */
- (void)countDownButtonClicked:(CQCountDownButton *)sender {
    // 点击倒计时按钮后立即将enabled设为NO
    sender.enabled = NO;
    
    // 假装在请求数据。。。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
        // 获取到验证码后开始倒计时
        [sender startCountDown];
    });
}

- (void)dealloc {
    [SVProgressHUD showSuccessWithStatus:@"页面2已释放"];
}

@end
