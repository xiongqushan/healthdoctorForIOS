//
//  ChartBaseViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/27.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ChartBaseViewController.h"
#import "Define.h"
#import "GKToolBar.h"
#import "TextModel.h"
#import "TextCell.h"
#import "CommonLanguageModle.h"
#import "CommonLanguageCell.h"
#import "UIView+SDAutoLayout.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "CusInfoModel.h"
#import "HZUtils.h"
#import "FeedbackModel.h"
#import "ImageCell.h"
#import "Config.h"
#import "HZUser.h"
#import <MJRefresh.h>
#import "UIColor+Utils.h"
#import "UIView+Utils.h"
#import "ReportDetailViewController.h"
#import "GKRecognizer.h"
#import "GFWaterView.h"
#import "PhraseViewController.h"
#import "UserDetailViewController.h"

#define kVoiceHeight 220

@interface ChartBaseViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@end

@implementation ChartBaseViewController
{
    BOOL _userViewIsHidden; //userView 是否隐藏
    CGPoint _tableViewOffset; //保存tableView的偏移量，
    CGFloat _kboardHeight;
    NSTimer *_timer;        //定时器执行动画
    BOOL _isRecognizering; //判断是否停止语音识别
    
    UITableView *_tableView;
    GKToolBar *_toolBar;
    SSTextView *_textView;
    NSMutableArray *_textDataArr; //保存聊天记录的可变数组
    CusInfoModel *_infoModel;
    UIView *_voiceView;
    UILabel *_navTitleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textDataArr = [NSMutableArray array];
    
    //添加监听收到消息时的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSendMessageNoti:) name:kSendMessageNotification object:nil];
    
    //获取聊天记录
    [self loadChartDataWithDate:[self getCurrentDate]];
    
    [self loadUserInfoData];//获取个人信息
    //添加可点击的导航title
    [self setUpNavTitleViewWithTitle:self.customName];
    [self setUpTableView];
    [self setUpToolBar];
}

- (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *currentDate = [dateFormatter stringFromDate:date];
    return currentDate;
}

- (void)getSendMessageNoti:(NSNotification *)noti {
    NSString *text = noti.userInfo[@"text"];
    [self sendMessage:text];
}

- (void)loadChartDataWithDate:(NSString *)date {
    NSLog(@"_____date:%@",date);
    NSDictionary *param = @{@"customerId":self.customId,@"commitOn":date};
    [[GKNetwork sharedInstance] GetUrl:kGetAskReplyURL param:param completionBlockSuccess:^(id responseObject) {
        NSInteger count = 0;
       // [self.textDataArr removeAllObjects];
        
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            [_tableView.mj_header endRefreshing];
            return ;
        }
        
        NSArray *data = responseObject[@"Data"];
        if (data.count == 0) {
            [HZUtils showHUDWithTitle:@"全部加载完成"];
            _tableView.mj_header.hidden = YES;
            [_tableView.mj_header endRefreshing];
            return;
        }
        for (NSDictionary *dict in data) {
            ChartModel *model = [[ChartModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if ([model.isDoctorReply integerValue] == 1) {
                model.consultType = @"1";
            }
            [_textDataArr addObject:model];
            count ++;
        }
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count - 1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
    }];
}

- (void)loadUserInfoData {
    NSDictionary *param = @{@"customerId":self.customId};
    [[GKNetwork sharedInstance] GetUrl:kGetCusInfoURL param:param completionBlockSuccess:^(id responseObject) {
       
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            return ;
        }
        
        NSDictionary *data = responseObject[@"Data"];
        CusInfoModel *model = [[CusInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:data];
       // model.commitOn = self.commitOn;
        _infoModel = model;
        
        NSString *navTitle = [NSString stringWithFormat:@"%@ %@ %@",model.cname,[HZUtils getGender:model.gender],[HZUtils getAgeWithBirthday:model.birthday]];
        //[self setUpNavTitleViewWithTitle:navTitle];
        _navTitleLabel.text = navTitle;
        
    } failure:^(NSError *error) {
        
    }];
}

//设置TableView
- (void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor viewBackgroundColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64 - 46)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor viewBackgroundColor];
    [tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [tableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"ImageCell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    // _tableViewOffset = self.tableView.contentOffset;
    
    //创建下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
   // [header beginRefreshing];
    _tableView.mj_header = header;
    
}

- (void)loadNewData {
    ChartModel *model = _textDataArr.lastObject;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z:-]" options:0 error:NULL];
    NSString *date = [regular stringByReplacingMatchesInString:model.commitOn options:0 range:NSMakeRange(0, [model.commitOn length]) withTemplate:@""];
    NSInteger dateValue = [date integerValue] - 100;
    [self loadChartDataWithDate:[NSString stringWithFormat:@"%ld",dateValue]];
}

