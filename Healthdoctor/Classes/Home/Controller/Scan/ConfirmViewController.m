//
//  ConfirmViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ConfirmViewController.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "Config.h"
#import "HZUser.h"
#import "HZUtils.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
//关闭
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确认登录
- (IBAction)confirmLogin:(id)sender {

    HZUser *user = [Config getProfile];
    
    NSDictionary *param = @{@"identity":self.codeInfo,@"userId":user.doctorId};
    
    [[GKNetwork sharedInstance] GetUrl:kConfirmLoginURL param:param completionBlockSuccess:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        if ([dict[@"Data"] longValue] == 1) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            [HZUtils showHUDWithTitle:@"登录失败"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}

//取消登录
- (IBAction)cancleLogin:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
