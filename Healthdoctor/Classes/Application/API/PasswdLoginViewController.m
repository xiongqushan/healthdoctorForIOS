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
    

    [[GKNetwork sharedInstance] PostUrl:kLoginValidateURL param:param completionBlockSuccess:^(id responseObject) {
        NSString *message = responseObject[@"message"];
        
        if ([responseObject[@"state"] integerValue] == 1) {
            NSDictionary *data = responseObject[@"Data"];
            HZUser *user = [HZUser mj_objectWithKeyValues:data];
            
//            HZUser *user = [[HZUser alloc] init];
//            [user setValuesForKeysWithDictionary:data];
//            user.isLogin = @"1";
//            user.doctorId = data[@"Doctor_ID"];
//            user.lastLogOn = data[@"Last_Log_On"];
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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.passwdTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
}


@end
