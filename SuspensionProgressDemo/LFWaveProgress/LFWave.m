//
//  LFWave.m
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//
/**
 正弦曲线公式可表示为y=Asin(ωx+φ)+k：
 A，振幅，最高和最低的距离
 W，角速度，用于控制周期大小，单位x中的起伏个数
 K，偏距，曲线整体上下偏移量
 φ，初相，左右移动的值
 
 这个效果主要的思路是添加两条曲线 一条正玄曲线、一条余弦曲线 然后在曲线下添加深浅不同的背景颜色，从而达到波浪显示的效果
 */

#import "LFWave.h"

@interface LFWave()
{
    //前面的波浪
    CAShapeLayer *_backWaveLayer;
    //后面的波浪
    CAShapeLayer *_frontWaveLayer;
    //定时刷新器
    CADisplayLink *_disPlayLink;
    /**
     曲线的振幅
     */
    CGFloat _waveAmplitude;
    /**
     曲线角速度
     */
    CGFloat _wavePalstance;
    /**
     曲线初相
     */
    CGFloat _waveX;
    /**
     曲线偏距
     */
    CGFloat _waveY;
    /**
     曲线移动速度
     */
    CGFloat _waveMoveSpeed;
    /**
     底层进度值
     */
    UILabel *_label0;
    /**
     下层进度值
     */
    UILabel *_label1;
    /**
     上层进度值
     */
    UILabel *_label2;
}

@end

@implementation LFWave

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        [self configWave];
    }
    return self;
}

//初始化UI
-(void)buildUI {
    self.backgroundColor = [UIColor whiteColor];
    //初始化波浪
    //底层
    _backWaveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_backWaveLayer];
    
    //上层
    _frontWaveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_frontWaveLayer];
    
    //画圆
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.masksToBounds = true;
    
    //底部白底红字
    _label0 = [[UILabel alloc] initWithFrame:self.bounds];
    _label0.textAlignment = NSTextAlignmentCenter;
    _label0.backgroundColor = [UIColor whiteColor];
    _label0.textColor = [UIColor redColor];
    [self addSubview:_label0];
    
    //下层红底白字
    _label1 = [[UILabel alloc] initWithFrame:self.bounds];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.backgroundColor = [UIColor redColor];
    _label1.textColor = [UIColor whiteColor];
    [self addSubview:_label1];
    
    UIView *view = [[UIView alloc] initWithFrame:_label1.bounds];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [_label1 addSubview:view];
    
    //上层红底白字
    _label2 = [[UILabel alloc] initWithFrame:self.bounds];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.backgroundColor = [UIColor redColor];
    _label2.textColor = [UIColor whiteColor];
    [self addSubview:_label2];
}

//初始化数据
- (void)configWave {
    //振幅
    _waveAmplitude = self.bounds.size.width/20;;
    //角速度
    _wavePalstance = M_PI/self.bounds.size.width;
    //偏距
    _waveY = self.bounds.size.width;
    //初相
    _waveX = 0;
    //x轴移动速度
    _waveMoveSpeed = _wavePalstance * (self.bounds.size.width/40);
}

- (void)updateWave:(CADisplayLink *)link {
    _waveX += _waveMoveSpeed;
    [self updateWaveY];
    [self updateWave1];
    [self updateWave2];
}

//更新偏距的大小 直到达到目标偏距 让wave有一个匀速增长的效果
-(void)updateWaveY
{
    CGFloat targetY = self.bounds.size.height - _progress * self.bounds.size.height;
    if (_waveY < targetY) {
        _waveY += 2;
    }
    if (_waveY > targetY ) {
        _waveY -= 2;
    }
}

-(void)updateWave1
{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //余弦曲线公式为： y=Acos(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * cos(_wavePalstance * x + _waveX) + _waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _backWaveLayer.path = path;
    _label1.layer.mask = _backWaveLayer;
    CGPathRelease(path);
}

-(void)updateWave2
{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * sin(_wavePalstance * x + _waveX) + _waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //添加终点路径、填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _frontWaveLayer.path = path;
    _label2.layer.mask = _frontWaveLayer;
    CGPathRelease(path);
    
}

#pragma mark -
#pragma mark Setter
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    _label0.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    _label1.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    _label2.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
}

- (void)setTextFont:(UIFont *)textFont {
    _label0.font = textFont;
    _label1.font = textFont;
    _label2.font = textFont;
}

- (void)setWaveBackgroundColor:(UIColor *)waveBackgroundColor {
    self.backgroundColor = waveBackgroundColor;
    _label0.backgroundColor = waveBackgroundColor;
}

- (void)setWaveColor:(UIColor *)waveColor {
    _label0.textColor = waveColor;
    _label1.backgroundColor = waveColor;
    _label2.backgroundColor = waveColor;
}

#pragma mark -
#pragma mark 功能方法

//开始
- (void)start {
    //以屏幕刷新速度为周期刷新曲线的位置
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//停止
- (void)stop {
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}


-(void)dealloc
{
    [self stop];
    if (_backWaveLayer) {
        [_backWaveLayer removeFromSuperlayer];
        _backWaveLayer = nil;
    }
    if (_frontWaveLayer) {
        [_frontWaveLayer removeFromSuperlayer];
        _frontWaveLayer = nil;
    }
    
    if (_label0) {
        [_label0 removeFromSuperview];
        _label0 = nil;
    }
    
    if (_label1) {
        [_label1 removeFromSuperview];
        _label1 = nil;
    }
    
    if (_label2) {
        [_label2 removeFromSuperview];
        _label2 = nil;
    }
}

@end
