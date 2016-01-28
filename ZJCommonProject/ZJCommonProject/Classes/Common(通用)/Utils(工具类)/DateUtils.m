//
//  DateUtils.m
//  Calendar
//
//  Created by emma on 15/5/7.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

//获取本周的日期数组
+ (NSArray *)getDatesOfCurrence
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2]; //1代表周日，2代表周一
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:now];
    NSInteger weekDay = [components weekday];
    // 得到几号
    NSInteger day = [components day];
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff;
    if (weekDay == 1) {
        firstDiff = 1-7;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
    }
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    
    NSString *month = [NSString stringWithFormat:@"%d月",[firstDayComp month]];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:8];
    
    //添加上每天的日期 2015-10-26 --add by zhaojian
    NSMutableArray *dateStrArr = [[NSMutableArray alloc]initWithCapacity:8];
    
    [array addObject:month];
    for (int i = 0; i< 7; i++) {
        [components setDay:[firstDayComp day] + i];
        NSDate *everyDate = [calendar dateFromComponents:components];
        components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:everyDate];
        [array addObject:[NSString stringWithFormat:@"%d",[components day]]];
        
        //添加上每天的日期 2015-10-26 --add by zhaojian
        NSString *everyDateStr = [DateUtils stringFromDate:everyDate];
        [dateStrArr addObject:everyDateStr];
    }
    
    //添加上每天的日期 2015-10-26 --add by zhaojian
    [array addObjectsFromArray:dateStrArr];
    
    return array;
}

//获取距离当前多少周的日期数组
+ (NSArray *)getDatesSinceCurence:(int)weeks
{
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:weeks*7*24*60*60];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2]; //1代表周日，2代表周一
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:now];
    NSInteger weekDay = [components weekday];
    // 得到几号
    NSInteger day = [components day];
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 7;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 8 - weekDay;
    }
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    
    NSString *month = [NSString stringWithFormat:@"%ld月",(long)[firstDayComp month]];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:8];
    
     //添加上每天的日期 2015-10-26 --add by zhaojian
    NSMutableArray *dateStrArr = [[NSMutableArray alloc]initWithCapacity:8];
    
    [array addObject:month];
    for (int i = 0; i< 7; i++) {
        [components setDay:[firstDayComp day] + i];
        NSDate *everyDate = [calendar dateFromComponents:components];
        NSDateComponents *everCom = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:everyDate];
        [array addObject:[NSString stringWithFormat:@"%ld",(long)[everCom day]]];
        
        //添加上每天的日期 2015-10-26 --add by zhaojian
        NSString *everyDateStr = [DateUtils stringFromDate:everyDate];
        [dateStrArr addObject:everyDateStr];
    }
    
    //添加上每天的日期 2015-10-26 --add by zhaojian
    [array addObjectsFromArray:dateStrArr];
    
    return array;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

/**
 *  根据日期获取--星期一、二、三
 *  add by zhaojian 2015-10-26
 *  @param inputDate
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate
{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    //[calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/**
 *  add by zhaojian 2015-10-24
 */
+ (NSString *)featureWeekdayWithDate:(NSString *)featureDate
{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:endDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    switch (week) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    return nil;
}

/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
+ (NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0)
    {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else
    {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days + 1;
    }
}

// 获取当前是星期几
+ (NSInteger)getNowWeekday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

//计算某一天距离今天多少天，多少小时，多少分钟
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSString *timeString=@"";
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:theDate];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    //获取当前时间
    NSDate *adate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: adate];
    NSDate *localeDate = [adate  dateByAddingTimeInterval: interval];
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    long lTime = fabs((long)intervalTime);
    NSInteger iSeconds =  lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = fabs(lTime/3600);
    NSInteger iDays = lTime/60/60/24;
    NSInteger iMonth =lTime/60/60/24/12;
    NSInteger iYears = lTime/60/60/24/384;
    
    
    NSLog(@"相差%d年%d月 或者 %d日%d时%d分%d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    
    
    if (iHours<1 && iMinutes>0)
    {
        timeString=[NSString stringWithFormat:@"%d分",iMinutes];
        
    }else if (iHours>0&&iDays<1 && iMinutes>0) {
        timeString=[NSString stringWithFormat:@"%d时%d分",iHours,iMinutes];
    }
    else if (iHours>0&&iDays<1) {
        timeString=[NSString stringWithFormat:@"%d时",iHours];
    }else if (iDays>0 && iHours>0)
    {
        timeString=[NSString stringWithFormat:@"%d天%d时",iDays,iHours];
    }
    else if (iDays>0)
    {
        timeString=[NSString stringWithFormat:@"%d天",iDays];
    }
    return timeString;
}


/**
 * 计算最新消息的时间
 */
+ (NSString *)getMessageTime:(NSString *)strTime
{
    if (strTime.length==0) {
        return nil;
    }
    NSString *format = @"yyyyMMdd HH:mm";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSDate *dateMessage = [formatter dateFromString:strTime];
    NSTimeInterval t = [dateMessage timeIntervalSinceNow];
    double fabsT = fabs(t);
    int day = fabsT/(24*3600);
    int hour = fabsT/(3600)-day*24;
    int min = fabsT/60-day*24*60-hour*60;
    if (day>0) {
        return [NSString stringWithFormat:@"%d天前",day];
    }
    else if (hour>0){
        return [NSString stringWithFormat:@"%d小时前",hour];
    }
    else if (min>0) {
        return [NSString stringWithFormat:@"%d分钟前",min];
    }
    else {
        return @"刚刚";
    }
    return nil;
}

@end
