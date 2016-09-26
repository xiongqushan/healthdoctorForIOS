//
//  ConsulationHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConsulationHttpRequest.h"
#import "GKNetwork.h"
#import "HZBaseModel.h"

@implementation ConsulationHttpRequest

+ (void)requestNewData:(NSString *)url param:(NSDictionary *)param class:(Class)cls completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    
    [[GKNetwork sharedInstance] GetUrl:url param:param completionBlock:^(id responseObject, NSError *error) {
       
        NSMutableArray *dataArr = [NSMutableArray array];
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSString *message = dict[@"message"];
            if ([dict[@"state"] integerValue] != 1) { //不为1时请求数据失败
                completion(nil,message);
                return ;
            }
            
            NSDictionary *data = dict[@"Data"];
            NSInteger count = [data[@"Count"] integerValue];

            if(count == 0) {
                completion(nil,@"暂时没有客户");
                return;
            }
            NSArray *arr = data[@"Data"];

            for (NSDictionary *dic in arr) {
                HZBaseModel *model = [[cls alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];

            }
            
            completion(dataArr,nil);

        }
        
    }];
}

+ (void)requestMoreData:(NSString *)url param:(NSDictionary *)param class:(Class)cls completionBlock:(void (^)(NSMutableArray *, NSString *))completion {
    
    [[GKNetwork sharedInstance] GetUrl:url param:param completionBlock:^(id responseObject, NSError *error) {
      
        NSMutableArray *dataArr = [NSMutableArray array];
        if (error) {
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSString *message = dict[@"message"];
            if ([dict[@"state"] integerValue] != 1) { //不为1时请求数据失败
                completion(nil,message);
                return ;
            }
            
            NSDictionary *data = dict[@"Data"];
        
            NSArray *arr = data[@"Data"];
            
            for (NSDictionary *dic in arr) {
                HZBaseModel *model = [[cls alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [dataArr addObject:model];
            }
            completion(dataArr,nil);
        }
    }];
}
@end
