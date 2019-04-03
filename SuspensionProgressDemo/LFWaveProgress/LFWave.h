//
//  LFWave.h
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFWave : UIView

/**
 设置进度 0~1
 */
@property (assign,nonatomic) CGFloat progress;
/**
 文字字体
 */
@property (nonatomic ,strong) UIFont *textFont;
/**
 波浪背景色
 */
@property (nonatomic ,strong) UIColor *waveBackgroundColor;
/**
 波浪颜色
 */
@property (nonatomic ,strong) UIColor *waveColor;

/**
 开始
 */
- (void)start;

/**
 停止
 */
-(void)stop;


@end

NS_ASSUME_NONNULL_END
