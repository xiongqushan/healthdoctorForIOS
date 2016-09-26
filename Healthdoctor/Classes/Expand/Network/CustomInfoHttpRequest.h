//
//  CustomInfoHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomInfoModel.h"

@interface CustomInfoHttpRequest : NSObject

//获取客户的个人信息
+ (void)requestInfo:(NSDictionary *)param completionBlock:(void(^)(CustomInfoModel *model, NSString *message))completion;

//删除客户所在分组
+ (void)deleteCustomGroup:(NSDictionary *)param completionBlock:(void(^)(NSString *message))completion;

@end
