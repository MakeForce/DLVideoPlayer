//
//  Test1ViewController.m
//  DLAVPlayer_Example
//
//  Created by Xa_sanLingYI on 15/9/6.
//  Copyright (c) 2015年 Xa_sanLingYI. All rights reserved.
//

#import "Test1ViewController.h"
#import "DLAVPlayer.h"
@interface Test1ViewController ()
{
    DLPlayerLayerView *dlPlayer;
}
@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dlPlayer = [[DLPlayerLayerView alloc] initWithFrame:CGRectMake(0, 64, 320, 180)];
    [dlPlayer setVideoUrl:[NSURL URLWithString:TestMovieUrl]];
    [self.view addSubview:dlPlayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
