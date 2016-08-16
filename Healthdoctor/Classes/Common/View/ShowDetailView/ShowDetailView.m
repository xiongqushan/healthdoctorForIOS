//
//  ShowDetailView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/30.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ShowDetailView.h"
#import "Define.h"

@implementation ShowDetailView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self showViewWithText:title];
    }
    return self;
}

- (void)showViewWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenSizeHeight/2-100, kScreenSizeWidth - 20, 200)];
   // label.backgroundColor = [UIColor redColor];
//    label.center = CGPointMake(kScreenSizeWidth/2, kScreenSizeHeight/2);
//    [label sizeToFit];
    label.numberOfLines = 0;
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [UIView animateWithDuration:0.2 animations:^{
//        [self removeFromSuperview];
//    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}


@end
