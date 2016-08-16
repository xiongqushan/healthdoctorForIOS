//
//  HZUtils.m
//  Health
//
//  Created by 郭凯 on 16/5/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZUtils.h"
#import <MBProgressHUD.h>

#define kOneWeek 604800.0
#define kOneDay 86400.0
#define kSixDay 518400.0

@implementation HZUtils

+ (UIImage *)imageForColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (MBProgressHUD *)createHUD {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
//    //HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
//    [window addSubview:HUD];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
   // [HUD show:YES];
    //HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.removeFromSuperViewOnHide = YES;
    
    return HUD;
}

+ (void)showHUDWithTitle:(NSString *)title {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = title;
    [HUD hide:YES afterDelay:1];
}

+ (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length < 11) {
       // [HZUtils showHUDWithTitle:@"请输入正确的手机号"];
        return NO;
    }else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phoneNumber];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phoneNumber];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phoneNumber];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
            
        }else{
           // [HZUtils showHUDWithTitle:@"请输入正确的手机号"];
            return NO;
        }
    }
}

+ (BOOL)isNumAtFirst:(NSString *)str {
    NSString *subStr = [str substringToIndex:1];
//    if ([subStr integerValue] >= 1 || [subStr integerValue] <= 9) {
//        
//    }
    if ([subStr integerValue]) {
        return YES;
    }
    
    return NO;
}


+ (CGSize)getHeightWithFont:(UIFont *)font title:(NSString *)title maxWidth:(CGFloat)width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [title boundingRectWithSize:CGSizeMake(width, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

+ (CGSize)getWidthWithFont:(UIFont *)font text:(NSString *)text maxHeight:(CGFloat)height {
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(1000.0f, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

//将日期转化成字符串
+ (NSString *)getDateWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
     //   CommitOn = "2016-06-21T18:34:47";
    return [NSString stringWithFormat:@"%ld-%0.2ld-%0.2ldT%0.2ld:%0.2ld:%0.2ld",year,month,day,hour,minute,second];
}
//将字符串装换成日期
+ (NSDate *)stringToDate:(NSString *)str {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [inputFormatter dateFromString:str];
    return date;
}

//比较两个日期的大小 返回值1-->date01大    2-->date02大
+ (int)compareDate:(NSString *)date01 withDate:(NSString *)date02 {
    //int c1;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [df dateFromString:date01];
    NSDate *dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    
    if (result == NSOrderedDescending) {
        return 1;
    }else if (result == NSOrderedAscending) {
        return -1;
    }
    
    return 0;
}

//根据传入的日期返回星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

// 2016-06-16 13:41:26
+ (NSString *)getDetailDateStrWithDate:(NSString *)date {
    
    NSArray *dateArr = [date componentsSeparatedByString:@" "];
    //获取当天的日期字符串
    NSDate * currentDate = [NSDate date];
    NSString *currentDateStr = [self getDateWithDate:currentDate];
    NSArray *currentDateArr = [currentDateStr componentsSeparatedByString:@"T"];
    currentDateStr = currentDateArr[0];
    
    NSLog(@"______currentDateStr:%@",currentDateStr);
    if ([currentDateStr isEqualToString:dateArr[0]]) {
        //今天的时间
        return [dateArr[1] substringToIndex:5];
    }
    
    //获取昨天日期字符串
    NSDate *yesterdayDate = [NSDate dateWithTimeInterval:-kOneDay sinceDate:currentDate];
    NSString *yesterdayDateStr = [[[self getDateWithDate:yesterdayDate] componentsSeparatedByString:@"T"] firstObject];
    NSLog(@"______yesterdayDateStr:%@",yesterdayDateStr);
    if ([yesterdayDateStr isEqualToString:dateArr[0]]) {
        //昨天
        return @"昨天";
    }
    
    //获取相对今天差一个星期的日期字符串
    NSDate *oneWeekDate = [NSDate dateWithTimeInterval:-kSixDay sinceDate:currentDate];
    NSString *oneWeekDateStr = [[[self getDateWithDate:oneWeekDate] componentsSeparatedByString:@"T"] firstObject];
    NSLog(@"______oneWeekDateStr:%@",oneWeekDateStr);
    int isDate = [self compareDate:dateArr[0] withDate:oneWeekDateStr];
    if (isDate == -1) {
        //返回日期
        return dateArr[0];
    }else {
        //返回星期
        return [self weekdayStringFromDate:[self stringToDate:dateArr[0]]];
    }
    
    
    //return @"123";
}
@end
