
//
//  PhraseHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PhraseHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "CommonLanguageModle.h"

@implementation PhraseHttpRequest

+ (void)requestPhraseData:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kDefaultExpressionsURL param:param completionBlock:^(id responseObject, NSError *error) {
        NSMutableArray *dataArr = [NSMutableArray array];
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
            NSArray *data = responseObject[@"Data"];
            for (NSDictionary *dict in data) {
                CommonLanguageModle *model = [[CommonLanguageModle alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.isClick = @"0";
                [dataArr addObject:model];
            }
            completion(dataArr,nil);
        }
    }];
}

+ (void)requestSearchData:(NSDictionary *)param completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    [[GKNetwork sharedInstance] GetUrl:kSearchExpressionsURL param:param completionBlock:^(id responseObject, NSError *error) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            if ([responseObject[@"state"] integerValue] != 1) {
                completion(nil, responseObject[@"message"]);
                return ;
            }
            
            for (NSDictionary *dict in responseObject[@"Data"]) {
                CommonLanguageModle *model = [[CommonLanguageModle alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.isClick = @"0";
                [dataArr addObject:model];
            }
            completion(dataArr, nil);
            
        }
    }];
}
@end
