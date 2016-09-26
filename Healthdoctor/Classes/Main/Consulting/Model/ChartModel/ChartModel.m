//
//  ChartModel.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/20.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ChartModel.h"
#import "HZUtils.h"
#import "Define.h"

@implementation ChartModel
{
    CGFloat _cellHeight;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        if ([self.consultType integerValue] !=2) {
            
            NSString *content = self.content;
            if ([self.consultType integerValue] == 3) {
                content = [self.content stringByAppendingString:@"\n点击查看报告"];
            }
            CGSize size = [HZUtils getHeightWithFont:[UIFont systemFontOfSize:14] title:content maxWidth:kScreenSizeWidth - 150];
            _cellHeight = size.height + 63;
        }
    }
    return _cellHeight;
}

@end
