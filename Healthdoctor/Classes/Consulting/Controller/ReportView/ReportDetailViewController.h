//
//  ReportDetailViewController.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//  体检报告

#import <UIKit/UIKit.h>

@interface ReportDetailViewController : UIViewController

//@property (nonatomic, strong)ReportModel *reportModel;
@property (nonatomic, copy)NSString *custId;  //客户ID
@property (nonatomic, copy)NSString *workNum;  //体检号
@property (nonatomic, copy)NSString *checkCode;  //体检机构编号

//@property (nonatomic, copy)NSString *cname;  //姓名
//@property (nonatomic, copy)NSString *gender;  //性别
//@property (nonatomic, copy)NSString *age;  //年龄
//@property (nonatomic, copy)NSString *medicalCenter;  //体检中心
//@property (nonatomic, copy)NSString *medicalDate;  //体检日期
//@property (nonatomic, copy)NSString *company;  //工作单位
@end
