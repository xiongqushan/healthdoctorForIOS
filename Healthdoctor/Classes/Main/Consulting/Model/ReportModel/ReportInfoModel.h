//
//  ReportInfoModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/22.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface ReportInfoModel : HZBaseModel

@property (nonatomic, copy) NSString *abnormalCount;  //异常个数
@property (nonatomic, copy) NSString *age;  //年龄
@property (nonatomic, copy) NSString *checkUnitName; //体检机构名称
@property (nonatomic, copy) NSString *customerName;  //客户名
@property (nonatomic, copy) NSString *groupCheckUnitName;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *regDate;  //注册日期
@property (nonatomic, copy) NSString *reportDate;  //报告日期
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *showReportDate;  //显示报告的日期
@property (nonatomic, copy) NSString *workNo;  //体检号

@end
