//
//  OtherView.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/22.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CanClickSureBtnBlock)(BOOL canClick,NSInteger index,BOOL isAdd);

@interface OtherView : UIView
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

@property (nonatomic, copy) CanClickSureBtnBlock block;

- (instancetype)initWithFrame:(CGRect)frame;
@end
