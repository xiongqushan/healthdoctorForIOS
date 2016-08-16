//
//  ImageCell.m
//  Heath
//
//  Created by 郭凯 on 16/4/27.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "ImageCell.h"
#import <UIImageView+WebCache.h>
#import "Define.h"
#import "UIView+Utils.h"
#import "HZUtils.h"

@implementation ImageCell
{
    NSMutableArray *_imageArr;
    NSMutableArray *_smallImageArr;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _smallImageArr = [NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ChartModel *)model {
    [_smallImageArr removeAllObjects];
    
    NSString *date = [model.commitOn stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.dateLabel.text = [HZUtils getDetailDateStrWithDate:date];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    [self.iconImageView setRoundWithRadius:25];
    UIImage *image = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
    self.bgImageView.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];
    NSArray *imageArr = [model.appendInfo componentsSeparatedByString:@","];
    _imageArr = [NSMutableArray arrayWithArray:imageArr];
    CGFloat bgViewWidth = kScreenSizeWidth - 120 - 10;
    CGFloat itemWidth = (bgViewWidth - 40) /3;
    CGFloat padding = 10;
    if (imageArr.count < 3) {
        NSInteger count = 3 - imageArr.count;
        self.rightConstraint.constant = 60 + count*(padding + itemWidth);
    }else {
        
        self.rightConstraint.constant = 60;
    }
    for (NSInteger i = 0; i < imageArr.count; i++) {
        NSInteger column = i%3; //列
        NSInteger row = i/3 +1; //行
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((column +1)*padding + column*itemWidth +5, row*padding + (row - 1)*itemWidth, itemWidth, itemWidth)];
       
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)]];
        imageView.tag = 300 + i;
        imageView.userInteractionEnabled = YES;
        [_smallImageArr addObject:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]]];
        [self.bgView addSubview:imageView];
    }
}

- (void)imageTap:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - 300;
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSInteger i = 0; i < _imageArr.count; i++) {
        MSSBrowseModel *model = [[MSSBrowseModel alloc] init];
        model.smallImageView = _smallImageArr[i];
        model.bigImageUrl = _imageArr[i];
        [imageArr addObject:model];
    }
    MSSBrowseNetworkViewController *vc = [[MSSBrowseNetworkViewController alloc] initWithBrowseItemArray:imageArr currentIndex:index];
    if (self.clickBlock) {
        self.clickBlock(vc);
    }
    
}

@end
