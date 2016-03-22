//
//  GetUserInfoApi.m
//  ZJCommonProject
//
//  Created by jyd on 16/2/22.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "GetUserInfoApi.h"

@implementation GetUserInfoApi
{
    NSString *_username;
    NSString *_password;
    NSString *_loginType;
    NSString *_userType;
}

- (id)initWithUsername:(NSString *)username
              password:(NSString *)password
             loginType:(NSString *)loginType
              userType:(NSString *)userType
{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        _loginType = loginType;
        _userType = userType;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"/app/user/login.action";
}

-(id)requestArgument
{
    return @{
             @"phone": _username,
             @"password": _password,
             @"loginType": _loginType,
             @"userType": _userType
             };
}
/**
 * STATUS = 0;
 result =     {
 birthday = "";
 cityId = 500101;
 consolidateTime = 2;
 currency = "96.0";
 description = "";
 friendAuth = 1;
 gender = 1;
 gradeType = 4;
 id = 5901;
 nickName = "\U8d75\U5065";
 phone = 18501956520;
 picUrl = "http://www.wenba99.com/upload/userpic/20160222/20160222141717855303.jpg";
 provinceId = 3;
 reviewTime = 1;
 searchAuth = 1;
 semesterType = 5;
 sessionId = 15BAC36CBAFD99AF3F067EA0D460B15A;
 textbookType = 1;
 trophyNumber = 68;
 userType = 2;
 };
 }
 *
 */
- (id)jsonValidator
{
    return @{
             @"STATUS": [NSString class],
             @"result": @{
                     @"birthday": [NSString class],
                     @"cityId":  [NSString class],
                     @"consolidateTime": [NSString class],
                     @"currency": [NSString class],
                     @"description": [NSString class],
                     @"friendAuth": [NSString class],
                     @"gender": [NSString class],
                     @"gradeType": [NSString class],
                     @"id": [NSString class],
                     @"nickName":[NSString class],
                     @"phone": [NSString class],
                     @"picUrl":[NSString class],
                     @"provinceId":[NSString class],
                     @"reviewTime":[NSString class],
                     @"searchAuth":[NSString class],
                     @"semesterType":[NSString class],
                     @"sessionId":[NSString class],
                     @"textbookType":[NSString class],
                     @"trophyNumber":[NSString class],
                     @"userType":[NSString class]
                     }
      };
}

//- (id)jsonValidator
//{
//    return @[@{
//                 @"id": [NSNumber class],
//                 @"imageId": [NSString class],
//                 @"time": [NSNumber class],
//                 @"status": [NSNumber class],
//                 @"question": @{
//                         @"id": [NSNumber class],
//                         @"content": [NSString class],
//                         @"contentType": [NSNumber class]
//                         }
//                 }];
//}

//- (NSInteger)cacheTimeInSeconds
//{
//    return 60 * 3;
//}

-(NSString *)userId
{
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}

@end
