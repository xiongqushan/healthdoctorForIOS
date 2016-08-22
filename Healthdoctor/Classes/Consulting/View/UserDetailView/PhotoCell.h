//
//  PhotoCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCasesModel.h"

@interface PhotoCell : UICollectionViewCell

//@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *checkCenter;
@property (weak, nonatomic) IBOutlet UIView *imageBgView;

- (void)showDataWithModel:(PhotoCasesModel *)model;

@end
