//
//  UserDetailViewController.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CusInfoModel.h"

@interface UserDetailViewController : UIViewController

@property (nonatomic, copy)NSString *cname;
@property (nonatomic, copy)NSString *photoUrl;
@property (nonatomic, copy)NSString *custID;
@property (nonatomic, copy)NSString *accountID;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *birthday;

@property (nonatomic, copy)NSString *commitOn;

@end
