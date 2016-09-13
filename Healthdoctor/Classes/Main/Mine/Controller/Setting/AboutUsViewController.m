//
//  AboutUsViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.title = self.titleText;
    self.contentLabel.text = self.content;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
