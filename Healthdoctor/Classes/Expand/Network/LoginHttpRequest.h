//
//  LoginHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHttpRequest : NSObject

+ (void)requestLogin:(NSDictionary *)param completionBlock:(void(^)(NSString *doctorId, NSString *message))completion;

@end
