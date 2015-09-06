//
//  DLPlayerControlsView.h
//  TempPlayer
//
//  Created by 301 on 15/6/19.
//  Copyright (c) 2015年 DouLe. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  播放器控制器视图
 */
@interface DLPlayerControlsView : UIView
@property (nonatomic, strong) UIButton *playBtn;//播放按钮
/**
 *  播放按钮事件
 */
@property (nonatomic, copy) void(^playCallBack)(UIButton *sender);
/**
 *  全屏按钮事件
 */
@property (nonatomic, copy) void(^fullCallBack)(UIButton *sender);
/**
 *  播放完成
 */
@property (nonatomic, copy) BOOL(^playFinish)(void);
/**
 *  视频总时长
 */
@property (nonatomic, copy) CGFloat(^totalTime)(void);
/**
 *  控制tools是否自动隐藏(默认YES)
 */
@property (nonatomic, assign) BOOL disappear;
/**
 *  是否能够全屏
 */
@property (nonatomic, assign) BOOL canFull;
/**
 *  控制器展示或隐藏
 *
 *  @param duration 动画持续时间
 */
-(void)showOrhiddenWithDuration:(NSTimeInterval)duration;
/**
 *  进度条改变
 *
 *  @param current 当前事件
 *  @param total   总时间
 */
-(void)changedProgress:(float)current andTotal:(float)total;
/**
 *  加载失败
 */
-(void)videoLoadError;
@end
