//
//  LoginViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "LoginViewController.h"
#import "HZTabBarViewController.h"
#import "HZAPI.h"
#import "GKNetwork.h"
#import <MBProgressHUD.h>
#import "HZUtils.h"
#import "UIButton+countDown.h"
#import "HZUser.h"
#import "Config.h"

#define kTestUrl @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=20&category_id=0"
//#define khttpUrl @"http://10.50.50.85:19949/api/v1_User/LoginSMSCode?mobile=123"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@end

@implementation LoginViewController
{
    __block int _timeout;
    NSTimer *_countDownTimer;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginClick:(id)sender {
    
    if (self.codeTextField.text.length == 0) {
        [HZUtils showHUDWithTitle:@"请输入验证码"];
        return;
    }
    
    NSDictionary *param = @{@"Mobile":self.phoneTextField.text,@"SmsCode":self.codeTextField.text};

    [[GKNetwork sharedInstance] PostUrl:kLoginURL param:param completionBlockSuccess:^(id responseObject) {
        NSLog(@"________PostSuccess:%@",responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *result = [NSString stringWithFormat:@"%@",dict[@"state"]];
        
        if ([result isEqualToString:@"1"]) {
            //验证成功
            NSDictionary *data = dict[@"Data"];
            NSLog(@"_______data:%@",data);
            HZUser *user = [[HZUser alloc] init];
            [user setValuesForKeysWithDictionary:data]; //字典转模型
            user.isLogin = @"1"; //登录
            //保存用户登录信息
            [Config saveProfile:user];

            //跳转页面
            HZTabBarViewController *hzTab = [[HZTabBarViewController alloc] init];
            [self presentViewController:hzTab animated:YES completion:nil];

        }else {
            [HZUtils showHUDWithTitle:dict[@"message"]];

        }
        
    } failure:^(NSError * error) {
        NSLog(@"_________%@",error);
        [HZUtils showHUDWithTitle:@"网络异常"];
    }];
}
- (IBAction)getCode:(id)sender {//获取验证码
    
    //验证是否为正确的手机号
    BOOL isPhoneNumber = [HZUtils isPhoneNumber:self.phoneTextField.text];
    if (!isPhoneNumber) {
        [HZUtils showHUDWithTitle:@"请输入正确的手机号"];
    }
    
    //网络请求，获取验证码
    NSString *phoneNumber = self.phoneTextField.text;
    NSDictionary *dict = @{@"mobile":phoneNumber};
   // MBProgressHUD *HUD = [HZUtils createHUD];
    
    [[GKNetwork sharedInstance] GetUrl:kGetCaptchaURL param:dict completionBlockSuccess:^(id responseObject) {
       // [HUD hide:YES];
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSNumber *state = dict[@"state"];
        NSLog(@"_________GetSuccess:%@",dict);
        if (state.longValue == 1) {
            NSLog(@"______成功");
            //GCD 倒计时
            [_getCodeBtn startWithTime:30 title:@"获取验证码" countDownTitle:@"重新获取" mainColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f] countColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f]];
        }else {
            [HZUtils showHUDWithTitle:@"服务器异常"];
            return ;
        }
        
    } failure:^(NSError *error) {
       // [HUD hide:YES];
        NSLog(@"_________GetError:%@",error);
        [HZUtils showHUDWithTitle:@"网络异常"];
        
    }];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
