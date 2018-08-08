//
//  ViewController.m
//  AudioPlayerDemo
//
//  Created by Kai Liu on 2018/8/6.
//  Copyright © 2018年 Kai Liu. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioPlayerDelegate>

/** 近距离播放器 */
@property (nonatomic, strong) AVAudioPlayer *nearPlayer;
/** 远距离播放器 */
@property (nonatomic, strong) AVAudioPlayer *farPlayer;
/** 正确|分享播放器 */
@property (nonatomic, strong) AVAudioPlayer *correctPlayer;
/** 错误播放器 */
@property (nonatomic, strong) AVAudioPlayer *failurePlayer;
/** 触发播放器 */
@property (nonatomic, strong) AVAudioPlayer *triggerPlayer;
/** 记录之前距离的播放状态 YES-近距离 NO- 远距离 */
@property (nonatomic, assign) BOOL isNearPlaying;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (AVAudioPlayer *)nearPlayer
{
    if (_nearPlayer == nil) {
        _nearPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/LK/Desktop/AudioPlayerDemo/AudioPlayerDemo/audio/近距离.wav"] error:nil];
        _nearPlayer.numberOfLoops = -1; // 循环播放
    }
    return _nearPlayer;
}
// 近距离
- (IBAction)nearClick:(id)sender {
    
    // 如果远距离正在响 停止
    if (self.farPlayer.isPlaying) {
        [self.farPlayer stop];
    }
    
    [self.nearPlayer play];
}
- (AVAudioPlayer *)farPlayer
{
    if (_farPlayer == nil) {
        _farPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/LK/Desktop/AudioPlayerDemo/AudioPlayerDemo/audio/远距离.wav"] error:nil];
        _farPlayer.numberOfLoops = -1; // 循环播放
    }
    return _farPlayer;
}
// 远距离
- (IBAction)farClick:(id)sender {
    
    // 如果近距离正在响 停止
    if (self.nearPlayer.isPlaying) {
        [self.nearPlayer stop];
    }
    
    [self.farPlayer play];
}
- (AVAudioPlayer *)failurePlayer
{
    if (_failurePlayer == nil) {
        _failurePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/LK/Desktop/AudioPlayerDemo/AudioPlayerDemo/audio/答题失败.wav"] error:nil];
        _failurePlayer.delegate = self;
    }
    return _failurePlayer;
}
// 错误
- (IBAction)failureClick:(id)sender {
    
    [self recordPlaybackStatus];
    
    [self.failurePlayer play];
}
- (AVAudioPlayer *)correctPlayer
{
    if (_correctPlayer == nil) {
        _correctPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/LK/Desktop/AudioPlayerDemo/AudioPlayerDemo/audio/答题正确|分享.wav"] error:nil];
        _correctPlayer.delegate = self;
    }
    return _correctPlayer;
}
// 正确|分享
- (IBAction)correctClick:(id)sender {
    
    [self recordPlaybackStatus];
    
    [self.correctPlayer play];
}
- (AVAudioPlayer *)triggerPlayer
{
    if (_triggerPlayer == nil) {
        _triggerPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/LK/Desktop/AudioPlayerDemo/AudioPlayerDemo/audio/触发音效.wav"] error:nil];
        _triggerPlayer.delegate = self;
    }
    return _triggerPlayer;
}
// 触发
- (IBAction)triggerClick:(id)sender {
    
    [self recordPlaybackStatus];
    
    [self.triggerPlayer play];
}

- (void)recordPlaybackStatus
{
    // 停下并记录之前播放的近远距离 然后在播放完成后继续播放
    if (self.farPlayer.isPlaying)
    {
        [self.farPlayer pause];
        self.isNearPlaying = NO;
    }
    if (self.nearPlayer.isPlaying)
    {
        [self.nearPlayer pause];
        self.isNearPlaying = YES;
    }
}

- (IBAction)startClick:(id)sender
{
    [self farClick:nil];
}

#pragma mark - AVAudioPlayerDelegate
//音频播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (self.isNearPlaying) {
        [self.nearPlayer play];
    } else {
        [self.farPlayer play];
    }
}
@end
