//
//  BaseSettingViewController.m
//  Health
//
//  Created by 郭凯 on 16/5/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseSettingViewController.h"
#import "BaseSetting.h"
#import "SettingCell.h"
#import "Define.h"
#import "IntroCell.h"
#import "SettingViewController.h"
#import "Config.h"
#import "LoginViewController.h"
#import "PersonalInfoViewController.h"
#import "PasswdLoginViewController.h"
#import "AboutUsViewController.h"
#import <SDImageCache.h>
#import "HZUtils.h"

@interface BaseSettingViewController () <UIAlertViewDelegate>

@end

@implementation BaseSettingViewController

- (instancetype)init {
    //self.tableView.backgroundColor = kSetRGBColor(246, 246, 246);
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GroupItem *group = self.dataArr[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupItem *group = self.dataArr[indexPath.section];
    if (group.isIntro) {
        
        IntroItem *item = group.items[indexPath.row];
        IntroCell *cell = [IntroCell cellWithTableView:tableView];
        cell.item = item;
        return cell;
    }
    SettingItem *item = group.items[indexPath.row];
    
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    GroupItem *group = self.dataArr[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc] init];
        //vc.hidesBottomBarWhenPushed = YES;
        if ([vc isKindOfClass:[AboutUsViewController class]]) {
            AboutUsViewController *aboutUs = (AboutUsViewController *)vc;
            if (indexPath.section == 1) {
                //免责声明
                aboutUs.content = @"        账户丢失、泄露免责：用户自行承担注册账号及密码的保管责任，并就其账号及密码项下之一切活动负全部责任。用户应注意网络安全防护，防止账号密码泄露，保证个人信息安全。因用户账户丢失或泄露给用户造成的损失，本平台不承担任何责任。";
                aboutUs.title = @"免责声明";
            }else {
                //关于我们
                aboutUs.content = @"        上海好卓数据服务有限公司成立于2014年7月11号，位于上海市徐汇区。提供个性化体检服务，在检前、检中和检后提供专业的技术支持和数据管理。优健康健管师服务平台是一款集“客户分组管理+咨询管理+重点关注”为一体的健康服务平台。优健康健管师服务平台V1.0经过多次打磨完善，以能满足健管师回复客户咨询、查看客户体检报告和照片病例、对客户重点关注等功能。三大功能模块图标简洁、内容全面、页面大气、实用亦美观。";
                aboutUs.title = @"关于我们";
            }
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([self isKindOfClass:[SettingViewController class]]) {
        if (indexPath.section == 1 && indexPath.row == 1) {
            NSLog(@"________清理缓存");
            double cacheSize = [self getCacheSize];
            NSString *message = [NSString stringWithFormat:@"清除%.2fM缓存？",cacheSize];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag = 102;
            [alert show];
        }
        
        if (indexPath.section == 2) {
            NSLog(@"_________退出登录");
//            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil] show];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag = 101;
            [alert show];
           
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isKindOfClass:[PersonalInfoViewController class]]) {
        if (indexPath.section == 1) {
            GroupItem *group = self.dataArr[indexPath.section];
            IntroItem *item = group.items[indexPath.row];
            CGSize size = [item.introTitle boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 60, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
            return size.height + 35;
        }
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenSizeWidth, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 101) {
        //退出
        if (buttonIndex == alertView.cancelButtonIndex) {
            //取消
        }else {
            
            [Config clearProfile];
            //  LoginViewController *login = [[LoginViewController alloc] init];
            PasswdLoginViewController *login = [[PasswdLoginViewController alloc] init];
            [self presentViewController:login animated:NO completion:nil];
            
        }
    }else if (alertView.tag == 102) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            //取消
        }else {
            
            [self removeCacheSize];
        }
    }
    

}

- (void)removeCacheSize {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    NSString *myCache = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/MyCaches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCache error:nil];
    
    [HZUtils showHUDWithTitle:@"缓存清除成功!"];
    
}

- (double)getCacheSize {
    NSInteger fileSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString *myCache = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/MyCaches"];
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:myCache error:nil];
    NSInteger myCacheSize = dict.fileSize;
    
    fileSize += myCacheSize;
    
    double cacheSize = fileSize/1024.0/1024.0;
    return cacheSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kSetRGBColor(246, 246, 246);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
