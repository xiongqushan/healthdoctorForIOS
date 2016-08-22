//
//  Config.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "Config.h"

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

@implementation Config

+ (void)saveProfile:(HZUser *)user {
    NSDictionary dictionary=[NSDictionary dictionaryWithObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>]
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    [userDefaults setObject:user.isLogin forKey:kIsLogin];
    
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
