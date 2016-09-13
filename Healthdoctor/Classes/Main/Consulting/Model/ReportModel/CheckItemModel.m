//
//  CheckItemModel.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CheckItemModel.h"
//#import "CheckResultsModel.m"
#import "ResultModel.h"
@implementation CheckItemModel

- (NSMutableArray *)parseValueWithArr:(NSArray *)arr {
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        
        CheckItemModel *model = [[CheckItemModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        ResultModel *resultModel = [[ResultModel alloc] init];
        model.checkResults = [resultModel parseDataWithArr:dict[@"CheckResults"]];
        [dataArr addObject:model];
        
    }
    
    return dataArr;
}
@end
