//
//  Config.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "Config.h"
#import <MJExtension.h>

NSString *const kUserInfoKey=@"UserInfoKey";

@implementation Config

static HZUser *_user ;

+ (void)saveProfile:(HZUser *)user {
    NSDictionary *dictionary=[user mj_keyValues];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dictionary forKey:kUserInfoKey];
    [userDefaults synchronize];
    _user=user;
}

+ (HZUser *)getProfile {
    if (_user) {
        return _user;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary=[userDefaults objectForKey:kUserInfoKey];
    _user=[HZUser mj_objectWithKeyValues:dictionary];
    return _user;
}

+ (void)clearProfile {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserInfoKey];
    [userDefaults synchronize];
    _user=NULL;
}

+ (BOOL)isLogin {
    if (_user==NULL) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary* dictionary= [userDefaults objectForKey:kUserInfoKey];
        if (dictionary!=nil) {
            _user=[HZUser mj_objectWithKeyValues:dictionary];
        }
    }
    return _user!=NULL;
}

@end
