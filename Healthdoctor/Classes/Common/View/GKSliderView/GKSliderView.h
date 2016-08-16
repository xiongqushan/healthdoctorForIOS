//
//  GKSliderView.h
//  Demo
//
//  Created by 郭凯 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//  类似新闻界面

#import <UIKit/UIKit.h>

typedef void(^ItemScrollBlock)(NSInteger index);

@interface GKSliderView : UIView
//滑动时重置view 的位置
@property (nonatomic, copy)ItemScrollBlock scrollBlock;
@property (nonatomic, assign) CGFloat tabBarHeight; //滑动条的高度
@property (nonatomic, strong) UIFont *titleFont; //字体的大小
@property (nonatomic, strong) NSArray *imageArr; //如果有图片，存放图片默认没有
//@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong)UIView *tabBar;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr controllerNameArr:(NSArray *)nameArr;

@end
