//
//  Config.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "Config.h"

//NSString * const kCertificateCode = @"certificateCode";
//NSString * const kCreatedBy = @"createdBy";
//NSString * const kCreatedOn = @"createdOn";
//NSString * const kGuid = @"guid";
//NSString * const kId = @"Id";
//NSString * const kIntroduce = @"introduce";
//NSString * const kIsDefault = @"isDefault";
//NSString * const kIsDelete = @"isDelete";
//NSString * const kIsUappSync = @"isUappSync";
//NSString * const kJobState = @"jobState";
//NSString * const kLevel = @"level";
//NSString * const kMobile = @"mobile";
//NSString * const kModifiedBy = @"modifiedBy";
//NSString * const kModifiedOn = @"modifiedOn";
//NSString * const kPId = @"pId";
//NSString * const kPhotoUrl = @"photoUrl";
//NSString * const kPositionCode = @"positionCode";
//NSString * const kRoleFlag = @"roleFlag";
//NSString * const kServiceDeptId = @"serviceDeptId";
//NSString * const kServiceLimit = @"serviceLimit";
//NSString * const kSpeciality = @"speciality";
//NSString * const kSpell = @"spell";
//NSString * const kUsername = @"username";
//NSString * const kVersion = @"version";

NSString *const kIsLogin = @"isLogin";
NSString *const kAccount = @"account";
NSString *const kDept = @"dept";
NSString *const kDoctorId = @"doctorID";
NSString *const kExpertise = @"expertise";
NSString *const kIntroduce = @"introduce";
NSString *const kLastLogin = @"lastLogin";
NSString *const kName = @"name";
NSString *const kPhotoUrl = @"photoUrl";
NSString *const kPosition = @"position";
/*
 @property (nonatomic, assign) NSInteger certificateCode;
 @property (nonatomic, copy) NSString *createdBy;
 @property (nonatomic, copy) NSString *createdOn;
 @property (nonatomic, copy) NSString *guid;
 @property (nonatomic, assign) NSInteger Id;
 @property (nonatomic, assign) NSInteger introduce;
 @property (nonatomic, copy) NSString *isDefault;
 @property (nonatomic, assign) NSInteger isDelete;
 @property (nonatomic, assign) NSInteger isUappSync;
 @property (nonatomic, assign) NSInteger jobState;
 @property (nonatomic, copy) NSString *level;
 @property (nonatomic, assign) NSInteger mobile;
 @property (nonatomic, copy) NSString *modifiedBy;
 @property (nonatomic, copy) NSString *modifiedOn;
 @property (nonatomic, assign) NSInteger pId;
 @property (nonatomic, copy) NSString *photoUrl;
 @property (nonatomic, assign) NSInteger positionCode;
 @property (nonatomic, assign) NSInteger roleFlag;
 @property (nonatomic, assign) NSInteger serviceDeptId;
 @property (nonatomic, copy) NSString *serviceLimit;
 @property (nonatomic, assign) NSInteger speciality;
 @property (nonatomic, copy) NSString *spell;
 @property (nonatomic, copy) NSString *username;
 @property (nonatomic, assign) NSInteger version;
 */
@implementation Config

+ (void)saveProfile:(HZUser *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:user.isLogin forKey:kIsLogin];
    
//    [userDefaults setInteger:user.certificateCode forKey:kCertificateCode];
//    [userDefaults setObject:user.createdBy forKey:kCreatedBy];
//    [userDefaults setObject:user.createdOn forKey:kCreatedOn];
//    [userDefaults setObject:user.guid forKey:kGuid];
//    [userDefaults setInteger:user.Id forKey:kId];
////    [userDefaults setInteger:user.introduce forKey:kIntroduce];
//    [userDefaults setObject:user.introduce forKey:kIntroduce];
//    [userDefaults setObject:user.isDefault forKey:kIsDefault];
//    [userDefaults setInteger:user.isDelete forKey:kIsDelete];
//    [userDefaults setInteger:user.isUappSync forKey:kIsUappSync];
//    [userDefaults setInteger:user.jobState forKey:kJobState];
//    [userDefaults setObject:user.level forKey:kLevel];
//    [userDefaults setInteger:user.mobile forKey:kMobile];
//    [userDefaults setObject:user.modifiedBy forKey:kModifiedBy];
//    [userDefaults setObject:user.modifiedOn forKey:kModifiedOn];
//    [userDefaults setInteger:user.pId forKey:kPId];
//    [userDefaults setObject:user.photoUrl forKey:kPhotoUrl];
//    [userDefaults setInteger:user.positionCode forKey:kPositionCode];
//   // [userDefaults setInteger:user.roleFlag forKey:kRoleFlag];
//    [userDefaults setObject:user.roleFlag forKey:kRoleFlag];
//    [userDefaults setInteger:user.serviceDeptId forKey:kServiceDeptId];
//    [userDefaults setObject:user.serviceLimit forKey:kServiceLimit];
//    [userDefaults setInteger:user.speciality forKey:kSpeciality];
//    [userDefaults setObject:user.spell forKey:kSpell];
//    [userDefaults setObject:user.username forKey:kUsername];
//    [userDefaults setInteger:user.version forKey:kVersion];
    
    [userDefaults setObject:user.account forKey:kAccount];
    [userDefaults setObject:user.dept forKey:kDept];
    [userDefaults setObject:user.doctorId forKey:kDoctorId];
    [userDefaults setObject:user.expertise forKey:kExpertise];
    [userDefaults setObject:user.introduce forKey:kIntroduce];
    [userDefaults setObject:user.lastLogOn forKey:kLastLogin];
    [userDefaults setObject:user.name forKey:kName];
    [userDefaults setObject:user.photoUrl forKey:kPhotoUrl];
    [userDefaults setObject:user.position forKey:kPosition];
    
    [userDefaults synchronize];
}

