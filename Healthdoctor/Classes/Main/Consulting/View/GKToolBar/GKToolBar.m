
//
//  GKToolBar.m
//  Heath
//
//  Created by 郭凯 on 16/4/27.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "GKToolBar.h"
#import "Define.h"
#import "UIView+SDAutoLayout.h"
#import "UIView+Utils.h"

@implementation GKToolBar

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kSetRGBColor(239, 239, 244);
        [self createView];
    }
    
    return self;
}

- (void)createView {
//    GKToolBar *toolBar = [[GKToolBar alloc] init];
//    toolBar.backgroundColor = kSetRGBColor(239, 239, 244);
    
    SSTextView *textView = [[SSTextView alloc] init];
    [textView setRound];
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"输入内容:";
    textView.returnKeyType = UIReturnKeySend;
    [self addSubview:textView];
    self.textView = textView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //[btn setTitle:@"短语" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"expression"] forState:UIControlStateNormal];
    [self addSubview:btn];
    self.expressionsBtn = btn;
    
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [voiceBtn setRoundWithRadius:15];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [self addSubview:voiceBtn];
    self.voiceBtn = voiceBtn;
    
    
    textView.sd_layout.leftSpaceToView(self,50).widthIs(kScreenSizeWidth - 100).topSpaceToView(self,5).bottomSpaceToView(self,5);
    btn.sd_layout.rightSpaceToView(self,10).topSpaceToView(self,8).bottomSpaceToView(self,8).widthIs(30).heightIs(30);
    voiceBtn.sd_layout.leftSpaceToView(self,10).topSpaceToView(self,8).bottomSpaceToView(self,8).widthIs(30).heightIs(30);

}

@end
