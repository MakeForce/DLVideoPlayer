//
//  DLPlayerControlsView.m
//  TempPlayer
//
//  Created by 301 on 15/6/19.
//  Copyright (c) 2015年 DouLe. All rights reserved.
//

#import "DLPlayerControlsView.h"
#import "DLAVPlayer.h"
@interface DLPlayerControlsView()
{
    BOOL isAnimation;
}

@property (nonatomic, strong) UIButton *fullBtn;//全屏按钮
@property (nonatomic, strong) UILabel *currentTimerLabel;//当前播放时间
@property (nonatomic, strong) __block UILabel *durationLabel;//总时间
@property (nonatomic, strong) UIProgressView *slider;//进度条
@end


@implementation DLPlayerControlsView
#pragma mark    初始化
-(instancetype)initWithPlayerView:(UIView *)playerView
{
    self = [super init];
    if (self)
    {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setBackgroundColor:DLCOLORRGBA(238, 239, 241, 0.5)];
        
        isAnimation = NO;
        _canFull = YES;
        _disappear = YES;
        [playerView addSubview:self];
        [playerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[self]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        [playerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(==45.0)]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_playBtn setImage:[UIImage imageNamed:@"DLAVPlayer.bundle/DLPlayer_play_btn"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"DLAVPlayer.bundle/DLPlayer_pause_btn"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(playAndPause:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playBtn];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[_playBtn(==45)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_playBtn)]];
        
        _currentTimerLabel = [[UILabel alloc] init];
        [_currentTimerLabel setFont:[UIFont systemFontOfSize:12.0]];
        _currentTimerLabel.text = @"--:--";
        [_currentTimerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_currentTimerLabel];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(14.5)-[_currentTimerLabel(==16)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_currentTimerLabel)]];
        
        _slider  = [[UIProgressView alloc] init];
        _slider.trackTintColor = [UIColor blackColor];
        _slider.progressTintColor = [UIColor whiteColor];
        [_slider setProgress:0];
        [_slider setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_slider];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(21.5)-[_slider]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_slider)]];
        
        _durationLabel = [[UILabel alloc] init];
        [_durationLabel setFont:[UIFont systemFontOfSize:12.0]];
        _durationLabel.text = @"--:--";
        [_durationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_durationLabel];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(14.5)-[_durationLabel(==16)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_durationLabel)]];
        
        _fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_fullBtn setImage:[UIImage imageNamed:@"DLAVPlayer.bundle/DLPlayer_Full_Btn"] forState:UIControlStateNormal];
        [_fullBtn setImage:[UIImage imageNamed:@"DLAVPlayer.bundle/DLPlayer_non_Full_Btn"] forState:UIControlStateSelected];
        [_fullBtn addTarget:self action:@selector(fullScreen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fullBtn];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[_playBtn(==40)]-(15)-[_currentTimerLabel]-(5)-[_slider]-(5)-[_durationLabel]-(15)-[_fullBtn(==40)]-(10)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_playBtn,_currentTimerLabel,_slider,_durationLabel,_fullBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[_fullBtn(==45)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_fullBtn)]];
        
    }
    return self;
}
-(void)setPlayFinish:(BOOL (^)(void))playFinish
{
    _playFinish = playFinish;
    if (_playFinish) {
        BOOL block =  _playFinish();
        if (block)
        {
            [_slider setProgress:0];
            [_playBtn setSelected:NO];
        }
    }
}
-(void)setTotalTime:(CGFloat(^)(void))totalTime
{
    _totalTime = totalTime;
    if (_totalTime)
    {
        if (_totalTime())
        {
            _durationLabel.text = [self floatToDateString:_totalTime()];
        }
    }
}
-(void)setCanFull:(BOOL)canFull
{
    _canFull = canFull;
    [_fullBtn setUserInteractionEnabled:canFull];
}
#pragma mark    按钮的事件
-(void)playAndPause:(UIButton *)sender
{
    if (self.playCallBack != nil)
    {
        self.playCallBack(sender);
    }
}
-(void)fullScreen:(UIButton *)sender
{
    if (self.fullCallBack != nil)
    {
        self.fullCallBack(sender);
    }
}
#pragma mark    展示或隐藏
-(void)showOrhiddenWithDuration:(NSTimeInterval)duration
{
    if (!isAnimation)
    {
        if (self.hidden)
        {
            isAnimation = YES;
            [UIView animateWithDuration:duration animations:^{
                self.alpha = 1;
            } completion:^(BOOL finished) {
                isAnimation = NO;
                self.hidden = NO;
                if (self.disappear)
                {
                    [self performSelector:@selector(showOrhiddenWithDuration:) withObject:@(2.0) afterDelay:5.0];
                }
            }];
        }
        else
        {
            isAnimation = YES;
            [UIView animateWithDuration:duration animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                isAnimation = NO;
                self.hidden = YES;
            }];
        }
    }
}
-(void)changedProgress:(float)current andTotal:(float)total
{
    _currentTimerLabel.text = [self floatToDateString:current];
    if ((current>=0)&&(total != 0)) {
        
        [_slider setProgress:(current/total) animated:YES];
    }
}
-(NSString *)floatToDateString:(CGFloat)string
{
    long int time = lround(string);
    long int minutes = time/60;
    long int seconds = time % 60;
//    DLLog(@"%.2ld mins  %.2ld",minutes,seconds);
    return [NSString stringWithFormat:@"%.2ld:%.2ld",minutes,seconds];
}
-(void)videoLoadError
{
    _currentTimerLabel.text = @"--:--";
    _durationLabel.text = @"--:--";
}
@end
