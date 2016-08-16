//
//  GKAlertView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/10.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "GKAlertView.h"
#import "UIView+Utils.h"
#import "Define.h"
#import "OtherView.h"
#import "HZUtils.h"

#define kButtonColor kSetRGBColor(0, 208, 150)

@interface GKAlertView ()

@property (nonatomic, strong) NSMutableArray *resultArr; //传过来的arr
@property (nonatomic, strong) NSMutableArray *finalDataArr;  //添加过小尾巴的arr
@property (nonatomic, strong) UIView *backgroundView; //弹框背景view
@property (nonatomic, strong) UIView *contentView;   //显示内容的View

@end

@implementation GKAlertView
{
    NSString *_resultStr;
}

//初始化方法
- (instancetype)initWithResultArr:(NSMutableArray *)resultArr {
    if (self = [super init]) {
        
        self.resultArr = resultArr;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        
        [self initData];
        [self setUpSubviews];

    }
    return self;
}

//初始化数据
- (void)initData {
    self.finalDataArr = [NSMutableArray array];
    //给常用短语进行编号
    for (NSInteger i = 0; i < self.resultArr.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld、%@",i+1,self.resultArr[i]];
        [self.finalDataArr addObject:str];
    }
    
    //添加小尾巴
    [self.finalDataArr insertObject:@"您好！\n" atIndex:0];
    [self.finalDataArr addObject:@"感谢您的支持。\n"];
    [self.finalDataArr addObject:@"祝健康！"];
}

//根据数组得到拼接后的属性字符串
- (NSMutableAttributedString *)getTextStrWithArr:(NSMutableArray *)arr {
    
    //将数组中的元素进行拼接
    NSString *resultStr = @"";
    for (NSString *str in arr) {
        resultStr = [resultStr stringByAppendingString:str];
    }
    
    //创建属性字符串用拼接后的字符串
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:resultStr];
    
    //根据这个字符串对象可以得到小尾巴短语的位置坐标
    NSString *locationStr = @"";
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *str = arr[i];
        
        if (![HZUtils isNumAtFirst:str]) {
            //判断常用短语 如果不是以数字开头则添加属性
            NSLog(@"_____%@",NSStringFromRange(NSMakeRange(locationStr.length, str.length)));
            NSRange range = NSMakeRange(locationStr.length, str.length);
            NSDictionary *att = @{NSForegroundColorAttributeName:kButtonColor};
            [attributedStr addAttributes:att range:range];
        }
        locationStr = [locationStr stringByAppendingString:str];
    }
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, locationStr.length)];
    return attributedStr;
}

//空白区域被点击 隐藏AlertView
- (void)bgViewTap:(UITapGestureRecognizer *)tap {
    [self hide];
    [self hideAlertAnimation];
}

//隐藏键盘
- (void)contentViewTap:(UITapGestureRecognizer *)tap {
    UITextView *textView = [self.contentView viewWithTag:101];
    [textView resignFirstResponder];
}

//创建子View
- (void)setUpSubviews {
    
    //创建灰色背景
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTap:)]];
    [self addSubview:bgView];
    self.backgroundView = bgView;
    
    //创建内容视图
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(5, 70, self.bounds.size.width - 10, self.bounds.size.height - 70)];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView setRound];
    [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTap:)]];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    //创建TextView
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 20, self.contentView.bounds.size.width - 10, self.contentView.bounds.size.height - 200)];
    [textView setRound];
    textView.backgroundColor = [UIColor clearColor];
    textView.tag = 101;
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:18
                     ];
    //根据数组内容得到拼接后的字符串
    textView.attributedText = [self getTextStrWithArr:self.finalDataArr];
    [self.contentView addSubview:textView];
    
    //给TextView添加一个边框
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, textView.bounds.size.width, textView.bounds.size.height)];
    UIImage *image = [UIImage imageNamed:@"cellBg2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 50, 10, 50) resizingMode:UIImageResizingModeStretch];
    bgImageView.image = image;
    [self.contentView insertSubview:bgImageView belowSubview:textView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(20, self.contentView.bounds.size.height - 45, self.contentView.bounds.size.width/2 - 25, 40);
    [leftBtn setTitle:@"上一步" forState:UIControlStateNormal];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = 5;
    [leftBtn addTarget: self action:@selector(leftViewCancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = kButtonColor;
    [self.contentView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.contentView.bounds.size.width/2 +5, self.contentView.bounds.size.height - 45, self.contentView.bounds.size.width/2 - 25, 40);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 5;
    [rightBtn addTarget: self action:@selector(leftViewSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = kButtonColor;
    [self.contentView addSubview:rightBtn];
    
    OtherView *otherView = [[OtherView alloc] initWithFrame:CGRectMake(0, textView.bounds.size.height + textView.frame.origin.y + 20, 160, 100)];
    otherView.block = ^(BOOL canClick,NSInteger index,BOOL isAdd) {
        
        if (index == 0) {
            //点击第一个按钮
            if (isAdd) {
                //是添加常用语 将常用语添加到数组中
                [self.finalDataArr insertObject:@"您好！\n" atIndex:0];
            }else {
                //删除常用语  将常用语从数组中删除
                [self.finalDataArr removeObjectAtIndex:0];
            }
            
        }else if (index == 1) {
            if (isAdd) {
                if ([self.finalDataArr containsObject:@"祝健康！"]) {
                    [self.finalDataArr insertObject:@"感谢您的支持。\n" atIndex:self.finalDataArr.count -1];
                }else {
                    [self.finalDataArr addObject:@"感谢您的支持。\n"];
                }
                
            }else {
                [self.finalDataArr removeObject:@"感谢您的支持。\n"];
            }
        }else if (index == 2) {
            if (isAdd) {
                [self.finalDataArr addObject:@"祝健康！"];
                
            }else {
                [self.finalDataArr removeObject:@"祝健康！"];
            }
        }
        //根据数组的内容改变textView的内容
        textView.attributedText = [self getTextStrWithArr:self.finalDataArr];
    };
    
    [self.contentView addSubview:otherView];

}

- (void)leftViewCancleBtnClick:(UIButton *)btn {
    [self hide];
    [self hideAlertAnimation];
}

- (void)leftViewSureBtnClick:(UIButton *)btn {
    NSLog(@"__________确认，传值");
    UITextView *textView = [self.contentView viewWithTag:101];
    //发送通知
    NSDictionary *value = @{@"text":textView.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSendMessageNotification object:nil userInfo:value];
    
    [self hide];
    [self hideAlertAnimation];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    if (windowViews && [windowViews count] > 0) {
        UIView *subview = [windowViews objectAtIndex:[windowViews count] - 1];
        for (UIView *aSubView in subview.subviews) {
            [aSubView.layer removeAllAnimations];
        }
        [subview addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
}

- (void)showBackground
{
    self.backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    self.backgroundView.alpha = 0.3;
    [UIView commitAnimations];
    
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.contentView.layer addAnimation:animation forKey:nil];
}

- (void)hide {
    self.contentView.hidden = YES;
    [self hideAlertAnimation];
    [self removeFromSuperview];
}

- (void)hideAlertAnimation {
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    self.backgroundView.alpha = 0.0;
    [UIView commitAnimations];
}


@end
