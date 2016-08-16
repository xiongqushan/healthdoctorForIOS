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

- (NSMutableArray *)getUnusualDataArr;
@end
