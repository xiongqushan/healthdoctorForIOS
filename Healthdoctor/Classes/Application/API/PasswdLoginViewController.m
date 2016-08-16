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

@interface PasswdLoginViewController ()

@end

@implementation PasswdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.LoginBtn setRound];
}

- (IBAction)login:(id)sender {
    NSString *passwd = [MD5 md532BitLower:self.passwdTextField.text];
    NSDictionary *param = @{@"Account":self.phoneNumTextField.text,@"Password":passwd};
    

    [[GKNetwork sharedInstance] PostUrl:kLoginValidateURL param:param completionBlockSuccess:^(id responseObject) {
        NSString *message = responseObject[@"message"];
        NSLog(@"_____________success:%@",responseObject);
        
        if ([responseObject[@"state"] integerValue] == 1) {
            NSDictionary *data = responseObject[@"Data"];
            HZUser *user = [[HZUser alloc] init];
            [user setValuesForKeysWithDictionary:data];
            user.isLogin = @"1";
            user.doctorId = data[@"Doctor_ID"];
            user.lastLogOn = data[@"Last_Log_On"];
            [Config saveProfile:user];
    
            //跳转页面
            HZTabBarViewController *hzTab = [[HZTabBarViewController alloc] init];

            [self presentViewController:hzTab animated:NO completion:nil];
            
        }else {
         
            [HZUtils showHUDWithTitle:message];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"_____error:%@",error);
        [HZUtils showHUDWithTitle:@"网络出错！"];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.passwdTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
}


@end