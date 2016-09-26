//
//  ConsulationHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsulationHttpRequest : NSObject

//请求咨询列表第一页数据
+ (void)requestNewData:(NSString *)url param:(NSDictionary *)param class:(Class)cls completionBlock:(void(^)(NSMutableArray *arr, NSString *message))completion;

//请求咨询列表更多数据
+ (void)requestMoreData:(NSString *)url param:(NSDictionary *)param class:(Class)cls completionBlock:(void(^)(NSMutableArray *arr, NSString *message))completion;

@end
