//
//  ReportModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/23.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface ReportModel : HZBaseModel
@property (nonatomic, copy)NSString *checkDate;
@property (nonatomic, copy)NSString *checkUnitCode;
@property (nonatomic, copy)NSString *checkUnitName;
@property (nonatomic, copy)NSString *customerName;
@property (nonatomic, copy)NSString *workNo;

@end
