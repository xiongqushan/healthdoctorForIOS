//
//  ReportPhotoCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportPhotoModel.h"
#import "MSSBrowseDefine.h"

typedef void(^PersentBlock)(MSSBrowseNetworkViewController *vc);

@interface ReportPhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UIView *photoView;

@property (nonatomic, copy) PersentBlock present;

- (void)showDataWithModel:(ReportPhotoModel *)model;


@end
