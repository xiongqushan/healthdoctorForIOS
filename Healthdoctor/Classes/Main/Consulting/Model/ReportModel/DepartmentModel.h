//
//  DepartmentModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface DepartmentModel : HZBaseModel

@property (nonatomic, strong)NSMutableArray *checkItmes;
@property (nonatomic, copy)NSString *departmentName;

- (instancetype)initWithDict:(NSDictionary *)dict;

//获取异常项数据，现在接口返回的数据有这些数据了，就不用自己解析了
- (NSMutableArray *)getUnusualDataArr;
@end
