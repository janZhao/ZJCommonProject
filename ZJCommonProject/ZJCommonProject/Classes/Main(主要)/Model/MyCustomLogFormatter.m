//
//  MyCustomLogFormatter.m
//  ZJCommonProject
//
//  Created by jyd on 16/2/25.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "MyCustomLogFormatter.h"

@implementation MyCustomLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    //NSMutableDictionary *logDict = [NSMutableDictionary dictionary];
    //取得文件名
    NSString *locationString;
    NSArray *parts = [logMessage->_file componentsSeparatedByString:@"/"];
    
    if ([parts count] > 0)
    {
        locationString = [parts lastObject];
    }

    if ([locationString length] == 0)
    {
        locationString = @"No file";
    }

    //这里的格式: {"location":"myfile.m:120(void a::sub(int)"}， 文件名，行数和函数名是用的编译器宏 __FILE__, __LINE__, __PRETTY_FUNCTION__
    //logDict[@"location"] = [NSString stringWithFormat:@"%@:%lu(%@)", locationString, (unsigned long)logMessage->_line, logMessage->_function];
    
    NSString *logLevel = nil;
    switch (logMessage->_flag)
    {
        case LOG_FLAG_ERROR:
            logLevel = @"[ERROR] >  ";
            break;
        case LOG_FLAG_WARN:
            logLevel = @"[WARN]  >  ";
            break;
        case LOG_FLAG_INFO:
            logLevel = @"[INFO]  >  ";
            break;
        case LOG_FLAG_DEBUG:
            logLevel = @"[DEBUG] >  ";
            break;
        default:
            logLevel = @"[VBOSE] >  ";
            break;
    }
    
    //logDict[@"Level"] = [NSString stringWithFormat:@"%@[%@ %@][line %lu] %@",logLevel, logMessage.fileName,logMessage->_function, (unsigned long)logMessage->_line, logMessage->_message];
    
    NSString *formatStr = [NSString stringWithFormat:@"%@[%@ %@][line %lu] %@",
                           logLevel, logMessage.fileName, logMessage->_function,
                           (unsigned long)logMessage->_line, logMessage->_message];

    return  formatStr;
    
    //尝试将logDict内容转为字符串，其实这里可以直接构造字符串，但真实项目中，肯定需要很多其他的信息，不可能仅仅文件名、行数和函数名就够了的。
    //NSError *error;
    //NSData *outputJson = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:&error];
    //if (error)
    //{
    //    return @"{\"Level\":\"error\"}";
   // }

    //NSString *jsonString = [[NSString alloc] initWithData:outputJson encoding:NSUTF8StringEncoding];
    //if (jsonString)
    //{
    //    return jsonString;
    //}

    //return @"{\"Level\":\"error\"}";
}
@end
