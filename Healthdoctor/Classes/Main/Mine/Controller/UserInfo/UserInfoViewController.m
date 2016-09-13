//
//  UserInfoViewController.m
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserInfoViewController.h"
#import "BaseSetting.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGroup0];
    [self setUpGroup1];
    
}

- (void)setUpGroup0 {
    SettingItem *set = [SettingItem itemWithTitle:@"姓名"];
    set.subTitle = @"王世淳";
    
    SettingItem *set1 = [SettingItem itemWithTitle:@"专长"];
    set1.subTitle = @"全科";
    
    SettingItem *set2 = [SettingItem itemWithTitle:@"职称"];
    set2.subTitle = @"高级健康管理师";
    
    SettingItem *set3 = [SettingItem itemWithTitle:@"所属机构"];
    set3.subTitle = @"上海好卓";
    
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[set,set1,set2,set3];
    
    [self.dataArr addObject:group];
}

- (void)setUpGroup1 {
    IntroItem *set = [IntroItem itemWithTitle:@"介绍" introTitle:@"内科医生，高级健管师。二级公共营养师，有丰富的慢性病及企业健管经验。"];
  //  set.subTitle = @"内科医生，高级健管师。二级公共营养师，有丰富的慢性病及企业健管经验。";
    
    GroupItem *group = [[GroupItem alloc] init];
    group.isIntro = YES;
    group.items = @[set];
    
    [self.dataArr addObject:group];

}

- (void)setUpGroup2 {
    LabelItem *label = [[LabelItem alloc] init];
    label.titleText = @"退出登录";
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[label];
    //group.isIntro = YES;
    [self.dataArr addObject:group];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
