//
//  GKNetwork.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKNetwork : NSObject

+ (instancetype)sharedInstance;
/*
- (void)GetUrl:(NSString *)url param:(NSDictionary *)param completionBlockSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)PostUrl:(NSString *)url param:(NSDictionary *)dict completionBlockSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
*/
- (void)GetUrl:(NSString *)url param:(NSDictionary *)param completionBlock:(void(^)(id responseObject, NSError *error))completion;
- (void)postUrl:(NSString *)url param:(NSDictionary *)param completionBlock:(void(^)(id responseObject, NSError *error))completion;

@end
