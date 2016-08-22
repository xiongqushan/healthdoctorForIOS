//
//  CommonLanguageCell.m
//  Heath
//
//  Created by 郭凯 on 16/4/22.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "CommonLanguageCell.h"

@interface CommonLanguageCell()
@property (nonatomic, strong)CommonLanguageModle *model;
@property (nonatomic, strong)NSMutableArray *selectedArr;

@end

@implementation CommonLanguageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedArr = [NSMutableArray array];
    UIImage *image = [UIImage imageNamed:@"cellBg2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 50, 10, 50) resizingMode:UIImageResizingModeStretch];
    self.cellImageView.image = image;
    
}

- (void)showDataWithModel:(CommonLanguageModle *)model index:(NSInteger)index{
    self.model = model;

    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    
    self.titleLabel.text = model.content;
    if ([model.isClick isEqualToString:@"1"]) {
        self.selectBtn.selected = YES;
    }else {
        self.selectBtn.selected = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectedBtnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.selected) {
        self.selectBtn.selected = NO;
        self.model.isClick = @"0";
        [self.selectedArr removeObject:self.model];
    }else {
        
        self.selectBtn.selected = YES;
        self.model.isClick = @"1";
        [self.selectedArr addObject:self.model];
    }
    
    if (self.selectedBlock) {
        NSString *content = [NSString stringWithFormat:@"%@\n",self.model.content];
        self.selectedBlock(content,self.model.isClick);
    }
}

@end
