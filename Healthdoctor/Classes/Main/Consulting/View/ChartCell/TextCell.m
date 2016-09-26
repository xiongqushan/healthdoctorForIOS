//
//  TextCell.m
//  Heath
//
//  Created by 郭凯 on 16/4/26.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "TextCell.h"
#import "Define.h"
#import "UIView+Utils.h"
#import <UIImageView+WebCache.h>
#import "HZUser.h"
#import "Config.h"
#import "HZUtils.h"
#import "UIColor+Utils.h"

@implementation TextCell
{
    ChartModel *_model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showDataWithModel:(ChartModel *)model{
    _model = model;
    
    NSString *date = [model.commitOn stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.dateLabel.text = [HZUtils getDetailDateStrWithDate:date];
    
    [self.leftIconImageView setRoundWithRadius:25];

    
    if ([model.consultType integerValue] == 3) {
        //如果咨询的是体检报告中的内容 添加手势，点击跳转到体检报告
        self.backImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        [self.backImageView addGestureRecognizer:tap];
    }
    
        
    [self.leftIconImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    NSString *contentStr = model.content;
    
    if ([model.consultType integerValue] == 3) {
        //如果咨询的是体检报告中的内容  在内容后面拼接“点击查看报告”
        contentStr = [model.content stringByAppendingString:@"\n点击查看报告"];
        //将字符串转成属性字符串
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
        //将“点击查看报告”内容改变颜色
        [str setAttributes:@{NSForegroundColorAttributeName:kSetRGBColor(11, 106, 233),NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(contentStr.length - 6, 6)];
        //将属性字符串赋值到label上
        self.contentLabel.attributedText = str;
    }else {
        self.contentLabel.text = [NSString stringWithFormat:@"%@",contentStr];
    }
    
    UIImage *image = [UIImage imageNamed:@"chat_icon_bubble_min_incomming"];
    //创建一个内容可拉伸边角不拉伸的图片  即只拉伸左边的第22个像素和上边的31个像素的区域剩余部分不拉伸
    self.backImageView.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];

    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)cellClick:(UITapGestureRecognizer *)tap {
    
    NSArray *arr = [_model.appendInfo componentsSeparatedByString:@";"];
    NSString *workNo = arr[0];
    NSString *checkCode = arr[1];
    
    if (self.messageClick) {
        self.messageClick(checkCode,workNo);
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
