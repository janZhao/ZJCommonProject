//
//  ZJTabBarViewController.m
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJTabBarViewController.h"
#import "ZJNavigationController.h"
#import "ZJSettingViewController.h"

@interface ZJTabBarViewController ()<ZJTabBarDelegete>

@end

@implementation ZJTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.初始化TabBar
    [self setupTabBar];
    
    //2.初始化所有子控制器
    [self setupAllChildViewControllers];
    
}

/**
 *初始化TabBar
 */
-(void)setupTabBar
{
    //第一种方法
    ZJTabBar *customTabBar = [[ZJTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    //设置代理
    customTabBar.delegete = self;
    [self.tabBar addSubview:customTabBar];
    [self.tabBar bringSubviewToFront:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  将其本身自带的TabBar中的button移除
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //第一种方法
    for (UIView *childView in self.tabBar.subviews)
    {
        //JYDLog(@"%@", [childView class]);
        
        if ([childView isKindOfClass:[UIControl class]])
        {
            [childView removeFromSuperview];
        }
    }
}

/**
 *  初始化所有子控制器
 */
-(void)setupAllChildViewControllers
{
    // 1.
    UIViewController *firstVc = [[UIViewController alloc]init];
    [self setupChildViewController:firstVc title:@"微信" imageName:@"tabbar_mainframe" selectedImageName:@"tabbar_mainframeHL"];
    
    // 2.
    UIViewController *secondVc = [[UIViewController alloc]init];
    [self setupChildViewController:secondVc title:@"通讯录" imageName:@"tabbar_contacts" selectedImageName:@"tabbar_contactsHL"];
    
    // 3.
    UIViewController *thirdVc = [[UIViewController alloc]init];
    [self setupChildViewController:thirdVc title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discoverHL"];
    
    // 4.
    ZJSettingViewController *fourVc = [[ZJSettingViewController alloc]init];
    [self setupChildViewController:fourVc title:@"我" imageName:@"tabbar_me" selectedImageName:@"tabbar_meHL"];
}


/**
 *  添加子控制器
 *
 *  @param childVc           子控制器名称
 *  @param title             title
 *  @param imageName         图片名称
 *  @param selectedImageName 选中时候图片名称
 */
-(void)setupChildViewController:(UIViewController *) childVc title:(NSString *) title imageName:(NSString *) imageName selectedImageName:(NSString *) selectedImageName
{
    //1.设置控制器属性
    childVc.title = title;
    //2.设置图片
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //3.设置选中后图片
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    //4.添加导航控制器
    ZJNavigationController *navi = [[ZJNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:navi];
    //5.添加自定义TabBar按钮、设置按钮属性
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

-(void)tabBar:(ZJTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    //切换导航控制器
    self.selectedIndex = to;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [child removeFromSuperview];
            
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
