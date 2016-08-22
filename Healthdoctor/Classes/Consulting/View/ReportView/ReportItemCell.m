//
//  ReportItemCell.m
//  ReportTableViewDemo
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportItemCell.h"
#import "ShowDetailView.h"
#import "Define.h"

@implementation ReportItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.valueLabel.userInteractionEnabled = YES;
    [self.valueLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(valueTap:)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)valueTap:(UITapGestureRecognizer *)tap {
    ShowDetailView *view = [[ShowDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight) title:self.valueLabel.text];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    });
}

- (void)showDataWithModel:(ResultModel *)model isExceptionsView:(BOOL)isExceptions{
    NSInteger flagId = [model.resultFlagID integerValue];
    if (!isExceptions) {
        //不是体检异常界面  将异常项的cell变红
        if (!(flagId == 0 || flagId == 1)) {
            //是异常项
            self.checkIndexNameLabel.textColor = [UIColor redColor];
            self.valueLabel.textColor = [UIColor redColor];
        }else {
            //不是异常项
            self.checkIndexNameLabel.textColor = kSetRGBColor(51, 51, 51);
            self.valueLabel.textColor = kSetRGBColor(51, 51, 51);
        }
    }

    
    self.checkIndexNameLabel.text = model.checkIndexName;
    self.valueLabel.text = model.resultValue;
    
    if (model.textRef.length > 0) {
        self.refLabel.text = [NSString stringWithFormat:@"参考范围:%@",model.textRef];
    }else {
        self.refLabel.text = model.textRef;
    }
    
    if (model.unit.length > 0) {
        self.unitLabel.text = [NSString stringWithFormat:@"单位:%@",model.unit];
    }else {
        self.unitLabel.text = model.unit;
    }
}

@end
