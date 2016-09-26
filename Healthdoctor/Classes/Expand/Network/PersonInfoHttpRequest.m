//
//  PersonInfoHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PersonInfoHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "Config.h"

@implementation PersonInfoHttpRequest

+ (void)requestProfessional:(void (^)(NSString *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kBasConstListURL param:nil completionBlock:^(id responseObject, NSError *error) {
        
        NSString * position = [Config getProfile].position;
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil,responseObject[@"message"]);
                return ;
            }
            
            NSArray *arr = responseObject[@"Data"];
            for (NSDictionary *dict in arr) {
                if ([dict[@"Code"] integerValue] == [position integerValue]) {
                //    self.professional = dict[@"Name"];
                    completion(dict[@"Name"],nil);
                }
            }
        }
    }];
}


+ (void)requestDepartmentName:(void (^)(NSString *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kServiceDeptListURL param:nil completionBlock:^(id responseObject, NSError *error) {
        
        NSString *dept = [Config getProfile].dept;
        if (error) {
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil,responseObject[@"message"]);
                return ;
            }
            
            NSArray *arr = responseObject[@"Data"];
            for (NSDictionary *dict in arr) {
                if ([dept integerValue] == [dict[@"Id"] integerValue]) {
                //    self.department = dict[@"Name"];
                    completion(dict[@"Name"],nil);
                }
            }
        }
    }];
}
@end
