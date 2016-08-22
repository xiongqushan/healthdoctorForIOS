//
//  GroupManager.m
//  Healthdoctor
//
//  Created by 熊伟 on 16/8/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupManager.h"

@implementation GroupManager

static NSMutableArray *_groupArray;

+(NSString*)getFilePath{
    NSString *homePath=NSHomeDirectory();
    NSString *srcPath=[homePath stringByAppendingPathComponent:@"/Documents/groups.archiver"];
    return srcPath;
}

+(void)setGroupArray:(NSMutableArray*)groupArray{
    NSString *path=[self getFilePath];
    BOOL success=[NSKeyedArchiver archiveRootObject:groupArray toFile:path];
    if (success) {
        _groupArray=groupArray;
    }
}

+(NSMutableArray*)getGroupArray{
    if (!_groupArray) {
        NSString *path=[self getFilePath];
        _groupArray=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return _groupArray;
}

+(HomeGroupModel*)getGroup:(NSInteger)groupId{
    NSArray* groupArray=[self getGroupArray];
    if (!groupArray) {
        return nil;
    }
    for (HomeGroupModel* groupModel in groupArray) {
        if(groupModel.Id == groupId){
            return groupModel;
        }
    }
    return nil;
}

@end
