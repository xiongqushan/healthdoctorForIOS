//
//  CheckItemModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface CheckItemModel : HZBaseModel

@property (nonatomic, copy)NSString *checkItemCode;
@property (nonatomic, copy)NSString *checkItemName;
@property (nonatomic, strong)NSArray *checkResults;
@property (nonatomic, copy)NSString *checkStateID;
@property (nonatomic, copy)NSString *checkUserName;
@property (nonatomic, copy)NSString *departmentName;
@property (nonatomic, copy)NSString *salePrice;

- (NSMutableArray *)parseValueWithArr:(NSArray *)arr;

@end
