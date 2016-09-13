//
//  HomeDetailModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"
/*
 AccountId = "debc83c4-e7ba-4174-a40b-cc56b1540325";
 Birthday = "<null>";
 Cname = "\U5927\U773c\U775b";
 CompanyName = "<null>";
 CustId = 138;
 DoctorId = 1052;
 Gender = 1;
 GroupInfoId = 38;
 Mobile = 13601937920;
 NickName = "\U5927\U773c\U775b";
 ROWNUMBER = 1;
 ServiceDeptId = 4;
 ServiceDeptName = "\U674e\U56db";
 */
@interface HomeDetailModel : HZBaseModel

@property (nonatomic, copy)NSString *accountId;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *cname;
@property (nonatomic, copy)NSString *companyName;
@property (nonatomic, copy)NSString *custId;
@property (nonatomic, copy)NSString *doctorId;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *groupInfoId;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *serviceDeptId;
@property (nonatomic, copy)NSString *serviceDeptName;
@property (nonatomic, copy)NSString *photoUrl;

@end
