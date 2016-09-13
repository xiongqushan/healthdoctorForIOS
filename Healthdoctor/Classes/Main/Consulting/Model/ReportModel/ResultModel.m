//
//  ResultModel.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel

- (NSMutableArray *)parseDataWithArr:(NSArray *)arr {
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        ResultModel *model = [[ResultModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [dataArr addObject:model];
    }
    return dataArr;
}

@end
