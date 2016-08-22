//
//  DepartmentModel.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "DepartmentModel.h"
#import "CheckItemModel.h"
#import "ResultModel.h"

@implementation DepartmentModel
{
    NSDictionary *_dict;
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        self.departmentName = dict[@"DepartmentName"];
        CheckItemModel *model = [[CheckItemModel alloc] init];
        self.checkItmes = [model parseValueWithArr:dict[@"CheckItems"]];
    }
    
    return self;
}

- (NSMutableArray *)getUnusualDataArr {
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSArray *arr = _dict[@"CheckItems"];
    for (NSDictionary *checkItem in arr) {
        for (NSDictionary *checkResult in checkItem[@"CheckResults"]) {
            ResultModel *model = [[ResultModel alloc] init];
            [model setValuesForKeysWithDictionary:checkResult];
//            if ([model.resultFlagID integerValue] != 1 || [model.resultFlagID integerValue] != 0) {
//                
//            }
            NSInteger flagID = [model.resultFlagID integerValue];
            if (flagID == 0 || flagID == 1) {
                
            }else {
                [dataArr addObject:model];
            }
        }
    }
    
    return dataArr;
}
@end
