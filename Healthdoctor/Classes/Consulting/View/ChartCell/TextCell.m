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
    [self.rightIconImageView setRoundWithRadius:25];
    
    if ([model.consultType integerValue] == 3) {
        self.backImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        [self.backImageView addGestureRecognizer:tap];
    }
    
    if ([model.isDoctorReply integerValue] == 1) {
        //回复的Cell
        //根据内容的size改变气泡的大小
        HZUser *user = [Config getProfile];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGSize size = [model.content boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        self.leftConstraint.constant = kScreenSizeWidth - 120 - size.width - 40;
        
        self.leftIconImageView.hidden = YES;
        self.rightIconImageView.hidden = NO;
        [self.rightIconImageView sd_setImageWithURL:[NSURL URLWithString:user.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
        
        self.contentLabel.text = model.content;
        UIImage *image = [UIImage imageNamed:@"SenderAppCardNodeBkg"];
        self.backImageView.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];
        
    }else if([model.isDoctorReply integerValue] == 0){
        
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
         CGSize size = [model.content boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        self.rightConstraint.constant = kScreenSizeWidth - 120 - size.width - 40;
        
        self.rightIconImageView.hidden = YES;
        self.leftIconImageView.hidden = NO;
        [self.leftIconImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
        NSString *contentStr = model.content;
        
        if ([model.consultType integerValue] == 3) {
            contentStr = [contentStr stringByAppendingString:@"\n点击查看报告"];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
            [str setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:NSMakeRange(contentStr.length - 6, 6)];
            self.contentLabel.attributedText = str;
        }else {
            self.contentLabel.text = [NSString stringWithFormat:@"%@",contentStr];
        }
        
        UIImage *image = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        self.backImageView.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];

    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)cellClick:(UITapGestureRecognizer *)tap {
    NSLog(@"________%@",_model.content);
    
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
