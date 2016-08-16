//
//  FeedbackModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConsulationModel.h"

@interface FeedbackModel : ConsulationModel

@property (nonatomic, copy)NSString *reDoctor;
@property (nonatomic, assign)NSInteger reDoctorId;
@property (nonatomic, copy)NSString *score;

@end
