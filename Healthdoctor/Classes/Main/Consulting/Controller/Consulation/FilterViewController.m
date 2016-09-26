//
//  FilterViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "FilterViewController.h"
#import "PendingCell.h"
#import "FeedBackCell.h"
#import <MJRefresh.h>
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUser.h"
#import "Config.h"
#import "HZUtils.h"
#import "PendingModel.h"
#import "FeedbackModel.h"
#import "UIColor+Utils.h"
#import "AudionPlayer.h"
#import "ConsulationHttpRequest.h"
#import <MBProgressHUD.h>

#define kTableViewH kScreenSizeHeight - 64 - 48 - 40
@interface FilterViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation FilterViewController
{
    NSInteger _index;
    Class _cls;
    BOOL _isFlag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSMutableArray array];
    
    //根据传入的url判断数据模型
    if ([self.url isEqualToString:kGetPendingURL]) {
        _cls = [PendingModel class];
    }else {
        _cls = [FeedbackModel class];
    }
    
    _index = 1;
    //创建tableView
    [self setUpTableView];
 
    _isFlag = YES;
    if ([self.url isEqualToString:kGetPendingURL] && ([self.flag integerValue] == 3 || [self.flag integerValue] == 2 || [self.flag integerValue] == 1)) {//只有在待处理 全部界面 注册通知
        //回复完消息回到该界面时重新请求数据
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeListNoti:) name:@"ChangeListNotifi" object:nil];
    }

}

- (void)changeListNoti:(NSNotification *)noti {
    
    _isFlag = NO;
    [self loadNewData];
}

- (void)setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kTableViewH) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor viewBackgroundColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    [tableView registerNib:[UINib nibWithNibName:@"PendingCell" bundle:nil] forCellReuseIdentifier:@"PendingCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FeedBackCell" bundle:nil] forCellReuseIdentifier:@"FeedBackCell"];
    self.tableView = tableView;
    
    //创建下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    //创建上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        
    }];
    
}

- (void)loadMoreData {
   // MBProgressHUD *hud = [HZUtils createHUD];
    
    _index++;
    NSDictionary *param = [self getParamWithFlag:self.flag];
    [ConsulationHttpRequest requestMoreData:self.url param:param class:_cls completionBlock:^(NSMutableArray *arr, NSString *message) {
     //   [hud hideAnimated:YES];
        
        if (arr.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        if (message) {
            [HZUtils showHUDWithTitle:message];
        }else {
            [[AudionPlayer shareAudioPlayer] play];
            
            [self.dataArr addObjectsFromArray:arr];
            [self.tableView reloadData];
        }
    }];
}

- (void)loadNewData {
    
    MBProgressHUD *hud = [HZUtils createHUD];
    //下拉刷新
    _index = 1;
    NSDictionary *param = [self getParamWithFlag:self.flag];
    [ConsulationHttpRequest requestNewData:self.url param:param class:_cls completionBlock:^(NSMutableArray *arr, NSString *message) {
        
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing]; //停止刷新
        //根据数组个数判断数据是否全部加载
        if (arr.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        if (message) {
            if (_isFlag) {
                [HZUtils showHUDWithTitle:message];
            }

        }
        
        [[AudionPlayer shareAudioPlayer] play];
        
        if (self.badgeBlock) {
            self.badgeBlock(arr.count);
        }
        self.dataArr = arr;
        [self.tableView reloadData];
        _isFlag = YES;
    }];
}

- (NSDictionary *)getParamWithFlag:(NSString *)flag {
    
    HZUser *user = [Config getProfile];
    if ([self.url isEqualToString:kGetProcessedURL]) {
        //已处理
        NSDictionary *param = @{@"doctorId":user.doctorId,@"beginCommitOn":self.starDate,@"endCommitOn":self.endDate,@"pageIndex":@(_index),@"pageSize":@(10)};
        return param;
    }
    //待处理  问题反馈
    NSDictionary *param = @{@"doctorId":user.doctorId,@"pageIndex":@(_index),@"pageSize":@(10),@"flag":flag};
    return param;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.url isEqualToString:kGetPendingURL]) {
        //待处理
        PendingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendingCell"];
        [cell showDataWithModel:self.dataArr[indexPath.row]];
        return cell;
    }else {
        //已处理  问题反馈
        FeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedBackCell"];
        [cell showDataWithModel:self.dataArr[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *flag = @"0";
    if ([self.url isEqualToString:kGetFeedbackURL]) {
        flag = @"1";
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCellSelectedNotification object:self userInfo:@{@"indexPath":indexPath,@"dataArr":self.dataArr,@"isFeedback":flag}];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
