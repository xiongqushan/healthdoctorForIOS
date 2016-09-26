//
//  ChartHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CusInfoModel.h"
#import "ChartModel.h"

@interface ChartHttpRequest : NSObject

//获取客户的聊天记录
+ (void)requestData:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *arr, NSString *message))completion;

//获取聊天客户的个人信息
+ (void)requestChartCusInfo:(NSDictionary *)param completionBlock:(void(^)(CusInfoModel *model, NSString *message))completion;

//发送消息
+ (void)replyMessage:(NSDictionary *)param completionBlock:(void(^)(ChartModel *model, NSString *message))completion;

@end
