//
//  ZJUser.h
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJUser : NSObject

/**
 *  用户sessionID
 */
@property (nonatomic, copy) NSString *sessionId;

/**
 * 用户id
 */
@property (nonatomic, copy) NSString *idStr;

/**
 * 真实姓名
 */
@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *cityId;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *descriptionStr;

/**
 * 由字典构造对象
 */
+ (instancetype)userWithDict:(NSDictionary *)dict;

/**
 * 由字典构造对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
