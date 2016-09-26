//
//  ReportHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportHttpRequest : NSObject

//请求体检报告数据
+ (void)requestReport:(NSDictionary *)param completionBlock:(void(^)(NSDictionary *dicts, NSString *message))completion;

@end
