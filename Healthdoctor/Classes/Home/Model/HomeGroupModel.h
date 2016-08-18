//
//  HomeGroupModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/7.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface HomeGroupModel : HZBaseModel<NSCoding>

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *doctorNum;
@property (nonatomic, copy)NSString *groupNum;
@property (nonatomic, assign)NSInteger Id;
@property (nonatomic, copy)NSString *type;

@end
