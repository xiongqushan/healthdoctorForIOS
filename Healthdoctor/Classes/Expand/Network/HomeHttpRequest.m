//
//  HomeHttpRequest.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeHttpRequest.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "GroupManager.h"

@implementation HomeHttpRequest

+ (void)requestHomeData:(NSDictionary *)param completionBlock:(void (^)(NSArray *dataArr, NSString *message))completion {
    
    [[GKNetwork sharedInstance] GetUrl:kGetCusGroupURL param:param completionBlock:^(id responseObject, NSError *error) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
//        NSArray *sortArr = [NSArray array];
        
        if (error) {
            //失败
            NSDictionary *userInfo = [error userInfo];
            NSString *message = userInfo[@"NSLocalizedDescription"];
            completion(nil,message);
        }else {
            //成功 解析数据
            NSString *message = responseObject[@"message"];
            if ([responseObject[@"state"] integerValue] == 1) {
                
                NSArray * Data = responseObject[@"Data"];
                for (NSDictionary *dict in Data) {
                    HomeGroupModel *model = [[HomeGroupModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    if ([model.name containsString:@"Test_"]) {
                        continue;
                    }else {
                        [dataArr addObject:model];
                    }
                }
                
                [GroupManager setGroupArray:dataArr];
                
                //对数组进行排序
                NSArray *sortArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    HomeGroupModel *pModel1 = obj1;
                    HomeGroupModel *pModel2 = obj2;
                    
                    if ([pModel1.doctorNum integerValue] < [pModel2.doctorNum integerValue]) {
                        return NSOrderedDescending; //降序
                    }else if ([pModel1.doctorNum integerValue] > [pModel2.doctorNum integerValue]) {
                        return NSOrderedAscending; //升序
                    }else {
                        return NSOrderedSame; //相等
                    }
                }];
                
                completion(sortArr,nil);
            }else {
                completion(nil,message);
            }
        }
        
    }];
}

@end
