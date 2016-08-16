//
//  Config.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZUser.h"

// 对NSUserDefaults 的封装 保存数据
@interface Config : NSObject

+ (void)saveProfile:(HZUser *)user;
+ (HZUser *)getProfile;

+ (void)clearProfile;
+ (BOOL)isLogin;

@end
