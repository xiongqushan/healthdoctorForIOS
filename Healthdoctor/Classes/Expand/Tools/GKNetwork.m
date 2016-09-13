//
//  GKNetwork.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "GKNetwork.h"
#import <AFNetworking.h>
#import "Base64.h"
#import "MD5.h"
#import "HZAPI.h"
#import <MBProgressHUD.h>
#import "HZUtils.h"

#define kAppSecret @"1!2@3#4$5%6^"

@implementation GKNetwork
{
    AFURLSessionManager *_manager;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    
    return self;
}

//获取请求的URL
- (NSString *)getRequestUrl:(NSString *)url {
    url = [kUrlPrefix stringByAppendingString:url];
    //URL拼接时间戳
    int timeStamp = [[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%@?timespan=%d",url,timeStamp];
}

//get 请求
- (void)GetUrl:(NSString *)url param:(NSDictionary *)param completionBlockSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    MBProgressHUD *hud = [HZUtils createHUD];
    NSString *requestUrl = [self getRequestUrl:url];
    if (param) { //在这个地方拼接参数到URL，使请求的url和参与加密的url参数顺序一致
        NSArray *keyArr = param.allKeys;
        NSArray *valueArr = param.allValues;
        for (NSInteger i = 0; i < keyArr.count; i++) {
            NSString *paramStr = [NSString stringWithFormat:@"%@=%@",keyArr[i],valueArr[i]];
            requestUrl = [requestUrl stringByAppendingString:[NSString stringWithFormat:@"&%@",paramStr]];
        }
    }
    
    NSString *basicStr = [self getHttpHeaderStrWithUrl:requestUrl];
    
    //Basic认证 base64进行加密
    NSString *newBasicStr = [NSString stringWithFormat:@"Basic %@",[basicStr base64EncodedString]];
    
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //请求URL（带时间戳）
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:requestUrl parameters:nil error:nil];
    //将认证信息添加到请求头
    [request setValue:newBasicStr forHTTPHeaderField:@"Authorization"];
    
    //AFN请求数据
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {

        [hud hideAnimated:YES];
        
        if (error) {
            //请求失败回调
            failure(error);
        } else {
            //请求成功回调
            success(responseObject);
            
        }
    }];
    [dataTask resume];

}

//get请求时basic 签名获取方式
- (NSString *)getHttpHeaderStrWithUrl:(NSString *)url {
    
    NSString *preSign = [NSString stringWithFormat:@"%@|%@",url,kAppSecret];
    
    NSString *sign = [MD5 md532BitLower:preSign];
    NSString *basicString = [NSString stringWithFormat:@"HZ_API_V2:%@",sign];
    return basicString;
    
}

//post 请求
- (void)PostUrl:(NSString *)url param:(NSDictionary *)dict completionBlockSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
   
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//
//    });
    
    MBProgressHUD *hud = [HZUtils createHUD];
    
    NSString *requestUrl = [self getRequestUrl:url];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:dict error:nil];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *basicStr = [self postHttpHeaderStrWithUrl:requestUrl param:jsonStr];
    //Basic认证 base64进行加密
    NSString *newBasicStr = [NSString stringWithFormat:@"Basic %@",[basicStr base64EncodedString]];
    //将认证信息添加到请求头
    [request setValue:newBasicStr forHTTPHeaderField:@"Authorization"];
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
        
        [hud hideAnimated:YES];
        
        if (error) {
            //请求失败回调
            failure(error);
            
        } else {
            //请求成功回调
            success(responseObject);
            
        }
    }];
    
    [dataTask resume];

}

//post请求时basic 签名获取方式
- (NSString *)postHttpHeaderStrWithUrl:(NSString *)url param:(NSString *)jsonStr {

    NSString *preSign = [NSString stringWithFormat:@"%@|%@|%@",url,jsonStr,kAppSecret];
    NSString *sign = [MD5 md532BitLower:preSign];
    NSString *basicString = [NSString stringWithFormat:@"HZ_API_V2:%@",sign];
    return basicString;
}


@end
