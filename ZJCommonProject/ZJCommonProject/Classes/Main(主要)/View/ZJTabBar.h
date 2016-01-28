//
//  ZJTabBar.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJTabBarButton.h"

@class ZJTabBar;

@protocol ZJTabBarDelegete <NSObject>

@optional
-(void)tabBar:(ZJTabBar *) tabBar didSelectedButtonFrom:(int) from to:(int) to;

@end

@interface ZJTabBar : UIView

-(void)addTabBarButtonWithItem:(UITabBarItem *) item;

//自定义协议，用于Button点击的时候导航之间的相互切换
@property (nonatomic, weak) id<ZJTabBarDelegete> delegete;

@property (nonatomic, strong) ZJTabBarButton *selectedButton;

@end