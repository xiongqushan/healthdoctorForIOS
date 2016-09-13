//
//  GKToolBar.h
//  Heath
//
//  Created by 郭凯 on 16/4/27.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTextView.h"

@interface GKToolBar : UIView

@property (nonatomic, strong)SSTextView *textView;
@property (nonatomic, strong)UIButton *expressionsBtn;
@property (nonatomic, strong)UIButton *voiceBtn;

//+(GKToolBar *)createView;
- (instancetype)init;

@end
