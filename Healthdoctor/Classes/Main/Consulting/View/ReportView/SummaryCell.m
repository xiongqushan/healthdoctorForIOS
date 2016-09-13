//
//  SummaryCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SummaryCell.h"
#import "UIView+Utils.h"

@implementation SummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *image = [UIImage imageNamed:@"cellBg2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 150, 20, 150) resizingMode:UIImageResizingModeStretch];
    self.cellImageView.image = image;
    
    [self.pointView setRoundWithRadius:4.5];
}

- (void)showDataWithModel:(SummarysModel *)model {
    
//    NSString *str = [model.content stringByReplacingOccurrencesOfString:@"</strong><br/>" withString:@"\n"];
//    NSString *result = [str stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
//    
//    NSArray *arr = [result componentsSeparatedByString:@"\n"];
    
    self.titleLabel.text = [NSString stringWithFormat:@"*%@",model.title];
    self.contentLabel.text = model.content;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
