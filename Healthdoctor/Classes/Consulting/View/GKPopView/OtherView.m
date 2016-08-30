//
//  OtherView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/22.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "OtherView.h"

@implementation OtherView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"OtherView" owner:self options:nil] lastObject];
        [self.firstBtn setImage:[UIImage imageNamed:@"otherUnSelected"] forState:UIControlStateNormal];
        [self.secondBtn setImage:[UIImage imageNamed:@"otherUnSelected"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"otherUnSelected"] forState:UIControlStateNormal];
        
        [self.firstBtn setImage:[UIImage imageNamed:@"otherSelected"] forState:UIControlStateSelected];
        [self.secondBtn setImage:[UIImage imageNamed:@"otherSelected"] forState:UIControlStateSelected];
        [self.thirdBtn setImage:[UIImage imageNamed:@"otherSelected"] forState:UIControlStateSelected];
        
        self.firstBtn.selected = YES;
        self.secondBtn.selected = YES;
        self.thirdBtn.selected = YES;
        
        self.frame = frame;
        
    }

    return self;
    
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger count = 0;
    
    btn.selected = !btn.selected;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.selected) {
                count ++;
            }
        }
    }
    
    if (count == 3) {
      //  NSLog(@"能点击");
        if (self.block) {
            self.block(YES,btn.tag - 101,btn.selected);
        }
    }else {
      //  NSLog(@"不能点击");
        if (self.block) {
            self.block(NO,btn.tag - 101,btn.selected);
        }
    }
    
}

@end
