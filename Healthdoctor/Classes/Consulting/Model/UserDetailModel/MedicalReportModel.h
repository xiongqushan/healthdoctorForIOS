//
//  MedicalReportModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

/*
 CheckDate = 20160531075716;
 CheckUnitCode = bjbr002;
 CheckUnitName = "\U5b89\U5b81\U946b\U6e56\U533b\U9662";
 CustomerName = "\U674e\U82b8\U79c0";
 WorkNo = 0000073729;
 */

@interface MedicalReportModel : HZBaseModel

@property (nonatomic, copy) NSString *customerName; //姓名
@property (nonatomic, copy) NSString *gender; //性别
@property (nonatomic, copy) NSString *age;  //年龄
@property (nonatomic, copy) NSString *checkUnitName;  //体检中心
@property (nonatomic, copy) NSString *checkDate;  //体检日期
@property (nonatomic, copy) NSString *checkUnitCode;  //体检中心编号
@property (nonatomic, copy) NSString *company;  //工作单位
@property (nonatomic, copy) NSString *workNo;  //体检号

+ (instancetype)reportWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
