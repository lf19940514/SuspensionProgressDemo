//
//  LFWaveProgress.m
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import "LFWaveProgress.h"
#import "LFWave.h"

@interface LFWaveProgress()
{
    LFWave *_wave;
}

@end

@implementation LFWaveProgress

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildLayout];
    }
    return self;
}

- (void)buildLayout {
    
    _wave = [[LFWave alloc] initWithFrame:self.bounds];
    _wave.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.width/2.0f);
    [self addSubview:_wave];
}

#pragma mark -
#pragma mark Setter

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    _wave.progress = progress;
}

- (void)setTextFont:(UIFont *)textFont {
    _wave.textFont = textFont;
}

- (void)setWaveBackgroundColor:(UIColor *)waveBackgroundColor {
    _wave.waveBackgroundColor = waveBackgroundColor;
}

- (void)setWaveColor:(UIColor *)waveColor {
    _wave.waveColor = waveColor;
}

#pragma mark -
#pragma mark 功能方法
- (void)start {
    [_wave start];
}

- (void)stop {
    [_wave stop];
}

- (void)dealloc {
    [_wave stop];
    [_wave removeFromSuperview];
}

@end
