//
//  CustomDetailHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomDetailHttpRequest : NSObject

//获取客户体检报告列表
+ (void)requestReportList:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *dataArr, NSString *message))completion;

//获取照片病例列表
+ (void)requestPhotoCasesList:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *dataArr, NSString *message))completion;

@end
