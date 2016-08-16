//
//  ResultModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface ResultModel : HZBaseModel

@property (nonatomic, copy)NSString *appendInfo;
@property (nonatomic, copy)NSString *canExplain;
@property (nonatomic, copy)NSString *checkIndexCode;
@property (nonatomic, copy)NSString *checkIndexName;
@property (nonatomic, copy)NSString *highValueRef;
@property (nonatomic, copy)NSString *isAbandon;
@property (nonatomic, copy)NSString *isCalc;
@property (nonatomic, copy)NSString *lowValueRef;
@property (nonatomic, copy)NSString *resultFlagID;
@property (nonatomic, copy)NSString *resultTypeID;
@property (nonatomic, copy)NSString *resultValue;
@property (nonatomic, copy)NSString *showIndex;
@property (nonatomic, copy)NSString *textRef;
@property (nonatomic, copy)NSString *unit;

- (NSMutableArray *)parseDataWithArr:(NSArray *)arr;

@end