////设置用户信息View
//- (void)setUpUserInfoViewWithModel:(CusInfoModel *)model {
//    
//    self.userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, 64)];
//    self.userInfoView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.userInfoView];
//    
//    if ([self isKindOfClass:[PendingDetailViewController class]]) {
//        UserInfoView *userInfoView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
//        userInfoView.iconClick = ^(){
//            [self pushViewController];
//            
//        };
//        [userInfoView addCuttingLine];
//        userInfoView.backgroundColor = [UIColor whiteColor];
//        userInfoView.frame = self.userInfoView.bounds;
//        [userInfoView showDataWithModel:model photoUrl:self.model.photoUrl];
//        [self.userInfoView addSubview:userInfoView];
//    }else {
//        FeedbackInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"FeedbackInfoView" owner:self options:nil] lastObject];
//        infoView.iconClick = ^(){
//        
//            [self pushViewController];
//        };
//        [infoView addCuttingLine];
//        infoView.backgroundColor = [UIColor whiteColor];
//        infoView.frame = self.userInfoView.bounds;
//        FeedbackModel *feedModel = (FeedbackModel *)self.model;
//        model.reDoctor = feedModel.reDoctor;
//        model.reDoctorId = feedModel.reDoctorId;
//        model.score = feedModel.score;
//        model.consultTitele = feedModel.consultTitele;
//        
//        [infoView showDataWithModel:model photoUrl:self.model.photoUrl];
//        [self.userInfoView addSubview:infoView];
//    }
//    
//}

//设置导航titleView 并添加手势
- (void)setUpNavTitleViewWithTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 200, 40)];
    // titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = title;
    //[titleLabel sizeToFit];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //titleLabel.tintColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    _navTitleLabel = titleLabel;
    
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClick:)];
    [titleLabel addGestureRecognizer:tap];
}

//导航titleView被点击事件
- (void)titleViewClick:(UITapGestureRecognizer *)tap {
    [self pushViewController];

}

- (void)pushViewController {
    [_textView resignFirstResponder];
    
    UserDetailViewController *detail = [[UserDetailViewController alloc] init];
    detail.cname = self.customName;
    detail.photoUrl = self.photoUrl;
    detail.custID = self.customId;
    detail.accountID = _infoModel.account_Id;
//   // test.chartDataArr = _textDataArr;
//    detail.customInfoModel = _infoModel;
    detail.mobile = _infoModel.mobile;
    detail.gender = _infoModel.gender;
    detail.birthday = _infoModel.birthday;
    
    [self.navigationController pushViewController:detail animated:YES];
}

