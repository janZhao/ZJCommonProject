//
//  RegisterApi.m
//  ZJCommonProject
//
//  Created by jyd on 16/2/22.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi
{
    NSString *_username;
    NSString *_password;
}

-(id)initWithUsername:(NSString *)username password:(NSString *)password
{
    self = [super init];
    
    if (self) {
        _username = username;
        _password = password;
    }
    
    return self;
}

-(NSString *)requestUrl
{
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/iphone/register";
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

-(id)requestArgument
{
    return @{
             @"username": _username,
             @"password": _password
             };
}

-(id)jsonValidator
{
    return @{
             @"userId": [NSNumber class],
             @"nick": [NSString class],
             @"level": [NSNumber class]
             };
}

@end
