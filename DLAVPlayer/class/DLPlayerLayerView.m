//
//  DLPlayerLayerView.m
//  TempPlayer
//
//  Created by 301 on 15/6/19.
//  Copyright (c) 2015年 DouLe. All rights reserved.
//

#import "DLPlayerLayerView.h"
@interface DLPlayerLayerView()
@property (nonatomic, assign) CGRect oldFrame;
@property (nonatomic, assign) BOOL full;
@property (nonatomic, assign) BOOL hasKvo;
@property (nonatomic, weak) UIWindow *tempWindow;
@property (nonatomic, weak) UIView *oldSuperView;//原容器
@property (nonatomic, strong) AVURLAsset *videoInfo;//视频信息
@property (nonatomic, strong) AVPlayer *player;//播放器
@property (nonatomic, strong) AVPlayerLayer *playerLayer;//播放器场景
@property (nonatomic, strong) UIView *backView;
@end

@implementation DLPlayerLayerView
#pragma mark    初始化
-(instancetype)initWithUrl:(NSURL *)url
{
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_BOUNDS_SIZE.width, UISCREEN_BOUNDS_SIZE.width*(180.0/UISCREEN_BOUNDS_SIZE.width))];
    if (self)
    {
        _hasKvo = NO;
        self.videoUrl = url;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_backView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_backView];

        _hasKvo = NO;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andUrl:(NSURL *)url
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _hasKvo = NO;
        self.videoUrl = url;
    }
    return self;
}
#pragma mark    控制器
-(void)createControls
{
    _oldFrame = self.frame;
    _full = NO;
    _controlsView = [[DLPlayerControlsView alloc] init];
    [_controlsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backView addSubview:_controlsView];
    [_backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[_controlsView]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_controlsView)]];
    [_backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_controlsView(==45.0)]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_controlsView)]];
    __weak __typeof(self)weekSelf = self;
    _controlsView.playCallBack = ^(UIButton *sender){
        if (weekSelf.oldSuperView==nil) {
            weekSelf.oldSuperView = weekSelf.superview;
        }
        if (!sender.selected)
        {
            if (weekSelf.player == nil) {
                if (!weekSelf.videoInfo) {
                    weekSelf.videoInfo = [[AVURLAsset alloc] initWithURL:weekSelf.videoUrl options:nil];
                    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:weekSelf.videoInfo];
                    weekSelf.player = [AVPlayer playerWithPlayerItem:playerItem];
                    [weekSelf.playerLayer setPlayer:weekSelf.player];
                    [weekSelf addObServerWithPlayerItme:weekSelf.player.currentItem];
                    [weekSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
                        
                        [weekSelf.controlsView changedProgress:CMTimeGetSeconds(time) andTotal:CMTimeGetSeconds([weekSelf.videoInfo duration])];
                    }];
                }
            }
            [weekSelf.player play];
        }
        else
        {
            [weekSelf.player pause];
        }
        [sender setSelected:!sender.selected];
    };
    _controlsView.fullCallBack = ^(UIButton *sender){
        if (weekSelf.oldSuperView==nil) {
            weekSelf.oldSuperView = weekSelf.superview;
        }
        [sender setSelected: !sender.selected];
        [weekSelf fullScrenn:sender.selected];
    };
    [self setBackgroundColor:[UIColor colorWithWhite:0.436 alpha:1.000]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeEndNotification:) name:AVPlayerItemDidPlayToEndTimeNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemEnterBackGround) name:UIApplicationDidEnterBackgroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LayerOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];//设备方向的通知   暂不支持
}
-(void)pause
{
    [self.player pause];
}
#pragma mark    播放器
-(void)createPlayer
{
    if (_backView == nil)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_backView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_backView];
    }
    if (_playerLayer == nil)
    {
        [self getWindown];
        self.tag = 1010101;
        
        _playerLayer = [[AVPlayerLayer alloc] init];
        [_playerLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_backView.layer addSublayer:_playerLayer];
    }
    else
    {
        if(_hasKvo == YES)
        {
            [self removeObserverWithPlayerItem:_player.currentItem];
        }
        _videoInfo = [[AVURLAsset alloc] initWithURL:_videoUrl options:nil];
        [_player replaceCurrentItemWithPlayerItem:[self getPlayerItemWithUrlAsset:_videoInfo]];
        [self addObServerWithPlayerItme:self.player.currentItem];
        [_playerLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    if (_controlsView == nil)
    {
        [self createControls];
    }
}
-(AVPlayerItem *)getPlayerItemWithUrlAsset:(AVURLAsset *)asset
{
    AVPlayerItem *tempPlayerItem = [AVPlayerItem playerItemWithAsset:asset];
    return tempPlayerItem;
}
#pragma mark    截图
-(void)getThumbnailImageForAsset:(AVURLAsset *)asset
{
    AVAssetImageGenerator *imageTools = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageTools.appliesPreferredTrackTransform = TRUE;
//    CMTime thumbnailTime = CMTimeMakeWithSeconds(1, 15);
    CMTime thumbnailTime = CMTimeMake(1, 2);
    /*CMTimeMake(a,b)    a当前第几帧, b每秒钟多少帧.当前播放时间a/b
     CMTimeMakeWithSeconds(a,b)    a当前时间,b每秒钟多少帧*/
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result == AVAssetImageGeneratorSucceeded) {
//            UIImage *tempimage = [UIImage imageWithCGImage:image];//截图
        }
    };
    imageTools.maximumSize = self.frame.size;
    [imageTools generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbnailTime]] completionHandler:handler];
}
#pragma mark    视频地址
-(void)setVideoUrl:(NSURL *)videoUrl
{
    _videoUrl = videoUrl;
    [self createPlayer];
}
#pragma mark    相关监听
-(void)addObServerWithPlayerItme:(AVPlayerItem *)tempItem
{
    [tempItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [tempItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    _hasKvo = YES;
}
-(void)removeObserverWithPlayerItem:(AVPlayerItem *)tempItem
{
    [tempItem removeObserver:self forKeyPath:@"status"];
    [tempItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    _hasKvo = NO;
}
#pragma mark    监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            DLLog(@"正在播放...，视频总长度:%f",CMTimeGetSeconds(playerItem.duration));
            [_controlsView setCanFull:YES];
            __block CGFloat total = CMTimeGetSeconds(playerItem.duration);
            _controlsView.totalTime = ^()
            {
                return total;
            };
//            [self getThumbnailImageForAsset:_videoInfo];//截图
            NSArray *array = [_videoInfo tracksWithMediaType:AVMediaTypeVideo];
            if (array.count>0)
            {
                AVAssetTrack *track = [array objectAtIndex:0];
                _movieSize = [track naturalSize];
                if (!_full)
                {
//                    [self.player seekToTime:CMTimeMakeWithSeconds(1,2)];//指定播放时间
                    [self frameChangedisTransForm:NO newFrame:CGRectZero];
                }
            }
        }
        else if (status == AVPlayerStatusFailed)
        {
            DLLog(@"加载失败");
            if (_hasKvo == YES)
            {
                [self removeObserverWithPlayerItem:self.player.currentItem];
            }
            [_controlsView videoLoadError];
            [_controlsView setCanFull:NO];
        }
        [_controlsView performSelector:@selector(showOrhiddenWithDuration:) withObject:@(1) afterDelay:6];
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        DLLog(@"共缓冲：%.2f",totalBuffer);
        if (totalBuffer > 30)
        {
            
        }
    }
    
}
-(void)frameChangedisTransForm:(BOOL)transform newFrame:(CGRect)newFrame
{
    CGSize screenSize = self.frame.size;
    if (transform)
    {
        screenSize = newFrame.size;
    }
//    CGRect tempFrame = [self getNewFrameWithscreenSize:screenSize];
    [_playerLayer setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    if (!transform) {
        [_playerLayer setBackgroundColor:[UIColor grayColor].CGColor];
    }else{
        [_playerLayer setBackgroundColor:[UIColor blackColor].CGColor];
    }
}
-(CGRect)getNewFrameWithscreenSize:(CGSize)screenSize
{
    CGFloat widthScale = _movieSize.width/screenSize.width;
    CGFloat heightScale = _movieSize.height/screenSize.height;
    CGFloat scaleP = _movieSize.width/_movieSize.height;
    CGRect tempFrame;
    if (widthScale>heightScale)
    {
        CGFloat playerW = screenSize.width;
        CGFloat playerH = playerW/scaleP;
        tempFrame = CGRectMake((screenSize.width - playerW)/2.0, (screenSize.height - playerH)/2.0, playerW, playerH);
    }
    else
    {
        CGFloat playerH = screenSize.height;
        CGFloat playerW = playerH*scaleP;
        tempFrame = CGRectMake((screenSize.width - playerW)/2.0, (screenSize.height - playerH)/2.0, playerW, playerH);
    }
    return tempFrame;
}
-(void)fullScrenn:(BOOL)isFull
{
    if (isFull)
    {
        [self removeFromSuperview];
        [_tempWindow addSubview:self];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        CGFloat height = [[UIScreen mainScreen] bounds].size.width;
        CGFloat width = [[UIScreen mainScreen] bounds].size.height;
        CGRect newFrame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);
        [UIView animateWithDuration:0.3f animations:^{
            self.frame = newFrame;
            [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
            [self frameChangedisTransForm:YES newFrame:newFrame];
            _backView.frame = CGRectMake(0, 0, width, height);
        } completion:^(BOOL finished) {
            _full = YES;
        }];
    }
    else
    {
        if (_full)
        {
            [self removeFromSuperview];
            [_oldSuperView addSubview:self];
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
            [UIView animateWithDuration:0.3f animations:^{
                [self setTransform:CGAffineTransformIdentity];
                self.frame = _oldFrame;
                [self frameChangedisTransForm:NO newFrame:CGRectZero];
                _backView.frame = CGRectMake(0, 0, _oldFrame.size.width, _oldFrame.size.height);
            } completion:^(BOOL finished) {
                _full = NO;
            }];
        }
    }
}
#pragma mark    播放结束
-(void)timeEndNotification:(NSNotification *)sender
{
    DLLog(@"播放完成");
    [self.player seekToTime:CMTimeMake(1.0, 1.0)];
    _controlsView.playFinish = ^()
    {
        return YES;
    };
}
-(void)systemEnterBackGround
{
    [_controlsView.playBtn setSelected:NO];
}
-(void)LayerOrientation:(NSNotification *)info
{
    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    switch (orient)
    
    {
        case UIDeviceOrientationPortrait:{
            DLLog(@"UIDeviceOrientationPortrait");
//            [self setFrame:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height)];
        }
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            DLLog(@"UIDeviceOrientationLandscapeLeft");
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            DLLog(@"UIDeviceOrientationPortraitUpsideDown");
            break;
            
        case UIDeviceOrientationLandscapeRight:
            DLLog(@"UIDeviceOrientationLandscapeRight");
            break;
            
        default:
            
            break;
            
    }
//    [self setFrame:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height)];
//    [_playerLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *tempTouch = [touches anyObject];
    CGPoint tempPoint = [tempTouch locationInView:self];
    if (((tempPoint.y<_controlsView.frame.origin.y)||(tempPoint.y>_controlsView.frame.origin.y+_controlsView.frame.size.height)))
    {
        [self tapAction];
    }
}
-(void)getWindown
{
    _tempWindow = [[UIApplication sharedApplication] keyWindow];
    if (!_tempWindow) {
        _tempWindow = [[[UIApplication sharedApplication] windows] firstObject];
    }
    _oldSuperView = self.superview;
}
-(void)tapAction
{
    [_controlsView showOrhiddenWithDuration:1];
}
-(void)dealloc
{
    DLLog(@"%@  %@   Retain count is %ld", NSStringFromClass([self class]),NSStringFromSelector(_cmd),CFGetRetainCount((__bridge CFTypeRef)self));
    [self removeObserverWithPlayerItem:self.player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
