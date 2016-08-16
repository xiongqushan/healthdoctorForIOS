//
//  BadgeView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/3.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView
{
    NSInteger _badgeValue;
}
- (instancetype)initWithFrame:(CGRect)frame badgeValue:(NSInteger)badgeValue {
    if (self = [super initWithFrame:frame]) {
        _badgeValue = badgeValue;
        [self setUpBadgeView];
    }
    
    return self;
}

- (void)setUpBadgeView {
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    //[label sizeToFit];
    label.text = [NSString stringWithFormat:@"%ld",_badgeValue];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = self.bounds.size.height/2;
    label.font = [UIFont systemFontOfSize:12];
    // [label sizeToFit];
    if(label.bounds.size.width < 15) {
        CGRect frame = label.frame;
        frame.size.width = 15;
        label.frame = frame;
    }
}

@end
