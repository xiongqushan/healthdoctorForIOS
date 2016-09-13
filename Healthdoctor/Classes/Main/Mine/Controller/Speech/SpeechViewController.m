//
//  SpeechViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SpeechViewController.h"
#import "UIView+Utils.h"
#import "iflyMSC/IFlyMSC.h"
#import "GKRecognizer.h"

@interface SpeechViewController ()// <IFlyRecognizerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendStrBtn;

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@end

@implementation SpeechViewController
{
    BOOL _isCancle;//点击屏幕时候记录是否取消
}
- (IBAction)starBtnClick:(id)sender {
    
    [_textView resignFirstResponder];

//    [[GKRecognizer shareManager] recognizerShowView:self.view result:^(NSString *result) {
//       _textView.text = [_textView.text stringByAppendingString:result];
//        
//    }];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&&path=com.ihaozhuo.health"]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&&path=当前应用的bundleid"]];
}

- (IBAction)sendBtnClick:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"提示" message:self.textView.text delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语音听写";
    [self.starBtn setRound];
    [self.sendStrBtn setRound];
    [self.textView setRound];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            NSLog(@"推送关闭!!");
        }else {
            NSLog(@"推送打开!!");
        }
    }else {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (UIRemoteNotificationTypeNone == type) {
            NSLog(@"推送关闭!!");
        }else {
            NSLog(@"推送打开!!");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
