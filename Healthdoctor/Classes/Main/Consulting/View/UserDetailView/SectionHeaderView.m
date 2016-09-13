//
//  SectionHeaderView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SectionHeaderView.h"
#import "UIView+Utils.h"

@interface SectionHeaderView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowH;

@end

@implementation SectionHeaderView

- (void)initBaseUI {
    
    if (_isOpend) {
        self.arrowH.constant = 12;
        self.arrowW.constant = 20;
        self.arrowImageView.image = [UIImage imageNamed:@"arrow_selected"];
        //_isOpend = NO;
    }else {
        self.arrowH.constant = 20;
        
        self.arrowW.constant = 12;
        self.arrowImageView.image = [UIImage imageNamed:@"right_back"];
        // _isOpend = YES;
    }
}

- (IBAction)updateBtnClick:(id)sender {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //监听view被点击
    [super touchesBegan:touches withEvent:event];
    
   // self.sectionHeaderBg.userInteractionEnabled = YES;
    if (self.didClickBlock) {
        self.didClickBlock();
    }
}


- (BOOL)isOpend {
    return _isOpend;
}


@end
