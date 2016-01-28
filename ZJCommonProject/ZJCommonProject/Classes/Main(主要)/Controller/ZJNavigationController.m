//
//  ZJNavigationController.m
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJNavigationController.h"

@interface ZJNavigationController ()

@end

@implementation ZJNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  第一次使用这个类的时候会调用(只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    // 设置背景
    
    // 设置文字属性
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    
    // 设置背景
    
    // 设置标题属性,大小，文字颜色等。
    
    // 设置UIBarButtonItem主色
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        //viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"return" highIcon:@"return_selected" target:self action:@selector(back)];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
