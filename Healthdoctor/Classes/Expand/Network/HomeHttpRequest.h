//
//  HomeHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeGroupModel.h"

@interface HomeHttpRequest : NSObject

//主页分组 HTTP 请求
+ (void)requestHomeData:(NSDictionary *)param completionBlock:(void(^)(NSArray *dataArr, NSString *message))completion;

@end
