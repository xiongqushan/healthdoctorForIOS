//
//  PasswdLoginViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/13.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PasswdLoginViewController.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "MD5.h"
#import "Config.h"
#import "HZUtils.h"
#import "HZUser.h"
#import "HZTabBarViewController.h"
#import "UIView+Utils.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
#import <MJExtension.h>
#import "LoginHttpRequest.h"

@interface PasswdLoginViewController ()

@end

@implementation PasswdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.LoginBtn setRound];
    
}


- (void)setAlias:(int)iResCode tags:(NSSet *)tags alias:(NSString *)alias {
    
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (IBAction)login:(id)sender {
    NSString *passwd = [MD5 md532BitLower:self.passwdTextField.text];
    NSDictionary *param = @{@"Account":self.phoneNumTextField.text,@"Password":passwd};
    [LoginHttpRequest requestLogin:param completionBlock:^(NSString *doctorId, NSString *message) {
        if (message) {
            [HZUtils showHUDWithTitle:message];
        }else {
       //     [JPUSHService setAlias:[NSString stringWithFormat:@"%@",doctorId] callbackSelector:@selector(setAlias:tags:alias:) object:self];
            [JPUSHService setTags:nil alias:[NSString stringWithFormat:@"%@",doctorId] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
            }];
            //跳转页面
            HZTabBarViewController *hzTab = [[HZTabBarViewController alloc] init];
            [self presentViewController:hzTab animated:NO completion:nil];
        }
    }];

/*
    [[GKNetwork sharedInstance] PostUrl:kLoginValidateURL param:param completionBlockSuccess:^(id responseObject) {
        NSString *message = responseObject[@"message"];
        
        if ([responseObject[@"state"] integerValue] == 1) {
            NSDictionary *data = responseObject[@"Data"];
            
            HZUser *user = [HZUser mj_objectWithKeyValues:data];
            [Config saveProfile:user];
            
            [JPUSHService setAlias:[NSString stringWithFormat:@"%@",user.doctorId] callbackSelector:@selector(setAlias:tags:alias:) object:self];
            //跳转页面
            HZTabBarViewController *hzTab = [[HZTabBarViewController alloc] init];
            [self presentViewController:hzTab animated:NO completion:nil];

        }else {
         
            [HZUtils showHUDWithTitle:message];
        }
        
    } failure:^(NSError *error) {
        [HZUtils showHUDWithTitle:@"网络出错！"];
        
    }];
    */
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.passwdTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
}


@end
