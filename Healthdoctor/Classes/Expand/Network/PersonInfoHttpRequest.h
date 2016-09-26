//
//  PersonInfoHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoHttpRequest : NSObject

//请求职称
+ (void)requestProfessional:(void(^)(NSString *professional, NSString *message))completion;

//请求所属机构名
+ (void)requestDepartmentName:(void(^)(NSString *department, NSString *message))completion;

@end
