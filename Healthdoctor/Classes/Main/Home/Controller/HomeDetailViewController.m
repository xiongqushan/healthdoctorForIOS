//
//  HomeDetailViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HZAPI.h"
#import "GKNetwork.h"
#import "HZUser.h"
#import "HZUtils.h"
#import "Config.h"
#import "HomeDetailModel.h"
#import "Define.h"
#import "HomeDetailCell.h"
#import <MJRefresh.h>
//#import "UserViewController.h"
#import "SearchViewController.h"
#import "UserDetailViewController.h"
#import "AudionPlayer.h"
#import "GroupListHttpRequest.h"

@interface HomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation HomeDetailViewController
{
    NSInteger _index;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_discover"] style:UIBarButtonItemStylePlain target:self action:@selector(search:)];

    self.dataArr = [NSMutableArray array];
    self.title = self.model.name;
    [self setUpTableView];
}

- (void)setUpRightSearchBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:@"tabbar_discover"] forState:UIControlStateNormal];
    //设置按钮上图片的偏移量
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);

    //设置图片左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)search:(UIButton *)btn {
    SearchViewController *search = [[SearchViewController alloc] init];
    search.model = self.model;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell" bundle:nil] forCellReuseIdentifier:@"HomeDetailCell"];
    
    _index = 1;
    //创建下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (void)loadNewData {
    _index = 1;
    HZUser *user = [Config getProfile];
    NSDictionary *param = @{@"serviceDeptId":user.dept,@"customNameOrMobile":@"",@"groupId":[NSString stringWithFormat:@"%ld",self.model.Id],@"doctorId":user.doctorId,@"pageIndex":@(_index),@"pageSize":@(10)};
    
    [[GroupListHttpRequest getInstatce] requestNewData:param completionBlock:^(NSMutableArray *dataArr, NSString *message) {
        [self.tableView.mj_header endRefreshing];
        if (dataArr.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        if (message) {
            //失败
            [HZUtils showHUDWithTitle:message];
        }else {
            
            [[AudionPlayer shareAudioPlayer] play];
            self.dataArr = dataArr;
            [self.tableView reloadData];
        }
    }];
}

- (void)loadMoreData {
    _index ++;
    HZUser *user = [Config getProfile];
    NSDictionary *param = @{@"serviceDeptId":user.dept,@"customNameOrMobile":@"",@"groupId":[NSString stringWithFormat:@"%ld",self.model.Id],@"doctorId":user.doctorId,@"pageIndex":@(_index),@"pageSize":@(10)};
    
    [[GroupListHttpRequest getInstatce] requestMoreData:param completionBlock:^(NSMutableArray *dataArr, NSString *message) {
       
        if (dataArr.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        if (message) {
            [HZUtils showHUDWithTitle:message];
        }else {
            [[AudionPlayer shareAudioPlayer] play];
            
            [self.dataArr addObjectsFromArray:dataArr];
            [self.tableView reloadData];
            
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeDetailCell"];
    HomeDetailModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //(lldb) po test.accountID 91482299-9b6f-48d9-962f-7c5cbd938762
    
   // (lldb) po test.custID 40210
    
    HomeDetailModel *model = self.dataArr [indexPath.row];
    
    UserDetailViewController *detail = [[UserDetailViewController alloc] init];
    detail.cname = model.cname;
    detail.photoUrl = model.photoUrl;
    detail.accountID = model.accountId;
    detail.custID = model.custId;
    
    detail.mobile = model.mobile;
    detail.gender = model.gender;
    detail.birthday = model.birthday;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
