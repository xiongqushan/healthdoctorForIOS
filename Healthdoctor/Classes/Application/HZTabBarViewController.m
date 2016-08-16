//
//  HZTabBarViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HZTabBarViewController.h"
#import "HomeViewController.h"
#import "ConsultViewController.h"
#import "MineViewController.h"
#import "HZNavigationController.h"
#import "UIImage+image.h"
#import "Config.h"
#import "PasswdLoginViewController.h"

@interface HZTabBarViewController ()

@end

@implementation HZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

        
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageWithOriginalName:@"home_selected"] title:@"主页"];
    
    ConsultViewController *consult = [[ConsultViewController alloc] init];
    [self setUpOneChildViewController:consult image:[UIImage imageNamed:@"consulation"] selectedImage:[UIImage imageWithOriginalName:@"consulation_selected"] title:@"咨询"];
    
    MineViewController *mine = [[MineViewController alloc] init];
    [self setUpOneChildViewController:mine image:[UIImage imageNamed:@"main"] selectedImage:[UIImage imageWithOriginalName:@"main_selected"] title:@"我的"];
    
    //self.selectedIndex = 1;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outLogin:) name:@"LoginOutNotification" object:nil];
}

- (void)outLogin:(NSNotification *)notification {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
     
    HZNavigationController *nav = [[HZNavigationController alloc] initWithRootViewController:vc];
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectedImage];
    
    vc.title = title;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
