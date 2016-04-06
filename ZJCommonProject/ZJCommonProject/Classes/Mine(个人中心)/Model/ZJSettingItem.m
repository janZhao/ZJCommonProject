//
//  ZJSettingItem.m
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJSettingItem.h"

@implementation ZJSettingItem

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZJSettingItemType)type detailTitle:(NSString *)detailTitle
{
    ZJSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    item.detailTitle = detailTitle;
    
    return item;
}

@end
