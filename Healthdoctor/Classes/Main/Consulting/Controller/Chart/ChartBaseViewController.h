//
//  ChartBaseViewController.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/27.
//  Copyright © 2016年 guokai. All rights reserved.
//  咨询问题界面父类

#import <UIKit/UIKit.h>
#import "ConsulationModel.h"

@interface ChartBaseViewController : UIViewController

//@property (nonatomic, strong)ConsulationModel *model;

@property (nonatomic, copy) NSString *customId;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, copy) NSString *customName;

@property (nonatomic, strong)UIView *userInfoView;

- (void)setUpNavTitleViewWithTitle:(NSString *)title;

@end
