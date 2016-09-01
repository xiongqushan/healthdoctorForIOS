//
//  UIView+Utils.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)setRound {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)setRoundWithRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setBadgeValue:(NSInteger)badgeValue center:(CGPoint)point{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 30, 0, 22, 15)];
    label.center = point;
    //[label sizeToFit];
    label.text = [NSString stringWithFormat:@"%ld",badgeValue];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 15/2.0;
    label.font = [UIFont systemFontOfSize:12];
    label.alpha = 0.8;
    // [label sizeToFit];
    if(label.bounds.size.width < 15) {
        CGRect frame = label.frame;
        frame.size.width = 15;
        label.frame = frame;
    }
    
    [self addSubview:label];
    [self bringSubviewToFront:label];
    if (badgeValue == 0) {
        label.hidden = YES;
    }
}

- (void)addCuttingLine {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cuttingLine"]];
    imageView.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 0.5);
    imageView.alpha = 0.8;
    [self addSubview:imageView];
}
@end