+ (HZUser *)getProfile {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    HZUser *user = [[HZUser alloc] init];
    if ([self isLogin]) {
//        user.certificateCode = [userDefaults integerForKey:kCertificateCode];
//        user.createdBy = [userDefaults objectForKey:kCreatedBy];
//        user.createdOn = [userDefaults objectForKey:kCreatedOn];
//        user.guid = [userDefaults objectForKey:kGuid];
//        user.Id = [userDefaults integerForKey:kId];
//        user.introduce = [userDefaults objectForKey:kIntroduce];
//        user.isDefault = [userDefaults objectForKey:kIsDefault];
//        user.isDelete = [userDefaults integerForKey:kIsDelete];
//        user.isUappSync = [userDefaults integerForKey:kIsUappSync];
//        user.jobState = [userDefaults integerForKey:kJobState];
//        user.level = [userDefaults objectForKey:kLevel];
//        user.mobile = [userDefaults integerForKey:kMobile];
//        user.modifiedBy = [userDefaults objectForKey:kModifiedBy];
//        user.modifiedOn = [userDefaults objectForKey:kModifiedOn];
//        user.pId = [userDefaults integerForKey:kPId];
//        user.photoUrl = [userDefaults objectForKey:kPhotoUrl];
//        user.positionCode = [userDefaults integerForKey:kPositionCode];
//      //  user.roleFlag = [userDefaults integerForKey:kRoleFlag];
//        user.roleFlag = [userDefaults objectForKey:kRoleFlag];
//        user.serviceDeptId = [userDefaults integerForKey:kServiceDeptId];
//        user.serviceLimit = [userDefaults objectForKey:kServiceLimit];
//        user.speciality = [userDefaults integerForKey:kSpeciality];
//        user.spell = [userDefaults objectForKey:kSpell];
//        user.username = [userDefaults objectForKey:kUsername];
//        user.version = [userDefaults integerForKey:kVersion];
        user.account = [userDefaults objectForKey:kAccount];
        user.dept = [userDefaults objectForKey:kDept];
        user.doctorId = [userDefaults objectForKey:kDoctorId];
        user.expertise = [userDefaults objectForKey:kExpertise];
        user.introduce = [userDefaults objectForKey:kIntroduce];
        user.lastLogOn = [userDefaults objectForKey:kLastLogin];
        user.name = [userDefaults objectForKey:kName];
        user.photoUrl = [userDefaults objectForKey:kPhotoUrl];
        user.position = [userDefaults objectForKey:kPosition];
    }
    return user;
}

+ (void)clearProfile {
 
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"0" forKey:kIsLogin];
    
//    [userDefaults setObject:@(0) forKey:kCertificateCode];
//    [userDefaults setObject:@(0) forKey:kCreatedBy];
//    [userDefaults setObject:@(0) forKey:kCreatedOn];
//    [userDefaults setObject:@(0) forKey:kGuid];
//    [userDefaults setObject:@(0) forKey:kId];
//    [userDefaults setObject:@(0) forKey:kIntroduce];
//    [userDefaults setObject:@(0) forKey:kIsDefault];
//    [userDefaults setObject:@(0) forKey:kIsDelete];
//    [userDefaults setObject:@(0) forKey:kIsUappSync];
//    [userDefaults setObject:@(0) forKey:kJobState];
//    [userDefaults setObject:@(0) forKey:kLevel];
//    [userDefaults setObject:@(0) forKey:kMobile];
//    [userDefaults setObject:@(0) forKey:kModifiedBy];
//    [userDefaults setObject:@(0) forKey:kModifiedOn];
//    [userDefaults setObject:@(0) forKey:kPId];
//    [userDefaults setObject:@(0) forKey:kPhotoUrl];
//    [userDefaults setObject:@(0) forKey:kPositionCode];
//    [userDefaults setObject:@(0) forKey:kRoleFlag];
//    [userDefaults setObject:@(0) forKey:kServiceDeptId];
//    [userDefaults setObject:@(0) forKey:kServiceLimit];
//    [userDefaults setObject:@(0) forKey:kSpeciality];
//    [userDefaults setObject:@(0) forKey:kSpell];
//    [userDefaults setObject:@(0) forKey:kUsername];
//    [userDefaults setObject:@(0) forKey:kVersion];
    
    [userDefaults setObject:@(0) forKey:kAccount];
    [userDefaults setObject:@(0) forKey:kDept];
    [userDefaults setObject:@(0) forKey:kDoctorId];
    [userDefaults setObject:@(0) forKey:kExpertise];
    [userDefaults setObject:@(0) forKey:kIntroduce];
    [userDefaults setObject:@(0) forKey:kLastLogin];
    [userDefaults setObject:@(0) forKey:kName];
    [userDefaults setObject:@(0) forKey:kPhotoUrl];
    [userDefaults setObject:@(0) forKey:kPosition];
    
    [userDefaults synchronize];
}

+ (BOOL)isLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *isLogin = [userDefaults objectForKey:kIsLogin];
    
    if ([isLogin isEqualToString:@"1"]) {
        return YES;
    }else {
        return NO;
    }
}

@end
