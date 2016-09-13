//
//  PhotoCasesModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZBaseModel.h"

@interface PhotoCasesModel : HZBaseModel

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *healthCompanyName;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray *imageUrlList;

//@property (nonatomic, assign) CGFloat cellHeight;

@end
