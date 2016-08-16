//
//  HZUser.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface HZUser : HZBaseModel

//该属性是记录用户是否登录
@property (nonatomic, copy) NSString *isLogin;

/*******************扫码登录*********************/
//@property (nonatomic, assign) NSInteger certificateCode;
//@property (nonatomic, copy) NSString *createdBy;
//@property (nonatomic, copy) NSString *createdOn;
//@property (nonatomic, copy) NSString *guid;
//@property (nonatomic, assign) NSInteger Id;
//@property (nonatomic, copy) NSString *introduce;
//@property (nonatomic, copy) NSString *isDefault;
//@property (nonatomic, assign) NSInteger isDelete;
//@property (nonatomic, assign) NSInteger isUappSync;
//@property (nonatomic, assign) NSInteger jobState;
//@property (nonatomic, copy) NSString *level;
//@property (nonatomic, assign) NSInteger mobile;
//@property (nonatomic, copy) NSString *modifiedBy;
//@property (nonatomic, copy) NSString *modifiedOn;
//@property (nonatomic, assign) NSInteger pId;
//@property (nonatomic, copy) NSString *photoUrl;
//@property (nonatomic, assign) NSInteger positionCode;
//@property (nonatomic, copy) NSString *roleFlag;
//@property (nonatomic, assign) NSInteger serviceDeptId;
//@property (nonatomic, copy) NSString *serviceLimit;
//@property (nonatomic, assign) NSInteger speciality;
//@property (nonatomic, copy) NSString *spell;
//@property (nonatomic, copy) NSString *username;
//@property (nonatomic, assign) NSInteger version;

/**********************用户名密码登录***********************/
@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *dept;
@property (nonatomic, copy)NSString *doctorId;
@property (nonatomic, copy)NSString *expertise;
@property (nonatomic, copy)NSString *introduce;
@property (nonatomic, copy)NSString *lastLogOn;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *photoUrl;
@property (nonatomic, copy)NSString *position;

@end
