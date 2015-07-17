//
//  DLPlayerLayerView.h
//  TempPlayer
//
//  Created by 301 on 15/6/19.
//  Copyright (c) 2015年 DouLe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DLAVPlayer.h"
/**
 *  播放器视图
 */
@interface DLPlayerLayerView : UIView
@property (nonatomic, readonly) NSTimeInterval currentTime;//当前播放时间
@property (nonatomic, readonly) NSTimeInterval durationTime;//总时长
@property (nonatomic, readonly) CGSize movieSize;//视频尺寸
//@property (nonatomic, strong) __block UIImage *videoThumbnailImage;//暂未处理

/**
 *  控制器
 */
@property (nonatomic, strong) DLPlayerControlsView *controlsView;
/**
 *  视频地址
 */
@property (nonatomic, strong) NSURL *videoUrl;

/**
 *  根据视频来源初始化播放器
 *
 *  @param url 视频源
 *
 *  @return 播放器对象
 */
-(instancetype)initWithUrl:(NSURL *)url;
/**
 *  给定视频源及大小初始化
 *
 *  @param frame 播放器大小
 *  @param url   视频源
 *
 *  @return 播放器对象
 */
-(instancetype)initWithFrame:(CGRect)frame andUrl:(NSURL *)url;
/**
 *  暂停
 */
-(void)pause;
@end
