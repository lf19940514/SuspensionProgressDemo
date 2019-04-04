//
//  SuspensionManager.h
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionManager : NSObject

//初始化
+ (SuspensionManager *)sharedSuspensionViewManager;

//添加悬浮球
- (void)createSuspensionView;

//移除悬浮球
- (void)removeSuspensionView;

/**
 进度 0~1
 */
@property (nonatomic ,assign) CGFloat progress;

//点击悬浮球回调
@property (nonatomic, copy) void (^suspensionClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
