//
//  SuspensionView.m
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import "SuspensionView.h"
#import "LFWaveProgress.h"

#define kTouchWidth self.frame.size.width
#define kTouchHeight self.frame.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define IS_IPHONEX (kScreenHeight >= 812.0f)
#define kTopSafeHeight (IS_IPHONEX ? 44 : 20)
#define kBottomSafeHeight (IS_IPHONEX ? 34 : 0)

@interface SuspensionView()

@property (nonatomic, strong) LFWaveProgress *waveProgress;

@end

@implementation SuspensionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width);
        self.layer.cornerRadius = self.frame.size.width/2.0;
        self.backgroundColor = [UIColor blackColor];
        //拖动
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeLocation:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        
        [self addSubview:self.waveProgress];
    }
    return self;
}

- (LFWaveProgress *)waveProgress {
    if (!_waveProgress) {
        _waveProgress = [[LFWaveProgress alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-4, self.frame.size.width-4)];
        _waveProgress.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.width/2.0);
        _waveProgress.progress = 0;
        _waveProgress.textFont = [UIFont boldSystemFontOfSize:20];
        [_waveProgress start];
    }
    return _waveProgress;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.waveProgress.progress = progress;
}

#pragma mark - event response
- (void)changeLocation:(UIPanGestureRecognizer*)p
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [p locationInView:appWindow];
    
    //透明度
    //    if(p.state == UIGestureRecognizerStateBegan)
    //    {
    //        self.alpha = 1;
    //    }
    //    else if (p.state == UIGestureRecognizerStateEnded)
    //    {
    //        self.alpha = 0.5;
    //    }
    
    //位置
    if(p.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }else if(p.state == UIGestureRecognizerStateEnded)
    {
        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(kScreenWidth - left);
        //ripper:只停留在左右，需要在上下，将注释打开
        //        CGFloat top = fabs(panPoint.y);
        //        CGFloat bottom = fabs(kScreenHeight - top);
        
        CGFloat minSpace = MIN(left, right);
        //        CGFloat minSpace = MIN(MIN(MIN(top, left), bottom), right);
        CGPoint newCenter;
        CGFloat targetY = 0;
        
        //校正Y
        if (panPoint.y < kTopSafeHeight + kTouchHeight/2.0) {
            targetY = kTopSafeHeight + kTouchHeight/2.0;
        }else if (panPoint.y > (kScreenHeight - kTouchHeight/2.0 - 15-kBottomSafeHeight)) {
            targetY = kScreenHeight - kTouchHeight/2.0 - 15-kBottomSafeHeight;
        }else{
            targetY = panPoint.y;
        }
        
        if (minSpace == left) {
            newCenter = CGPointMake(kTouchWidth/2.0, targetY);
        }else{
            newCenter = CGPointMake(kScreenWidth-kTouchWidth/2.0, targetY);
        }
        
        [UIView animateWithDuration:.25 animations:^{
            self.center = newCenter;
        }];
    }
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

@end
