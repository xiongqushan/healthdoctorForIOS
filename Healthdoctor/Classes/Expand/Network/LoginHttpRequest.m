//
//  LoginHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "LoginHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUser.h"
#import <MJExtension.h>
#import "Config.h"
#import "JPUSHService.h"

@implementation LoginHttpRequest

+ (void)requestLogin:(NSDictionary *)param completionBlock:(void (^)(NSString *, NSString *))completion {
    [[GKNetwork sharedInstance] postUrl:kLoginValidateURL param:param completionBlock:^(id responseObject, NSError *error) {
       
        if (error) {
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil, message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil, responseObject[@"message"]);
                return ;
            }
            
            NSDictionary *data = responseObject[@"Data"];
            
            HZUser *user = [HZUser mj_objectWithKeyValues:data];
            [Config saveProfile:user];
            
            completion(user.doctorId, nil);
        }
    }];
}

@end
