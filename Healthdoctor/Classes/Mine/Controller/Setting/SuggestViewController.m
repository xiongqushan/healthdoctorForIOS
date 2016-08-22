//
//  SuggestViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/28.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SuggestViewController.h"
#import "UIView+Utils.h"
#import "HZUtils.h"

@interface SuggestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *QQTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation SuggestViewController
- (IBAction)submitBtnClick:(id)sender {
    self.textView.text = @"";
    [HZUtils showHUDWithTitle:@"反馈成功！"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self.submitBtn setRound];
    [self.textView setRound];
    //self.cuttingLineH.constant = 0.5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardChange:(NSNotification *)note {
    
    if ([self.textView isFirstResponder]) {
        return;
    }
    
    NSDictionary *userInfo = note.userInfo;
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect keybeginFrame = [userInfo[@"UIKeyboardFrameBeginUserInfoKey"]CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
   
    if (keybeginFrame.size.height <= 0) {
        return;
    }
    CGFloat differY = keyFrame.origin.y - keybeginFrame.origin.y;
    if (differY < 10) {
        moveY += 160;
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    [self.QQTextField resignFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
