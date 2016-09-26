//
//  PersonalInfoViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/27.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "BaseSetting.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "Config.h"
#import "HZUser.h"
#import "HZUtils.h"
#import "PersonInfoHttpRequest.h"

@interface PersonalInfoViewController ()
@property (nonatomic, copy)NSString *professional; //职称
@property (nonatomic, copy)NSString *department;
@property (nonatomic, strong)HZUser *user;

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.user = [Config getProfile];
    
    [self getBasList];
    [self getDeptList];
    
    self.title = @"个人资料";
    [self setUpGroup0];
    [self setUpGroup1];
}

//获取职称
- (void)getBasList {
    [PersonInfoHttpRequest requestProfessional:^(NSString *professional, NSString *message) {
        if (message) {
            [HZUtils showHUDWithTitle:message];
        }else {
            self.professional = professional;
            [self setValueWithIndex:2 string:professional];
            [self.tableView reloadData];
        }
    }];
/*
    [[GKNetwork sharedInstance] GetUrl:kBasConstListURL param:nil completionBlockSuccess:^(id responseObject) {
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            return ;
        }
        
        NSArray *arr = responseObject[@"Data"];
        for (NSDictionary *dict in arr) {
            if ([dict[@"Code"] integerValue] == [_user.position integerValue]) {
                self.professional = dict[@"Name"];
            }
        }
//        [self setUpGroup0];
//        [self setUpGroup1];
        [self setValueWithIndex:2 string:self.professional];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {

    }];
 */
}

//获取所属机构
- (void)getDeptList {
    [PersonInfoHttpRequest requestDepartmentName:^(NSString *department, NSString *message) {
        if (message) {
            [HZUtils showHUDWithTitle:message];
        }else {
            self.department = department;
            [self setValueWithIndex:3 string:self.department];
            [self.tableView reloadData];
        }
    }];
/*
    [[GKNetwork sharedInstance] GetUrl:kServiceDeptListURL param:nil completionBlockSuccess:^(id responseObject) {
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            return ;
        }
        
        //HZUser *user = [Config getProfile];
        NSArray *arr = responseObject[@"Data"];
        for (NSDictionary *dict in arr) {
            if ([_user.dept integerValue] == [dict[@"Id"] integerValue]) {
                self.department = dict[@"Name"];
            }
        }
        [self setValueWithIndex:3 string:self.department];
        [self.tableView reloadData];
   
    } failure:^(NSError *error) {
        
    }];
 */
    
}

- (void)setValueWithIndex:(NSInteger)index string:(NSString *)str{
    GroupItem *group = self.dataArr[0];
    SettingItem *set = group.items[index];
    set.subTitle = str;
}

- (void)setUpGroup0 {
    SettingItem *set = [SettingItem itemWithTitle:@"姓名"];
    set.subTitle = _user.name;
    
    SettingItem *set1 = [SettingItem itemWithTitle:@"专长"];
    set1.subTitle = _user.expertise;
    
    SettingItem *set2 = [SettingItem itemWithTitle:@"职称"];
    set2.subTitle = self.professional;
    
    SettingItem *set3 = [SettingItem itemWithTitle:@"所属机构"];
    set3.subTitle = self.department;
    
    GroupItem *group = [[GroupItem alloc] init];
    group.items = @[set,set1,set2,set3];
    
    [self.dataArr addObject:group];
}

- (void)setUpGroup1 {
    //@"内科医生，高级健管师。二级公共营养师，有丰富的慢性病及企业健管经验。"
    IntroItem *set = [IntroItem itemWithTitle:@"介绍" introTitle:_user.introduce];
    //  set.subTitle = @"内科医生，高级健管师。二级公共营养师，有丰富的慢性病及企业健管经验。";
    
    GroupItem *group = [[GroupItem alloc] init];
    group.isIntro = YES;
    group.items = @[set];
    
    [self.dataArr addObject:group];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
