//
//  CustomInfoModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/7/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface CustomInfoModel : HZBaseModel

@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *career;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *certificateCode;
@property (nonatomic, copy)NSString *companyName;
@property (nonatomic, copy)NSString *contactName;
@property (nonatomic, copy)NSString *contactMobile;
@property (nonatomic, strong)NSArray *groupList;
@property (nonatomic, copy)NSString *age;
@property (nonatomic, copy)NSString *Id;

@end
