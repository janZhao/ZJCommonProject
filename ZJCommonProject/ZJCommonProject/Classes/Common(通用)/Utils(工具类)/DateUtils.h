//
//  DateUtils.h
//  Calendar
//
//  Created by emma on 15/5/7.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

//获取本周的日期数组
+ (NSArray *)getDatesOfCurrence;

//获取距本周多少个周的日期数组,参数为1就代表下周，参数为2就是下下周，参数为-1就是上周
+ (NSArray *)getDatesSinceCurence:(int)weeks;

//日期转换成为字符串
+ (NSString *)stringFromDate:(NSDate *)date;

//更具日期-获取星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 *  获取未来某个日期是星期几
 *  注意：featureDate 传递过来的格式 必须 和 formatter.dateFormat 一致，否则endDate可能为nil
 *  测试了将来某个日期是星期几，未测试过去的某个日期是星期几
 *  实现思路:
 *  首先计算 未来的 某个日期 和 当前日期相差天数
 *  在获取当前是星期几（返回结果如下格式）
 *  暂且未用到~~
 */
+(NSString *)featureWeekdayWithDate:(NSString *)featureDate;

//计算某一天距离今天多少天，多少小时，多少分钟
+ (NSString *)intervalSinceNow: (NSString *) theDate;

/**
 * 计算最新消息的时间
 */
+ (NSString *)getMessageTime:(NSString *)strTime;

@end
