//
//  ReportPhotoModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"
#import <UIKit/UIKit.h>

@interface ReportPhotoModel : HZBaseModel

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *healthCompanyName;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray *imageUrlList;

@property (nonatomic, assign)CGFloat cellHeight;

@end
