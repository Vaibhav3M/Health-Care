//
//  VideosViewController.m
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import "VideosViewController.h"

@import AVKit;
@import AVFoundation;

@interface VideosViewController ()

@property(nonatomic, readonly) AVPlayerItem *currentItem;


@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    _videoPlay = [NSArray arrayWithObjects:@"Video1",@"Video2",@"Video3",@"Video4", nil];
    
    NSURL *videoURL = [[NSBundle mainBundle]URLForResource:_videoName withExtension:@"MOV"];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    
    
    // create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [player play];
    
    
    //    self.AVPlayerViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //    [self presentViewController:self.AVPlayerViewController animated:YES completion:nil];
    
    
    // show the view controller
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    controller.view.frame=CGRectMake(0, 65,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width*9/16);
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:_currentItem];
    
    
}



-(void)playerItemDidReachEnd:(NSNotification *) notification {
    
    self.isPresented = NO; // Set this flag to NO before dismissing controller, so that correct orientation will be chosen for the bottom controller
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
