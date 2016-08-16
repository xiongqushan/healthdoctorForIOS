//
//  ConsulationView.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"

typedef void(^GetBadgeValueBlock)(NSInteger value);

@interface ConsulationView : UIView

@property (nonatomic, copy) GetBadgeValueBlock badgeBlock;

//根据传入的url 进行请求相应的界面数据
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr url:(NSString *)url;

@end
