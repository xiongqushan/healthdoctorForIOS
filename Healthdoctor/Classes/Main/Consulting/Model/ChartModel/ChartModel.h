//
//  ChartModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"
#import <UIKit/UIKit.h>
/*
 type:1  纯文本
 type:2  图片
 type:3  体检报告
 */

@interface ChartModel : HZBaseModel

@property (nonatomic, copy)NSString *appendInfo;
@property (nonatomic, copy)NSString *commitOn;
@property (nonatomic, copy)NSString *consultType;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *customerId;
@property (nonatomic, copy)NSString *deliverState;
@property (nonatomic, copy)NSString *Id;
@property (nonatomic, copy)NSString *isDoctorReply;
@property (nonatomic, copy)NSString *photoUrl;
@property (nonatomic, copy)NSString *reDoctorId;
@property (nonatomic, copy)NSString *strGuid;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
