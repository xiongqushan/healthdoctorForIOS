//
//  SearchViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SearchViewController.h"
#import "HZUtils.h"
#import "Define.h"
#import "UIColor+Utils.h"
#import "HZUser.h"
#import "Config.h"
#import <MBProgressHUD.h>
#import "GKNetwork.h"
#import "HomeDetailModel.h"
#import "HZAPI.h"
#import "HomeDetailCell.h"
//#import "UserViewController.h"
#import "UserDetailViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSearchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    
}

- (void)setUpSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 22, kScreenSizeWidth - 70, 40)];
    self.searchBar.placeholder = @"输入用户名";
    self.searchBar.backgroundImage = [HZUtils imageForColor:kSetRGBColor(53, 168, 240) size:CGSizeMake(kScreenSizeWidth - 70, 40)];
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.delegate = self;
    [self.navigationController.view addSubview:self.searchBar];

}
//返回
- (void)cancle {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadDataWithCustomNameOrld:(NSString *)customName pageIndex:(NSInteger)index pageSize:(NSInteger)count {
    HZUser *user = [Config getProfile];
    
    NSDictionary *param = @{@"serviceDeptId":user.dept,@"doctorId":user.doctorId,@"groupId":self.model.Id,@"customNameOrMobile":customName,@"pageIndex":@(index),@"pageSize":@(count)};
    [[GKNetwork sharedInstance] GetUrl:kGroupCustInfoListURL param:param completionBlockSuccess:^(id responseObject) {
        if (index == 1) {
            [self.dataArr removeAllObjects];
        }
        NSDictionary *data = responseObject[@"Data"];
        NSString *message = responseObject[@"message"];
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:message];
            return ;
        }
        
        NSInteger count2 = [data[@"Count"] integerValue];
        if (count2 == 0) {
            [HZUtils showHUDWithTitle:@"没有该客户！"];
            return;
        }
        NSArray *dataArr = data[@"Data"];
        for (NSDictionary *dict in dataArr) {
            HomeDetailModel *model = [[HomeDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [HZUtils showHUDWithTitle:@"网络不给力"];
    }];

}

- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell" bundle:nil] forCellReuseIdentifier:@"HomeDetailCell"];
}

#pragma mark -- UITableViewDelegate
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
    
    HomeDetailModel *model = self.dataArr[indexPath.row];
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

#pragma mark -- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self setUpTableView];
    [self loadDataWithCustomNameOrld:searchBar.text pageIndex:1 pageSize:10];
    [self.searchBar resignFirstResponder];
}

//点击屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

//隐藏返回按钮
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.searchBar.hidden = NO;
}

//将searchBar从父视图中移除
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchBar.hidden = YES;
    [self.searchBar resignFirstResponder];
}

@end
