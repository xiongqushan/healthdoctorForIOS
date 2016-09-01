//
//  SettingViewController.m
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SettingViewController.h"
#import "BaseSetting.h"
#import "AboutUsViewController.h"
#import "SuggestViewController.h"
#import "HZUtils.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotifi:) name:@"changeNotifi" object:nil];
    self.title = @"设置";
    
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
}

- (void)getNotifi:(NSNotification *)noti {
    NSLog(@"________123");
    [self.tableView reloadData];
}

- (void)setUpGroup0 {
    ArrowItem *arrow = [ArrowItem itemWithTitle:@"关于我们" withImage:[UIImage imageNamed:@"about"]];
    arrow.destVcClass = [AboutUsViewController class];
    
    ArrowItem *arrow2 = [ArrowItem itemWithTitle:@"帮助" withImage:[UIImage imageNamed:@"help"]];
    ArrowItem *arrow3 = [ArrowItem itemWithTitle:@"意见反馈" withImage:[UIImage imageNamed:@"suggest"]];
    arrow3.destVcClass = [SuggestViewController class];
    
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow,arrow2,arrow3];
    
    [self.dataArr addObject:group];
}

- (void)setUpGroup1 {
    ArrowItem *arrow = [ArrowItem itemWithTitle:@"免责声明" withImage:[UIImage imageNamed:@"disclaimer"]];
    arrow.destVcClass  = [AboutUsViewController class];
    
    //ArrowItem *arrow2 = [ArrowItem itemWithTitle:@"清理缓存" withImage:[UIImage imageNamed:@"vip"]];
    SettingItem *set = [SettingItem itemWithTitle:@"清理缓存" withImage:[UIImage imageNamed:@"clearCache"]];
    
    SwitchItem *switchView = [SwitchItem itemWithTitle:@"推送设置" withImage:[UIImage imageNamed:@"messagePush"]];
    //switchView.on = [HZUtils getNotificationStatus];
    
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[arrow,set,switchView];
    
    [self.dataArr addObject:group];
}

- (void)setUpGroup2 {
    LabelItem *label = [[LabelItem alloc] init];
    label.titleText = @"退出登录";
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[label];
    
    [self.dataArr addObject:group];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"______%d",[HZUtils getNotificationStatus]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
