//
//  ConsulationView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConsulationView.h"
#import "GKSliderView.h"
#import "HZAPI.h"
#import "HZUtils.h"

#define kOneDay 86400.0
#define kSixDay -518400.0
@implementation ConsulationView
{
    NSArray *_titleArr;
    NSString *_url;
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr url:(NSString *)url{
    if (self = [super initWithFrame:frame]) {
        _titleArr = titleArr;
        _url = url;
        
        [self setUpBaseUI];
    }
    
    return self;
}

//将日期转化成字符串
- (NSString *)getDateWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    return [NSString stringWithFormat:@"%ld-%0.2ld-%0.2ld",year,month,day];
}

//获取是当月的几号
- (NSString *)getDayWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
//    NSInteger year = [dateComponent year];
//    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    return [NSString stringWithFormat:@"%ld",day];
}

//根据传入的时间计算出查询时间范围
- (NSDictionary *)getDateFromDate:(NSTimeInterval)day {
    NSDate *starDate = [NSDate dateWithTimeInterval:day sinceDate:[NSDate date]];
    NSString *starDateStr = [self getDateWithDate:starDate];
    
    NSDate *endDate = [NSDate dateWithTimeInterval:kOneDay sinceDate:[NSDate date]];
    NSString *endDateStr = [self getDateWithDate:endDate];
    
    return @{@"starDate":starDateStr,@"endDate":endDateStr};
}

//因为三个滑动页面的cell样式相同，所以创建一个viewController 传入不同的参数
- (void)setUpBaseUI {
    
//    FilterViewController *one = [[FilterViewController alloc] init];
//    if ([_url isEqualToString:kGetProcessedURL]) {
//        NSDictionary *date = [self getDateFromDate:0];
//        one.starDate = date[@"starDate"];
//        one.endDate = date[@"endDate"];
//    }
//
//    one.url = _url;
//    one.flag = @"3";
//
//    FilterViewController *two = [[FilterViewController alloc] init];
//    if ([_url isEqualToString:kGetProcessedURL]) {
//        NSDictionary *week = [self getDateFromDate:kSixDay];
//        two.starDate = week[@"starDate"];
//        two.endDate = week[@"endDate"];
//    }
//    two.url = _url;
//    two.flag = @"2";
//
//    FilterViewController *three = [[FilterViewController alloc] init];
//    if ([_url isEqualToString:kGetProcessedURL]) {
//        NSInteger day = [[self getDayWithDate:[NSDate date]] integerValue];
//        NSDictionary *month = [self getDateFromDate:(day - 1)*(-kOneDay)];
//        three.starDate = month[@"starDate"];
//        three.endDate = month[@"endDate"];
//    }
//    three.url = _url;
//    three.flag = @"1";
//    NSArray *control = @[one,two,three];
    
    //使用for循环创建三个控制器对象 以flag 来加载不同的数据
    NSMutableArray *control = [NSMutableArray array];
    NSInteger day = [[self getDayWithDate:[NSDate date]] integerValue];
    NSTimeInterval inter = (day - 1)*(-kOneDay);
    NSArray *arr = @[@(0),@(kSixDay),@(inter)];
    
    for (NSInteger i = 0; i < 3; i++) {
        
        FilterViewController *one = [[FilterViewController alloc] init];
        if (i == 0) {
            one.badgeBlock = ^(NSInteger count) {
                if (self.badgeBlock) {
                    self.badgeBlock(count);
                }
            };
        }

        one.url = _url;
        //当是已处理界面的时候  是以日期范围作为参数进行数据请求的
        if ([_url isEqualToString:kGetProcessedURL]) {
            NSDictionary *date = [self getDateFromDate:[arr[i] doubleValue]];
            one.starDate = date[@"starDate"];
            one.endDate = date[@"endDate"];
        }else {
            
            one.flag = [NSString stringWithFormat:@"%ld",3-i];
        }
        
        [control addObject:one];
    }
    
    GKSliderView *slider = [[GKSliderView alloc] initWithFrame:self.bounds titleArr:_titleArr controllerNameArr:control];
    slider.titleFont = [UIFont systemFontOfSize:15];
    [self addSubview:slider];
}

@end
