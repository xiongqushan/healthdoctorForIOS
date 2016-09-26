
//
//  CustomInfoHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/19.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CustomInfoHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUtils.h"

@implementation CustomInfoHttpRequest

+ (void)requestInfo:(NSDictionary *)param completionBlock:(void (^)(CustomInfoModel *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kGetCusInfoURL param:param completionBlock:^(id responseObject, NSError *error) {
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
            
            NSDictionary *dict = responseObject[@"Data"];
            CustomInfoModel *model = [[CustomInfoModel alloc] init];
            
            //根据数字获得性别
            model.gender = [HZUtils getGender:dict[@"Gender"]];
            
            model.career = dict[@"Career"];
            
            model.birthday = dict[@"Birthday"];
            model.age = [HZUtils getAgeWithBirthday:model.birthday];
            
            model.mobile = dict[@"Mobile"];
            model.certificateCode = dict[@"Certificate_Code"];
            model.companyName = dict[@"Company_Name"];
            model.contactName = dict[@"Contact_Name"];
            model.contactMobile = dict[@"Contact_Mobile"];
            model.Id = dict[@"Id"];
            model.groupList = dict[@"GroupIdList"];
            
            completion(model, nil);

        }
    }];
}

+ (void)deleteCustomGroup:(NSDictionary *)param completionBlock:(void (^)(NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kDeleteGroupURL param:param completionBlock:^(id responseObject, NSError *error) {
        if (error) {
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(@"删除分组失败");
            }else {
                completion(nil);
            }
        }
    }];
}
@end
