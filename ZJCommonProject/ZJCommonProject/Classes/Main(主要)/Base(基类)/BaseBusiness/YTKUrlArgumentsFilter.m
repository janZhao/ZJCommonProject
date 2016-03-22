//
//  YTKUrlArgumentsFilter.m
//  ZJCommonProject
//
//  Created by jyd on 16/2/22.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "YTKUrlArgumentsFilter.h"

#import "YTKNetworkPrivate.h"

@implementation YTKUrlArgumentsFilter {
    NSDictionary *_arguments;
}

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [YTKNetworkPrivate urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

@end
