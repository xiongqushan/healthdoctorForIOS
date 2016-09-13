//
//  CusInfoModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface CusInfoModel : HZBaseModel

//网络请求的数据
@property (nonatomic, copy)NSString *account_Id;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *cname;
@property (nonatomic, copy)NSString *company_Name;
@property (nonatomic, copy)NSString *email;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *photoUrl;
@property (nonatomic, copy)NSString *doctorID;

//pendingModel 里的数据
@property (nonatomic, copy)NSString *commitOn;

//feedBackModel 里的数据
@property (nonatomic, copy)NSString *reDoctor;
@property (nonatomic, assign)NSInteger reDoctorId;
@property (nonatomic, copy)NSString *score;
@property (nonatomic, copy)NSString *consultTitele;

@end
