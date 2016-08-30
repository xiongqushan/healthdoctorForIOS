//
//  MineViewController.m
//  Health
//
//  Created by 郭凯 on 16/5/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "MineViewController.h"
#import "Define.h"
#import "SettingCell.h"
#import "BaseSetting.h"
#import "SettingViewController.h"
#import "SpeechViewController.h"
#import "PersonalInfoViewController.h"
#import "UIColor+Utils.h"
#import "Config.h"
#import "HZUser.h"
#import "HZUtils.h"
#import <UIButton+WebCache.h>
#import "UIView+Utils.h"
#import "HeaderView.h"

#define MaxIconWH  80.0  //用户头像最大的尺寸
#define MinIconWH  30.0  // 用户头像最小的头像
#define maxScrollOff 165
#define kHeaderViewH 165

@interface MineViewController ()//<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)HeaderView *headerView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpHeaderView];
    
    [self setUpGroup0];// 个人资料
    [self setUpGroup2];// 语音听写
    [self setUpGroup1];// 设置管理
}


- (void)setUpHeaderView {

    self.navigationItem.title = nil;
    
//    self.tableView.showsVerticalScrollIndicator = YES;
//    self.tableView.showsHorizontalScrollIndicator = YES;
    
    HZUser *user = [Config getProfile];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewH + 10, 0, 0, 0);
    
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    headerView.backgroundColor = [UIColor navigationBarColor];
    headerView.frame = CGRectMake(0, -kHeaderViewH - 10, kScreenSizeWidth, kHeaderViewH - 10);
    
    [headerView.iconBtn setRoundWithRadius:40];
    [headerView.iconBtn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:user.photoUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
    
    headerView.nameLabel.text = user.name;

    [self.tableView insertSubview:headerView atIndex:0];
    
    self.headerView = headerView;

}

- (void)iconClick { //头像被点击
    PersonalInfoViewController *person = [[PersonalInfoViewController alloc] init];
    [self.navigationController pushViewController:person animated:YES];
}

- (void)setUpGroup0{

    ArrowItem *arrow = [ArrowItem itemWithTitle:@"个人资料" withImage:[UIImage imageNamed:@"new_friend"]];
    arrow.destVcClass = [PersonalInfoViewController class];
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow];
    [self.dataArr addObject:group];
}

- (void)setUpGroup1 {
    ArrowItem *arrow = [ArrowItem itemWithTitle:@"设置管理" withImage:[UIImage imageNamed:@"card"]];
    arrow.destVcClass = [SettingViewController class];
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow];
    [self.dataArr addObject:group];
}

- (void)setUpGroup2 {
    ArrowItem *arrow = [ArrowItem itemWithTitle:@"语音听写" withImage:[UIImage imageNamed:@"vip"]];
    arrow.destVcClass = [SpeechViewController class];
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow];
    [self.dataArr addObject:group];
}

#pragma mark -- viewWillAppear && viewWillDisappear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0.0;
    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
////    
//    [UIView animateWithDuration:0.25 animations:^{
//        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0.0;
//    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat updateY = scrollView.contentOffset.y;
    self.headerView.frame = CGRectMake(0, updateY, kScreenSizeWidth, - updateY);
    
    updateY += kHeaderViewH;
    CGFloat reduceW = updateY * (MaxIconWH - MinIconWH)/(165 - 64);
    CGFloat yuanW = MAX(MinIconWH, MaxIconWH - reduceW);
     
    self.headerView.iconBtn.layer.cornerRadius = yuanW/2.0;
    
    self.headerView.iconWidth.constant = yuanW;
    self.headerView.iconHeight.constant = yuanW;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
