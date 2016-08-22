//
//  HomeGroupModel.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/7.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeGroupModel.h"

@implementation HomeGroupModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.doctorNum forKey:@"doctorNum"];
    [aCoder encodeObject:self.groupNum forKey:@"groupNum"];
    [aCoder encodeInteger:self.Id forKey:@"Id"];
    [aCoder encodeObject:self.type forKey:@"type"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.doctorNum=[aDecoder decodeObjectForKey:@"doctorNum"];
        self.groupNum=[aDecoder decodeObjectForKey:@"groupNum"];
        self.Id=[aDecoder decodeInt32ForKey:@"Id"];
        self.type=[aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}

@end
