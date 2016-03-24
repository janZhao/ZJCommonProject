//
//  LoginViewController.m
//  ZJCommonProject
//
//  Created by jyd on 16/2/22.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "LoginViewController.h"
#import "GetUserInfoApi.h"

@interface LoginViewController ()<YTKRequestDelegate>

/**
 *  手机号 或者 用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (weak, nonatomic) IBOutlet UILabel *weChatQQLoginTipsLbl;

//手势识别
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation LoginViewController

-(void)viewDidLoad
{
    self.phoneTextField.text = @"18501956520";
    self.pwdTextField.text   = @"123456";
}

#pragma mark 按钮点击事件
- (IBAction)loginButtonClick:(id)sender
{
    DDLogDebug(@"点击登录按钮");
    
    // 检测用户输入是否合法
    [self.view endEditing:YES];
    
    // 获取用户输入的登录信息
    NSString *username = self.phoneTextField.text;
    NSString *password = self.pwdTextField.text;
    
    if (username.length > 0 && password.length > 0)
    {
        GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUsername:username password:password loginType:@"loginsystem" userType:@"2"];
        api.delegate = self;
        [api start];
    }

}

#pragma -mark 输入框弹起后单击事件
- (void)tapGestureAction:(UIGestureRecognizer *)gesture
{
    [self.phoneTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

- (void)requestFinished:(YTKBaseRequest *)request
{
    DDLogVerbose(@"succeed GetUserInfoApi");
}

- (void)requestFailed:(YTKBaseRequest *)request
{
    NSLog(@"failed");
}

@end
