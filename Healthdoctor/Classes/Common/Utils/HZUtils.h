//
//  HZUtils.h
//  Health
//
//  Created by 郭凯 on 16/5/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface HZUtils : NSObject

//按照aColor颜色创建一张size大小的图片
+ (UIImage *)imageForColor:(UIColor *)color size:(CGSize)size;

//创建提示框并显示在View上
+ (MBProgressHUD *)createHUD;

//显示一个只带有标题的提示框，并1秒之后自动消失
+ (void)showHUDWithTitle:(NSString *)title;

//判断是不是手机号
+ (BOOL)isPhoneNumber:(NSString *)phoneNumber;

//根据内容获取宽度
+ (CGSize)getWidthWithFont:(UIFont *)font text:(NSString *)text maxHeight:(CGFloat)height;

//根据内容获取高度
+ (CGSize)getHeightWithFont:(UIFont *)font title:(NSString *)title maxWidth:(CGFloat)width;

//日期转字符串
+ (NSString *)getDateWithDate:(NSDate *)date;

//字符串转日期 yyyy-MM-dd
+ (NSDate *)stringToDate:(NSString *)str;

//比较两个日期格式的字符串的大小  返回值1-->date01大    2-->date02大
+ (int)compareDate:(NSString *)date01 withDate:(NSString *)date02;

//根据传入的日期字符串返回相应的日期，比如 10:01，昨天，星期，16/8/7
+ (NSString *)getDetailDateStrWithDate:(NSString *)date;

//判断首字母是否为数字
+ (BOOL)isNumAtFirst:(NSString *)str;

//根据出生日期得出岁数
+ (NSString *)getAgeWithBirthday:(NSString *)birthday;

//获得性别
+ (NSString *)getGender:(NSString *)gender;

@end
