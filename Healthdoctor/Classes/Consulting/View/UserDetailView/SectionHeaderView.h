//
//  SectionHeaderView.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderViewDidClickBlock)();

@interface SectionHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (nonatomic, assign) BOOL isOpend;
@property (nonatomic, copy) HeaderViewDidClickBlock didClickBlock;

- (void)initBaseUI;

@end
