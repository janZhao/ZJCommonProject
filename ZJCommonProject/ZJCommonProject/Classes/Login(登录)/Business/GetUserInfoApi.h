//
//  GetUserInfoApi.h
//  ZJCommonProject
//
//  Created by jyd on 16/2/22.
//  Copyright © 2016年 jyd. All rights reserved.
//
#import "YTKBaseRequest.h"

@interface GetUserInfoApi : YTKBaseRequest

- (id)initWithUsername:(NSString *)username
              password:(NSString *)password
              loginType:(NSString *)loginType
              userType:(NSString *)userType;

- (NSString *)userId;

@end