//设置ToolBar
- (void)setUpToolBar {
    
    _toolBar = [[GKToolBar alloc] init];
    [self.view insertSubview:_toolBar aboveSubview:_tableView];
    _toolBar.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(46).bottomSpaceToView(self.view,0);
    _textView = _toolBar.textView;
    _textView.delegate = self;
    
    UIButton *btn = _toolBar.expressionsBtn;
    [btn addTarget:self action:@selector(phraseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *voiceBtn = _toolBar.voiceBtn;
    [voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillChange:(NSNotification *)note {
   // [self.view bringSubviewToFront:self.toolBar];

    if (_isRecognizering) {
        [_timer setFireDate:[NSDate distantFuture]];
        [[GKRecognizer shareManager] stopRecognizer];
        _isRecognizering = NO;
    }
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect keybeginFrame = [userInfo[@"UIKeyboardFrameBeginUserInfoKey"]CGRectValue];
    CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
    
    CGFloat differY = keyFrame.origin.y - keybeginFrame.origin.y;
    
    if ((self.view.frame.size.height - keyFrame.size.height) > _tableView.contentSize.height) {
        //键盘出现挡不住聊天内容
        if (differY > 10) {
            //隐藏keyboard

            [UIView animateWithDuration:duration animations:^{
                _toolBar.sd_layout.bottomSpaceToView(self.view,0);
                [_toolBar updateLayout];
            }];
            
        }else {
            
            ///[self cancelAllThing];
            
            [UIView animateWithDuration:duration animations:^{
                
                _toolBar.sd_layout.bottomSpaceToView(self.view,keyFrame.size.height);
                [_toolBar updateLayout];
            }];
        }
        
    }else {
        //键盘出现挡住聊天内容
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
        }];
    }

}

- (UIView *)voiceView {
    if (!_voiceView) {
        _voiceView = [[UIView alloc] init];
        _voiceView.frame = CGRectMake(0, self.view.bounds.size.height, kScreenSizeWidth, kVoiceHeight);
        _voiceView.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        voiceBtn.frame = CGRectMake(0, 0, 60, 60);
        voiceBtn.center = CGPointMake(kScreenSizeWidth/2.0, 110);
        [voiceBtn setImage:[UIImage imageNamed:@"edit_voiceinput"] forState:UIControlStateNormal];
        [voiceBtn addTarget: self action:@selector(voiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_voiceView addSubview:voiceBtn];
    }
    
    return _voiceView;
}

- (void)voiceBtnClick {
   // _isRecognizering = !_isRecognizering;
    
    if (_isRecognizering) {
        //停止识别
        [_timer setFireDate:[NSDate distantFuture]];
        [[GKRecognizer shareManager] stopRecognizer];
        _isRecognizering = NO;
    }else {
        [_timer setFireDate:[NSDate distantPast]];
        [self voiceBtnClick:nil];
        _isRecognizering = YES;
    }
}

- (void)starAnim {
    
    __block GFWaterView *waterView = [[GFWaterView alloc]initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kVoiceHeight)];
    waterView.backgroundColor = [UIColor clearColor];
    [self.voiceView insertSubview:waterView atIndex:0];

    [UIView animateWithDuration:2 animations:^{
        waterView.transform = CGAffineTransformScale(waterView.transform, 4, 4);
        waterView.alpha = 0;
    } completion:^(BOOL finished) {
        [waterView removeFromSuperview];
    }];
}

#pragma mark -- 语音听写按钮被点击
- (void)voiceBtnClick:(UIButton *)voiceBtn {
    [_textView resignFirstResponder];
    if (_isRecognizering) {
        [self cancelAllThing];
        _isRecognizering = NO;
        return;
    }
    //开始语音听写
    [[GKRecognizer shareManager] starRecognizerResult:^(NSString *result) {
        
        _textView.text = [_textView.text stringByAppendingString:result];
        [self textViewDidChange:_textView];
    }];
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(starAnim) userInfo:nil repeats:YES];
    }
    _isRecognizering = YES;
    [_timer setFireDate:[NSDate distantPast]];
    
    
    //显示view
    if ((self.view.frame.size.height - kVoiceHeight) > _tableView.contentSize.height) {
        //view没有挡住内容
        [self.view insertSubview:self.voiceView aboveSubview:_tableView];

        [UIView animateWithDuration:0.25 animations:^{
            self.voiceView.frame = CGRectMake(0, kScreenSizeHeight - kVoiceHeight, kScreenSizeWidth, kVoiceHeight);
            _toolBar.sd_layout.bottomSpaceToView(self.view,kVoiceHeight);
            [_toolBar updateLayout];
        }];
        
    }else {
        [[UIApplication sharedApplication].keyWindow addSubview:self.voiceView];
        //view挡住了内容
        [UIView animateWithDuration:0.25 animations:^{
            self.voiceView.frame = CGRectMake(0, kScreenSizeHeight - kVoiceHeight, kScreenSizeWidth, kVoiceHeight);
            self.view.transform = CGAffineTransformMakeTranslation(0, -kVoiceHeight);
        }];
    }

}
#pragma mark -- 常用短语按钮被点击
//常用短语按钮被点击
- (void)phraseBtnClick:(UIButton *)btn {
    [_textView resignFirstResponder];
    [self cancelAllThing];
    
    PhraseViewController *phrase = [[PhraseViewController alloc] init];
    for (ChartModel *model in _textDataArr) {
        if ([model.isDoctorReply integerValue] == 0) {
            if ([model.consultType integerValue] == 3) {
                phrase.consultStr = model.content;
                break;
            }
        }
    }
    
    if (!phrase.consultStr) {
        NSLog(@"_____空");
        for (ChartModel *model in _textDataArr) {
            if ([model.isDoctorReply integerValue] == 0) {
                if ([model.consultType integerValue] == 2) {
                    phrase.consultStr = @"最近咨询的一条是照片病例。";
                }else {
                    phrase.consultStr = model.content;
                }
                 break;
            }
        }
    }
    
    [self.navigationController pushViewController:phrase animated:YES];
}

