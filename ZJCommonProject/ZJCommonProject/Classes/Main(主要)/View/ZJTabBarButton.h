//
//  ZJTabBarButton.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJTabBarButton : UIButton

#warning UITabBarItem是一个模型，自定义的JSTabBarButton拥有这个模型
@property (nonatomic, strong) UITabBarItem *item;

@end
