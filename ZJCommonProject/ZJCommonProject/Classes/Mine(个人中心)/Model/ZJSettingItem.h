//
//  ZJSettingItem.h
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZJSettingItemType){
    ZFSettingItemTypeNone, // 什么也没有
    ZFSettingItemTypeArrow, // 箭头
    ZFSettingItemTypeSwitch // 开关
};

@interface ZJSettingItem : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detailTitle;

//Cell的样式
@property (nonatomic, assign) ZJSettingItemType type;

//Cell开关的操作
@property (nonatomic, copy) void (^switchBlock)(BOOL on);

//点击Cell执行的操作
@property (nonatomic, copy) void (^operation)();

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZJSettingItemType)type detailTitle:(NSString *)detailTitle;

@end
