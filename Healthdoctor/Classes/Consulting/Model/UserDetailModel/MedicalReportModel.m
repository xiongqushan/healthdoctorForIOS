//
//  MedicalReportModel.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "MedicalReportModel.h"

@implementation MedicalReportModel

+ (instancetype)reportWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
