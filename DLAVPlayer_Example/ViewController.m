//
//  ViewController.m
//  DLAVPlayer_Example
//
//  Created by Xa_sanLingYI on 15/7/17.
//  Copyright (c) 2015年 Xa_sanLingYI. All rights reserved.
//

#import "ViewController.h"
#import "DLAVPlayer.h"
@interface ViewController ()
{
    DLPlayerLayerView *dlPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dlPlayer = [[DLPlayerLayerView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [dlPlayer setVideoUrl:[NSURL URLWithString:TestMovieUrl]];
    [self.view addSubview:dlPlayer];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
