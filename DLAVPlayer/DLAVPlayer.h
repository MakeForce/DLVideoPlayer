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


//#define TestMovieUrl    @"http://123.138.43.6/storagemv.wcdn.kugou.com/M01/07/00/dhr1TVEi8JC0H6AmAQIgmGua7Qg867.mp4" //(盛大音乐)男人有泪 - 萧煌奇
//#define TestMovieUrl    @"http://123.138.43.6/storagemv2.wcdn.kugou.com/M06/19/D3/CgEy51N0XvG_QDWaAMZRAg96L_4661.mp4"    //(盛大音乐)韩国  *****
//#define TestMovieUrl    @"http://123.138.43.5/storagemv.wcdn.kugou.com/M01/0F/D9/dhr1TVGEoreAA9gAAQBylCVaqU8836.mp4"     //(盛大音乐)(王麟---自由,不是理由)
#define TestMovieUrl    @"http://123.138.43.5/storagemv2.wcdn.kugou.com/M05/07/EF/dhr1T1HKUiu3PHsJAQ34BXlGnuI918.mp4"     //(盛大音乐)(庄心妍---为情所伤)
//#define TestMovieUrl    @"http://123.138.43.5/storagemv2.wcdn.kugou.com/M03/1B/2B/CgEy51OYASSOq35pAQDw-IUR40g980.mp4"     //(盛大音乐)(凤凰传奇---自由自在)
//#define TestMovieUrl    @"http://rf03.sycdn.kuwo.cn/72a38e8be67e554ebdd7528b2a45c66e/558ce157/resource/m3/69/26/2854400793.mp4"     //(酷我音乐)(赖雅妍---脸)
//#define TestMovieUrl    @"http://re03.sycdn.kuwo.cn/572c8519a639133483729378ce714c8c/558ce252/resource/m1/69/10/780659175.mp4"     //(酷我音乐)(白安---若你真的有想过MV)
//#define TestMovieUrl    @"http://re03.sycdn.kuwo.cn/8a0b0badb9d855c91cb8af49497c367e/558ce29f/resource/m1/90/65/2554068859.mp4"     //(酷我音乐)(玖月奇迹---盛开)
//#define TestMovieUrl    @"http://rd03.sycdn.kuwo.cn/a16ed6a12cc4b40e00c5b2ac29ba8126/558ce30a/resource/m2/5/84/392474867.mp4"     //(酷我音乐)(Lady GaGa---Born This Way)
//#define TestMovieUrl    @"http://rc03.sycdn.kuwo.cn/109bdda3fd015e1d23bef1d75293395b/558ce365/resource/m3/58/90/4198482872.mp4"     //(酷我音乐)(T-ara---一如当初)
//#define TestMovieUrl    @"http://rd03.sycdn.kuwo.cn/84af5f01b76a9a960ae9fe60e85fad58/558ce3c4/resource/m1/8/47/273400713.mp4"     //(酷我音乐)(陈妍希---悬崖上的玫瑰)
//#define TestMovieUrl    @"http://re03.sycdn.kuwo.cn/7ad2afd346afafa51db500527c49e8cc/558ce422/resource/m2/50/66/1487606763.mp4"     //(酷我音乐)(周子琰---The World Is Love)
//#define TestMovieUrl    @"http://112.253.22.159/19/l/z/i/m/lzimrevxjftgcmsiuuvvyvpmnumlac/hc.yinyuetai.com/3B20014E4D75277C572E9C130CB14D4E.flv?sc=1c61ee1c54da5076"     //(音悦台)(**---***)
//#define TestMovieUrl    @"<#视频地址#>"     //(<#视频来源#>)(<#作者#>---<#曲目#>)
#define UISCREEN_BOUNDS_SIZE      [UIScreen mainScreen].bounds.size // 屏幕的物理尺寸
#endif