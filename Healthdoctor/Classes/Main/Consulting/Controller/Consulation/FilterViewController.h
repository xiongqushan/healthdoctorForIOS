//
//  FilterViewController.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

typedef void(^GetBadgeValueBlock)(NSInteger value);

@interface FilterViewController : UIViewController

@property (nonatomic, copy) GetBadgeValueBlock badgeBlock;

//type  对应 待处理  已处理  问题反馈
@property (nonatomic, copy) NSString *url;
//flag  3-->全部  2-->我的  3-->转入
@property (nonatomic, copy) NSString *flag;

//开始日期  这两个参数是当是已处理界面时有用
@property (nonatomic, copy) NSString *starDate;
//结束日期
@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
