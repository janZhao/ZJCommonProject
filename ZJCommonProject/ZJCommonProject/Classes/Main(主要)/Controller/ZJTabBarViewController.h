//
//  ZJTabBarViewController.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTabBar.h"

@interface ZJTabBarViewController : UITabBarController

@property (nonatomic, strong) ZJTabBar *customTabBar;

//传参需要
@property (assign, nonatomic) NSInteger selectedAtIndexParam;

@end
