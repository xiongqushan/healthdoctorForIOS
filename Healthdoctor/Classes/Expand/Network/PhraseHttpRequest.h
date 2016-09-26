//
//  PhraseHttpRequest.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhraseHttpRequest : NSObject

//请求常用短语数据
+ (void)requestPhraseData:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *dataArr, NSString *message))completion;

//搜索常用短语
+ (void)requestSearchData:(NSDictionary *)param completionBlock:(void(^)(NSMutableArray *dataArr, NSString *message))completion;

@end
