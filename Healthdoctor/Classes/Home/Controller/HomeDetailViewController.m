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
#import "TestViewController.h"

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
    _index = 1;
    [self requestDataWithCustomNameOrld:@"" pageIndex:_index pageSize:10];
}
//
//- (void)loadUserInfoData {
//    NSDictionary *param = @{@"customerId":self.model.Id};
//    [[GKNetwork sharedInstance] GetUrl:kGetCusInfoURL param:param completionBlockSuccess:^(id responseObject) {
//        
//        //  NSLog(@"_________%@",responseObject);
//        if ([responseObject[@"state"] integerValue] != 1) {
//            [HZUtils showHUDWithTitle:responseObject[@"message"]];
//            return ;
//        }
//        NSDictionary *data = responseObject[@"Data"];
//        CusInfoModel *model = [[CusInfoModel alloc] init];
//        [model setValuesForKeysWithDictionary:data];
//        model.commitOn = self.model.commitOn;
//        self.infoModel = model;
//      //  [self setUpUserInfoViewWithModel:model];
//    } failure:^(NSError *error) {
//        
//    }];
//}

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
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell" bundle:nil] forCellReuseIdentifier:@"HomeDetailCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _index = 1;
        self.tableView.mj_footer.hidden = NO;
        [self requestDataWithCustomNameOrld:@"" pageIndex:_index pageSize:10];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _index ++;
        [self requestDataWithCustomNameOrld:@"" pageIndex:_index pageSize:10];
    }];
}

- (void)endRefershView {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)requestDataWithCustomNameOrld:(NSString *)customName pageIndex:(NSInteger)index pageSize:(NSInteger)count {
    HZUser *user = [Config getProfile];
    
    NSDictionary *param = @{@"serviceDeptId":user.dept,@"customNameOrMobile":customName,@"groupId":self.model.Id,@"doctorId":user.doctorId,@"pageIndex":@(index),@"pageSize":@(count)};
    [[GKNetwork sharedInstance] GetUrl:kGroupCustInfoListURL param:param completionBlockSuccess:^(id responseObject) {
        if (index == 1) {
            [self.dataArr removeAllObjects];
        }
        NSLog(@"________success:%@",responseObject);
        NSDictionary *data = responseObject[@"Data"];
        NSString *message = responseObject[@"message"];
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:message];
            [self endRefershView];
            return ;
        }
        
        NSInteger count2 = [data[@"Count"] integerValue];
        if (count2 == 0) {
            [HZUtils showHUDWithTitle:@"没有服务人数！"];
            self.tableView.mj_footer.hidden = YES;
            [self endRefershView];
            return;
        }
        
        NSArray *dataArr = data[@"Data"];
        if(dataArr.count == 0) {
            [HZUtils showHUDWithTitle:@"没有更多数据!"];
            self.tableView.mj_footer.hidden = YES;
        }
        for (NSDictionary *dict in dataArr) {
            HomeDetailModel *model = [[HomeDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        
        [self endRefershView];
        
    } failure:^(NSError *error) {
        NSLog(@"________error:%@",error);
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
    
    TestViewController *test = [[TestViewController alloc] init];
    test.cname = model.cname;
    test.photoUrl = model.photoUrl;
    test.custID = model.custId;
    test.accountID = model.accountId;
    [self.navigationController pushViewController:test animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
