//
//  ViewController.m
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import "ViewController.h"
#import "LFWaveProgress.h"
#import "SuspensionManager.h"

@interface ViewController ()
{
    LFWaveProgress *_waveProgress;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //波浪的背景，可以不要
    UIView *waveContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    waveContainer.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
    waveContainer.layer.cornerRadius = waveContainer.bounds.size.width/2.0f;
    waveContainer.layer.masksToBounds = true;
    waveContainer.center = self.view.center;
    [self.view addSubview:waveContainer];
    
    
    //初始化波浪，需要设置字体大小、字体颜色、波浪背景颜色、前层波浪颜色、后层博浪颜色
    _waveProgress = [[LFWaveProgress alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    _waveProgress.center = CGPointMake(waveContainer.bounds.size.width/2.0f, waveContainer.bounds.size.height/2.0f);
    _waveProgress.progress = 0.0f;
    //波浪颜色
//    _waveProgress.waveColor = [UIColor blueColor];
    //波浪背景颜色
//    _waveProgress.waveBackgroundColor = [UIColor clearColor];
    //字体
    _waveProgress.textFont = [UIFont boldSystemFontOfSize:50];
    [waveContainer addSubview:_waveProgress];
    //开始波浪
    [_waveProgress start];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(waveContainer.frame) + 50, self.view.bounds.size.width - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]];
    [self.view addSubview:slider];
}

- (void)sliderMethod:(UISlider*)slider {
    _waveProgress.progress = slider.value;
    [SuspensionManager sharedSuspensionViewManager].progress = slider.value;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[SuspensionManager sharedSuspensionViewManager] createSuspensionView];
    [SuspensionManager sharedSuspensionViewManager].suspensionClickBlock = ^{
        NSLog(@"点击悬浮球");
    };
}

@end
