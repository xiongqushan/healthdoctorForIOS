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

#define kTableViewH kScreenSizeHeight - 64 - 48 - 40
@interface FilterViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation FilterViewController
{
    NSInteger _index;
    Class _cls;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSMutableArray array];
    
    if ([self.url isEqualToString:kGetPendingURL]) {
        _cls = [PendingModel class];
    }else {
        _cls = [FeedbackModel class];
    }
    
    _index = 1;
    [self setUpTableView];
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
        _index ++;
        [self loadData];
        
    }];
    
}

- (void)loadNewData {
    //下拉刷新
    _index = 1;
    [self loadData];
}

//
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

- (void)loadData {
    NSDictionary *param = [self getParamWithFlag:self.flag];
    
    [[GKNetwork sharedInstance] GetUrl:self.url param:param completionBlockSuccess:^(id responseObject) {
        if (_index == 1) {
            [self.dataArr removeAllObjects];
        }
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        if ([dict[@"state"] integerValue] != 1) { //不为1时请求数据失败
            [HZUtils showHUDWithTitle:@"服务器出错"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        NSDictionary *data = dict[@"Data"];
        NSInteger count = [data[@"Count"] integerValue];
        if(count == 0) {
            [HZUtils showHUDWithTitle:@"暂时没有客户"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.dataArr removeAllObjects];
            [self.tableView reloadData];
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        if (self.badgeBlock) {// 刷新之后调用block更改badgeValue
            self.badgeBlock(count);
        }
        NSArray *arr = data[@"Data"];
        if (!arr.count) { // 请求不来数据 提示
            [HZUtils showHUDWithTitle:@"客户已全部加载"];
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        for (NSDictionary *dic in arr) {
            HZBaseModel *model = [[_cls alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
            
            if ([model isKindOfClass:[FeedbackModel class]]) {
                FeedbackModel *backModel = (FeedbackModel *)model;
                NSLog(@"_____socre:%@",backModel.score);
            }
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        //判断数据个数，如果不够上拉加载更多，隐藏上拉加载视图
        if (self.dataArr.count < 10) {
            self.tableView.mj_footer.hidden = YES;
        }else {
            self.tableView.mj_footer.hidden = NO;
        }
    } failure:^(NSError *error) {
        [HZUtils showHUDWithTitle:@"服务器连接失败"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
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
//    if ([self.url isEqualToString:kGetPendingURL]) {
//        return 70;
//    }else {
//        return 80;
//    }
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCellSelectedNotification object:self userInfo:@{@"indexPath":indexPath,@"dataArr":self.dataArr}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
