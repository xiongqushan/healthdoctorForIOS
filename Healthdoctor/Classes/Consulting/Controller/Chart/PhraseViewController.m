//
//  PhraseViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/9.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PhraseViewController.h"
#import "UIColor+Utils.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUtils.h"
#import "CommonLanguageModle.h"
#import "CommonLanguageCell.h"
#import "Define.h"
#import "GKAlertView.h"

#define kConsultViewH 120

@interface PhraseViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *resultArr;

@end

@implementation PhraseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBaseUI];
    [self loadPhraseData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSendMessageNotifi:) name:kSendMessageNotification object:nil];
    
}

- (void)getSendMessageNotifi:(NSNotification *)noti {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setUpBaseUI {
    self.view.backgroundColor = [UIColor viewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加搜索框
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, kScreenSizeWidth - 140, 30)];
    searchBar.placeholder = @"关键字搜索";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    
    //添加咨询内容所在的view
    UIView *consulatView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kConsultViewH)];
    consulatView.backgroundColor = kSetRGBColor(242, 242, 242);
    
    //添加左侧标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 20, kConsultViewH)];
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"咨询内容";
    //titleLabel.backgroundColor = [UIColor redColor];
    [consulatView addSubview:titleLabel];
    
    //添加右侧咨询内容的View
    UITextView *textView= [[UITextView alloc] initWithFrame:CGRectMake(80, 10, kScreenSizeWidth - 80 - 10, kConsultViewH - 20)];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = self.consultStr;
    textView.editable = NO;
    [consulatView addSubview:textView];
    [self.view addSubview:consulatView];
    
    //添加UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + kConsultViewH, kScreenSizeWidth, kScreenSizeHeight - 64 - kConsultViewH - 50) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor viewBackgroundColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"CommonLanguageCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    self.tableView = tableView;
    
    //添加下一步按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(25, self.view.bounds.size.height - 45, kScreenSizeWidth - 50, 40);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = kSetRGBColor(0, 208, 150);
    [self.view addSubview:btn];

}

- (void)showPopView {
    GKAlertView *alertView = [[GKAlertView alloc] initWithResultArr:self.resultArr];
//    alertView.sendMessage = ^(NSString *text) {
//        [self.navigationController popViewControllerAnimated:NO];
//
//    };
    [alertView show];
}

- (void)click:(UIButton *)btn {
    [self showPopView];
}

- (void)loadPhraseData {
    self.dataArr = [NSMutableArray array];
    self.resultArr = [NSMutableArray array];
    
    [[GKNetwork sharedInstance] GetUrl:kDefaultExpressionsURL param:nil completionBlockSuccess:^(id responseObject) {
        [self.dataArr removeAllObjects];
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:@"请求失败"];
            return ;
        }
        NSArray *data = responseObject[@"Data"];
        for (NSDictionary *dict in data) {
            CommonLanguageModle *model = [[CommonLanguageModle alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.isClick = @"0";
            [self.dataArr addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    NSDictionary *param = @{@"keyWord":searchBar.text,@"withUnenabled":@"false"};
    
   /// __weak PhraseViewController *weakSelf = self;
    
    [[GKNetwork sharedInstance] GetUrl:kSearchExpressionsURL param:param completionBlockSuccess:^(id responseObject) {
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            return ;
        }
        [self.dataArr removeAllObjects];
        for (NSDictionary *dict in responseObject[@"Data"]) {
            CommonLanguageModle *model = [[CommonLanguageModle alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.isClick = @"0";
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommonLanguageModle *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model index:indexPath.row];
    
    __weak PhraseViewController *weakSelf = self;
    cell.selectedBlock = ^(NSString *title,NSString *isAdd){
        
        if ([isAdd isEqualToString:@"1"]) {
            [weakSelf.resultArr addObject:title];
        }else {
            [weakSelf.resultArr removeObject:title];
        }
        
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommonLanguageModle *model = self.dataArr[indexPath.row];
    //NSString *content = [NSString stringWithFormat:@"%ld、%@",indexPath.row,model.content];
    CGSize size = [HZUtils getHeightWithFont:[UIFont systemFontOfSize:15] title:model.content maxWidth:kScreenSizeWidth - 73 - 10];
    if ((size.height + 32)< 50) {
        return 50;
    }
    return size.height + 32;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    CommonLanguageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:101];
    [cell selectedBtnClick:btn];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
