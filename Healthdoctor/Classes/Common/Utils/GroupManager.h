//
//  GroupManager.h
//  Healthdoctor
//
//  Created by 熊伟 on 16/8/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeGroupModel.h"

@interface GroupManager : NSObject

+(void)setGroupArray:(NSArray*)groupArray;

+(NSArray*)getGroupArray;

+(HomeGroupModel*)getGroup:(NSInteger)groupId;
@end
