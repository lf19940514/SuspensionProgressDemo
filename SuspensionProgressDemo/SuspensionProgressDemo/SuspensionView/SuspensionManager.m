//
//  SuspensionManager.m
//  SuspensionProgressDemo
//
//  Created by souge 3 on 2019/4/3.
//  Copyright © 2019 LiuFei. All rights reserved.
//

#import "SuspensionManager.h"
#import "SuspensionView.h"

static SuspensionManager *sharedSuspensionManager = nil;

@interface SuspensionManager()
/** 悬浮球*/
@property (nonatomic , strong) SuspensionView *susGlobe;

@end

@implementation SuspensionManager

+ (SuspensionManager *)sharedSuspensionViewManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSuspensionManager = [[SuspensionManager alloc] init];
    });
    return sharedSuspensionManager;
}

- (SuspensionView *)susGlobe {
    if (!_susGlobe) {
        _susGlobe = [[SuspensionView alloc] initWithFrame:CGRectMake(0, 100, 60, 60)];
        
    }
    return _susGlobe;
}

- (void)createSuspensionView {
    [self.susGlobe show];
}

- (void)removeSuspensionView {
    [self.susGlobe removeFromSuperview];
    self.susGlobe = nil;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.susGlobe.progress = progress;
}

@end
