//
//  TestViewController.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

@interface TestViewController : UIViewController

//@property (nonatomic, strong)CusInfoModel *model;
//@property (nonatomic, strong)ConsulationModel *consulaModel;
@property (nonatomic, copy)NSString *cname;
@property (nonatomic, copy)NSString *photoUrl;
@property (nonatomic, copy)NSString *custID;
@property (nonatomic, copy)NSString *accountID;

@property (nonatomic, strong)NSMutableArray *chartDataArr;

@end
