//
//  DLAVPlayer.h
//  TempPlayer
//
//  Created by 301 on 15/6/19.
//  Copyright (c) 2015年 DouLe. All rights reserved.
//

#ifndef TempPlayer_DLAVPlayer_h
#define TempPlayer_DLAVPlayer_h

#define DLCOLORRGBA(R,G,B,A)   [UIColor colorWithRed:(R*1.0)/255.0 green:(G*1.0)/255.0 blue:(B*1.0)/255.0 alpha:A*1.0]

#if DEBUG
#define DLLog(...) NSLog(__VA_ARGS__)
#else
#define DLLog(...)
#endif

#import "DLPlayerControlsView.h"
#import "DLPlayerLayerView.h"

/*!
 说明:
    该播放器使用的是AVFoundation框架中的AVPlayer，所以需要使用的请在项目中加入AVFoundation框架
    谨记该播放器不可重复利用(原因正在查找)
    在全屏状态下在偏好文件中增加 key： View controller-based status bar appearance  value: NO
 
    在线资源来自(http://www.mm123m.com (车载MV))地址有效期很短，倘若无法使用，请自行前往该网站获取资源地址
    在线资源来自盛大音乐(http://www.sdyinyue.net/ )地址长期有效，跟多资源请自行获取
    在线资源来自酷我音乐(http://www.kuwo.cn/ )地址长期有效，跟多资源请自行获取
 */
//#error 偏好文件中增加(info.plist) key： View controller-based status bar appearance  value: NO
#define TestMovieUrl    @"http://win.web.rh03.sycdn.kuwo.cn/25b70796611b748c85985f88fe433bef/5670f9fc/resource/m3/0/23/139088051.mp4"     //(酷我音乐)(《先生有事吗?MV》 - 蔡健雅)
//#define TestMovieUrl    @"http://112.253.22.159/19/l/z/i/m/lzimrevxjftgcmsiuuvvyvpmnumlac/hc.yinyuetai.com/3B20014E4D75277C572E9C130CB14D4E.flv?sc=1c61ee1c54da5076"     //(音悦台)(**---***)
//#define TestMovieUrl    @"<#视频地址#>"     //(<#视频来源#>)(<#作者#>---<#曲目#>)
#define UISCREEN_BOUNDS_SIZE      [UIScreen mainScreen].bounds.size // 屏幕的物理尺寸
#endif