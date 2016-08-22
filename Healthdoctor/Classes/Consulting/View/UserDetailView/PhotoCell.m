//
//  PhotoCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PhotoCell.h"
#import <UIImageView+WebCache.h>
#import "Define.h"
#import "UIView+Utils.h"

@implementation PhotoCell

- (void)showDataWithModel:(PhotoCasesModel *)model {
//    self.totalNum.text = [NSString stringWithFormat:@"%ld",model.imageUrlList.count];
//    [self.totalNum setRoundWithRadius:10];
//    self.date.text = model.date;
//    self.checkCenter.text = model.healthCompanyName;
//    [self.imageBgView bringSubviewToFront:self.totalNum];
    
    CGFloat bgViewW = (kScreenSizeWidth - 20)/3;
    CGFloat bgViewH = bgViewW*0.8;
    
    NSInteger flag = 2;
    NSArray *images = model.imageUrlList;
    for (NSInteger i = images.count - 1; i >= 0; i--) {

        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageUrl = [NSString stringWithFormat:@"%@!small200",images[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        imageView.frame = CGRectMake(5, 5, bgViewW - 10, bgViewH - 10);
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0;
        [_imageBgView addSubview:imageView];
        
        if (flag%2 == 0) {
            imageView.transform = CGAffineTransformMakeRotation(0.05*i);
            
        }else if (flag%2 == 1){
            imageView.transform = CGAffineTransformMakeRotation(-0.05*i);
        }
        
        imageView.layer.shadowOffset = CGSizeMake(0, 2);
        imageView.layer.shadowRadius = 3.0;
        imageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        imageView.layer.shouldRasterize = YES;
        imageView.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
        imageView.layer.masksToBounds = YES;
        
        
        flag--;
    }
    
    [self.contentView setBadgeValue:images.count center:CGPointMake(bgViewW - 11, 10)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
