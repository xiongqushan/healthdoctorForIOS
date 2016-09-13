//
//  HeaderView.h
//  Heath
//
//  Created by 郭凯 on 16/5/4.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IconBtnClickBlock)();

@interface HeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, copy) IconBtnClickBlock iconBtnClick;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;

@end