- (void)delayMethod {
    [_textView becomeFirstResponder];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    CGFloat textviewH = 0;
    CGFloat minHeight = 36;
    CGFloat maxHeight = 108;
    
    CGFloat contentHeight = textView.contentSize.height;
    if (contentHeight <minHeight) {
        textviewH = minHeight;
    }else if(contentHeight>maxHeight){
        textviewH = maxHeight;
    }else{
        textviewH = textView.contentSize.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textView.sd_layout.heightIs(textviewH);
        [_textView updateLayout];
        _toolBar.sd_layout.heightIs(textviewH+10);
        [_toolBar updateLayout];
        [self.view layoutIfNeeded];
    }];
    
}

- (void)sendMessage:(NSString *)text {
    
    HZUser *user = [Config getProfile];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *currentDate = [dateFormatter stringFromDate:date];
    
    NSDictionary *param = @{@"DoctorId":_infoModel.doctorID,@"ReDoctorId":user.doctorId,@"ReDoctorName":user.name,@"CustomerId":self.customId,@"ReplyContent":text,@"ReplyTime":currentDate};
    [[GKNetwork sharedInstance] PostUrl:kAddDoctorReplyURL param:param completionBlockSuccess:^(id responseObject) {
        
        if ([responseObject[@"state"] integerValue] == 1) {
            [HZUtils showHUDWithTitle:@"回复成功"];
            ChartModel *model = [[ChartModel alloc] init];
            model.consultType = @"1";
            model.isDoctorReply = @"1";
            model.content = text;
            model.photoUrl = user.photoUrl;
            
            model.commitOn = [HZUtils getDateWithDate:[NSDate date]];
            [_textDataArr insertObject:model atIndex:0];
            
            NSIndexPath *indexPaht = [NSIndexPath indexPathForRow:_textDataArr.count - 1 inSection:0];
            [_tableView insertRowsAtIndexPaths:@[indexPaht] withRowAnimation:UITableViewRowAnimationNone];
            
            //[textView resignFirstResponder]; //取消第一响应
            NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_textDataArr.count - 1 inSection:0];
            [_tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeListNotifi" object:nil];
            
        }else {
            [HZUtils showHUDWithTitle:@"回复失败"];
        }
    } failure:^(NSError *error) {
        [HZUtils showHUDWithTitle:@"回复失败"];
    
    }];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        //把textView的内容封装到model中，并添加到可变数组
        NSString *textStr = textView.text;
        _textView.text = @""; // 将textView内容清空
        [self textViewDidChange:_textView]; //将textView的高度恢复默认
        
        [self sendMessage:textStr];
        return NO;
    }
    
    return YES;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _textDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak ChartBaseViewController *weakSelf = self;
    //纯文本样式
    NSInteger count = _textDataArr.count - 1;
    ChartModel *model = _textDataArr[count - indexPath.row];

    if ([model.consultType integerValue] == 2) {
        ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        cell.clickBlock = ^(MSSBrowseNetworkViewController *vc) {
            [vc showBrowseViewController:weakSelf];
        };
        UIView *bgView = [cell.contentView viewWithTag:201];
        for (UIView *view in [bgView subviews]) {
            if ([view isKindOfClass:[UIImageView class]]) {
                if (view.tag != 102) {
                   [view removeFromSuperview];
                }
            }
        }
        [cell showDataWithModel:model];
        
        return cell;
    }else {
        
        static NSString *cellId = @"cellId";
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextCell" owner:self options:nil] lastObject];
        }
        cell.messageClick = ^(NSString *checkCode, NSString *workNo){
            ReportDetailViewController *detail = [[ReportDetailViewController alloc] init];
            detail.checkCode = checkCode;
            detail.workNum = workNo;
            detail.custId = weakSelf.customId;
            [weakSelf.navigationController pushViewController:detail animated:YES];
        };
        [cell showDataWithModel:model];
        return cell;
    }
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = _textDataArr.count - 1;
    ChartModel *model = _textDataArr[count - indexPath.row];
    
    if ([model.consultType integerValue] == 2) {
        
        NSArray *imageArr = [model.appendInfo componentsSeparatedByString:@","];
        NSInteger row = (imageArr.count - 1)/3 +1;
        CGFloat padding = 10;
        CGFloat bgViewWidth = kScreenSizeWidth - 120 - 5;
        CGFloat itemWidth = (bgViewWidth - 40) /3.0;
        return (row + 1)*padding + row*itemWidth +10 +20;
    }else {
        //根据文字内容计算size
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        NSString *contentStr = model.content;
        if ([model.consultType integerValue] == 3) {
           // model.content = [model.content stringByAppendingString:@"\n点击加载更多"];
            contentStr = [model.content stringByAppendingString:@"\n点击查看报告"];
        }
        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 30, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return size.height + 62;

        }

}

