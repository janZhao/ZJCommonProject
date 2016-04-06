//
//  ZJSettingGroup.h
//  ZJCommonProject
//
//  Created by jyd on 16/4/1.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJSettingGroup : NSObject

@property (nonatomic, copy) NSString *header; // 头部标题

@property (nonatomic, copy) NSString *footer; // 尾部标题

@property (nonatomic, strong) NSArray *items; // 中间的条目


@end
