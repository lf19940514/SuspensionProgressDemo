//
//  SuspensionView.h
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionView : UIView

- (void)show;

/**
 进度 0~1
 */
@property (nonatomic ,assign) CGFloat progress;

//点击悬浮球回调
@property (nonatomic, copy) void (^suspensionClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