#pragma mark -- UIScrollerViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //[self.view endEditing:YES];
    if (scrollView == _tableView) {
        [self cancelAllThing];
    }
    
}

/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView == self.tableView) {
//        CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
//        if (translation.y>0) {
//            
//            NSLog(@"______向下滑动，显示View");
//            [self showUserInfoView];
//        }else if(translation.y<0){
//            
//            NSLog(@"______向上滑动，隐藏View");
//            [self hiddenUserInfoView];
//        }
        
        //滑动时，textView如果是第一响应者，取消
//        if (self.textView.isFirstResponder) {
//            [self.textView resignFirstResponder];
//        }
//        
//        [UIView animateWithDuration:0.25 animations:^{
//            self.voiceView.frame = CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kVoiceHeight);
//            
//            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
//        }];
//        
//        [UIView animateWithDuration:0.25 animations:^{
//            self.toolBar.sd_layout.bottomSpaceToView(self.view,0);
//            [self.toolBar updateLayout];
//        }];
        
        
    }
}

*
//隐藏用户信息View
- (void)hiddenUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.userInfoView.frame;
        frame.origin.y = 0;
        self.userInfoView.frame = frame;
        
        //修改tableView的frame
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.origin.y = 64;
        tableViewFrame.size.height = kScreenSizeHeight - 40 -64;
        self.tableView.frame = tableViewFrame;
    }];

    _userViewIsHidden = YES;
}

//显示用户信息View
- (void)showUserInfoView {
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.userInfoView.frame;
        frame.origin.y = 64;
        self.userInfoView.frame = frame;
        
        //修改tableView的frame
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.origin.y = 64 + 64;
        tableViewFrame.size.height = kScreenSizeHeight - 64 - 40 -64;
        self.tableView.frame = tableViewFrame;
    }];
    
    _userViewIsHidden = NO;
}
*/

//当点击屏幕，或滑动tableView时执行的一系列动作
- (void)cancelAllThing {
    //取消第一响应
    [self.view endEditing:YES];
    //将语音识别View隐藏
    [UIView animateWithDuration:0.25 animations:^{
        self.voiceView.frame = CGRectMake(0, kScreenSizeHeight, kScreenSizeWidth, kVoiceHeight);
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    //将tooBar归位
    [UIView animateWithDuration:0.25 animations:^{
        _toolBar.sd_layout.bottomSpaceToView(self.view,0);
        [_toolBar updateLayout];
    }];
    
    if (!_isRecognizering) {
        return;
    }
    //暂停定时器
    [_timer setFireDate:[NSDate distantFuture]];
    //停止语音识别
    [[GKRecognizer shareManager] stopRecognizer];
    
    _isRecognizering = NO;
    

}

#pragma mark -- 点击屏幕触发的事件
- (void)endEdit {
    [self cancelAllThing];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //销毁定时器
    [_timer invalidate];
    _timer = nil;
    //停止语音识别
    [[GKRecognizer shareManager] stopRecognizer];
    //将语音识别view从父类中删除
    [self.voiceView removeFromSuperview];
    //
    _toolBar.sd_layout.bottomSpaceToView(self.view,0);
    
//    if (_tableView) {
//        [_tableView removeFromSuperview];
//        _tableView = nil;
//    }

}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
