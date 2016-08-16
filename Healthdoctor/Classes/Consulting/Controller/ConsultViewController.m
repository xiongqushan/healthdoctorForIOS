//
//  ConsultViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConsultViewController.h"
#import "GKSliderView.h"
#import "Define.h"
#import "ChartBaseViewController.h"
#import "FeedbackModel.h"
#import "UIView+Utils.h"
#import "UIColor+Utils.h"
#import "ConsulationView.h"
#import "HZAPI.h"
#import "UIView+Utils.h"

@interface ConsultViewController ()
@property (nonatomic, strong) UISegmentedControl *segment;
@end

@implementation ConsultViewController
{
    GKSliderView *_slider;
    ConsulationView *_pendingView; //待处理
    ConsulationView *_processedView;  //已处理
    ConsulationView *_feedbackView;   //问题反馈
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建分段选择控制器
    [self setUpSegmentView];
    
    //创建进行筛选的滑动视图
    [self setUpBaseUI];
    
    //添加观察者监听tableViewCell被点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellSelected:) name:kCellSelectedNotification object:nil];
}

//当tabeViewCell被点击时调用的方法
- (void)cellSelected:(NSNotification *)note {

    NSIndexPath *indexPath = note.userInfo[@"indexPath"];
    NSMutableArray *dataArr = note.userInfo[@"dataArr"];
    
    ChartBaseViewController *chart = [[ChartBaseViewController alloc] init];
    chart.model = dataArr[indexPath.row];
    [self.navigationController pushViewController:chart animated:YES];
}

- (void)setUpSegmentView {

    NSArray *arr = @[@"待处理",@"已处理",@"问题反馈"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    segment.frame = CGRectMake(0, 0, kScreenSizeWidth - 80, 35);
    segment.selectedSegmentIndex = 0;
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateSelected];
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    self.segment = segment;

}

// 创建3个ConsulationView 分别为待处理 已处理 问题反馈
- (void)setUpBaseUI {
    
    NSArray *pendingArr = @[@"全部",@"转入",@"我的"];
    ConsulationView *pendingView = [[ConsulationView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 48) titleArr:pendingArr url:kGetPendingURL];
    
    pendingView.badgeBlock = ^(NSInteger count) {
        [self.segment setBadgeValue:count];
    };
    
    [self.view addSubview:pendingView];
    _pendingView = pendingView;
    
    NSArray *processedArr = @[@"当天",@"最近七天",@"本月"];
    ConsulationView *processedView = [[ConsulationView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 48) titleArr:processedArr url:kGetProcessedURL];
    _processedView = processedView;
    
    NSArray *feedbackArr = @[@"全部",@"已反馈",@"未反馈"];
    ConsulationView *feedbackView = [[ConsulationView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 48) titleArr:feedbackArr url:kGetFeedbackURL];
    _feedbackView = feedbackView;
    
}

- (void)segmentClick:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == 0) {
        //待处理
        NSLog(@"——————————待处理");
        [self.view addSubview:_pendingView];
        [_processedView removeFromSuperview];
        [_feedbackView removeFromSuperview];
    }else if (segment.selectedSegmentIndex == 1) {
        //已处理
        NSLog(@"——————————已处理");
        [self.view addSubview:_processedView];
        [_pendingView removeFromSuperview];
        [_feedbackView removeFromSuperview];
        
    }else if (segment.selectedSegmentIndex == 2) {
        //问题反馈
        NSLog(@"——————————问题反馈");
        [self.view addSubview:_feedbackView];
        [_pendingView removeFromSuperview];
        [_processedView removeFromSuperview];
    }
}

- (void)dealloc {
    NSLog(@"_____dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end