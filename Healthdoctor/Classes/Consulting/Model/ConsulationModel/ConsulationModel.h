//
//  ConsulationModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface ConsulationModel : HZBaseModel

@property (nonatomic, copy)NSString *commitOn;
@property (nonatomic, copy)NSString *consultTitele;
@property (nonatomic, assign)NSInteger custId;
@property (nonatomic, copy)NSString *custName;
@property (nonatomic, assign)NSInteger healthConsultId;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *photoUrl;

@end
