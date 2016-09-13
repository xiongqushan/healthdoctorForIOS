//
//  HZUser.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZUser.h"

@implementation HZUser
/*
 @property (nonatomic, copy)NSString *account;
 @property (nonatomic, copy)NSString *dept;
 @property (nonatomic, copy)NSString *doctorId;
 @property (nonatomic, copy)NSString *expertise;
 @property (nonatomic, copy)NSString *introduce;
 @property (nonatomic, copy)NSString *lastLogOn;
 @property (nonatomic, copy)NSString *name;
 @property (nonatomic, copy)NSString *photoUrl;
 @property (nonatomic, copy)NSString *position;*/

/*    
 Account = XHTest01;
 Dept = 14;
 "Doctor_ID" = 1013;
 Expertise = "\U5185\U79d1\U4e3b\U6cbb\U533b\U5e08";
 Introduce = "\U672c\U4eba\U4ece\U4e8b\U4e34\U5e8a\U5de5\U4f5c\U591a\U5e74\U73b0\U4efb\U5065\U5eb7\U4f53\U68c0\U4e2d\U5fc3\U4e8c\U7ea7\U603b\U68c0\U533b\U5e08";
 "Last_Log_On" = "2016-08-22T17:32:17.2052289+08:00";
 Name = "\U674e\U5fd7\U519b";
 PhotoUrl = "http://resource.ihaozhuo.com/DoctorPhotos/xinhu/XH-lizhijun.jpg";
 Position = 1001;
 RoleFlag = 1;*/
+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{
             @"account":@"Account",
             @"dept":@"Dept",
             @"doctorId":@"Doctor_ID",
             @"expertise":@"Expertise",
             @"introduce":@"Introduce",
             @"lastLogOn":@"Last_Log_On",
             @"name":@"Name",
             @"photoUrl":@"PhotoUrl",
             @"position":@"Position",
             @"roleFlag":@"RoleFlag"
             };
}

@end
