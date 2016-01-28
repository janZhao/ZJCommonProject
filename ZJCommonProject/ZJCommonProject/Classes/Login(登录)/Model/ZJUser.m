//
//  ZJUser.m
//  ZJCommonProject
//
//  Created by jyd on 16/1/27.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "ZJUser.h"

@implementation ZJUser

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        [self setValue:value forKey:@"idStr"];
    }
    else if ([key isEqualToString:@"description"])
    {
        [self setValue:value forKey:@"descriptionStr"];
    }
}

@end
