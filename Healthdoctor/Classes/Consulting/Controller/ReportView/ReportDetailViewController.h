//
//  ReportDetailViewController.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//  体检报告

#import <UIKit/UIKit.h>
#import "ReportModel.h"

@interface ReportDetailViewController : UIViewController

//@property (nonatomic, strong)ReportModel *reportModel;
@property (nonatomic, copy)NSString *custId;
@property (nonatomic, copy)NSString *workNum;
@property (nonatomic, copy)NSString *checkCode;

@end
