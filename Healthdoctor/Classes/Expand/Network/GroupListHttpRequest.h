//
//  GroupListHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupListHttpRequest : NSObject

+ (instancetype)getInstatce;

//请求分组客户列表第一页数据
- (void)requestNewData:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *dataArr, NSString *message))completion;

//请求分组客户列表更多数据
- (void)requestMoreData:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *dataArr, NSString *message))completion;

@end
