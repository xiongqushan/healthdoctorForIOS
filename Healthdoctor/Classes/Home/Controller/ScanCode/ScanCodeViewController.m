//
//  ScanCodeViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Define.h"
#import "ConfirmViewController.h"

@interface ScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UIImageView *boxView;
@property (nonatomic) BOOL isReading;
@property (nonatomic, strong)UIImageView *scanImageView;

//捕捉会话
@property (nonatomic, strong)AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码";
    [self initData];
    [self starReading];
}

- (void)initData {
    self.captureSession = nil;
    _isReading = NO;
}

- (BOOL)starReading {
    NSError *error;
    //1.初始化捕捉设备(AVCaptureDevice)，类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"_____%@",[error localizedDescription]);
        return NO;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1将输入流添加到会话
    [_captureSession addInput:input];
    //4.2将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    
    //5.创建串行队列，并将媒体输出流添加到队列中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1 设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2 设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    //6. 实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //8. 设置图层的frame
    [_videoPreviewLayer setFrame:self.view.bounds];
    
    //9. 将图层添加到预览view的图层上
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    //10. 设置扫描范围
    CGRect cropRect = CGRectMake(50, 150, kScreenSizeWidth - 100, kScreenSizeWidth - 100);
    captureMetadataOutput.rectOfInterest = CGRectMake(cropRect.origin.y/kScreenSizeHeight, cropRect.origin.x/kScreenSizeWidth, cropRect.size.height/kScreenSizeHeight, cropRect.size.width/kScreenSizeWidth);
    
    //11. 扫描框
    _boxView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, kScreenSizeWidth - 100, kScreenSizeWidth - 100)];
    _boxView.image = [UIImage imageNamed:@"QREdges"];
    [self.view addSubview:_boxView];
    
    //12. 扫描线
    _scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 0, _boxView.bounds.size.width- 32, 10)];
    _scanImageView.image = [UIImage imageNamed:@"QRLine"];
    [_boxView addSubview:_scanImageView];
    
    //添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [self.timer fire];
    [self.captureSession startRunning];
    
    return YES;
}

- (void)moveScanLayer:(NSTimer *)timer {
    CGRect frame = _scanImageView.frame;
    if (_boxView.frame.size.height < _scanImageView.frame.origin.y + 20) {
        frame.origin.y = 0;
        _scanImageView.frame = frame;
    }else {
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanImageView.frame = frame;
        }];
    }
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    //扫描成功
    [self.captureSession stopRunning];
    [self.timer setFireDate:[NSDate distantFuture]];
    
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSLog(@"___________________stringValue:%@",[metadataObj stringValue]);
            
            [self performSelectorOnMainThread:@selector(pushConfirm) withObject:nil waitUntilDone:NO];
        }
    }
    
}

- (void)pushConfirm {
    self.captureSession = nil;
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.scanImageView removeFromSuperview];
    [self.videoPreviewLayer removeFromSuperlayer];
    [self.boxView removeFromSuperview];
    
    ConfirmViewController *confirmLogin = [[ConfirmViewController alloc] init];
    [self presentViewController:confirmLogin animated:YES completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
