//
//  SecondViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DCAnimation.h"


@interface SecondViewController ()

@end

@implementation SecondViewController{
    AVAudioRecorder *avRecorder;
    AVAudioSession *audioSession;
    AVAudioPlayer *avPlayer;
    BOOL rokuonStarting;
    NSInteger number;
    NSString *userNameString;
    NSString *path;
    NSInteger tsurugisan_number;
    NSInteger bizan_number;
    NSInteger now_number;
    NSMutableArray *inRejon;
    NSMutableArray *buttonTitleArray;
    NSTimer *timer;
}


- (void)viewDidLoad {
    [self plaYikku];
    rokuonStarting = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.rokuonStartStopImage.alpha = 0.3;
    //self.kuwokakunin.alpha = 0.3;
    number = 0;
    
    //録音したボタンを最初の段階で隠している。
    self.kuwokakunin.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rokuonStart:(UIButton *)sender
{
    
    //録音状態でないかどうか
        if (rokuonStarting == NO)
        {
            self.rokuonStartStopImage.alpha = 0.3;
            audioSession = [AVAudioSession sharedInstance];
            NSError *error = nil;
            // 使用している機種が録音に対応しているか
            if (audioSession.inputAvailable) {
                [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
            }
            if(error){
            NSLog(@"audioSession: %@ %ld %@", [error domain], [error code], [[error userInfo] description]);
            }
            // 録音機能をアクティブにする
            [audioSession setActive:YES error:&error];
            if(error){
                NSLog(@"audioSession: %@ %ld %@", [error domain], [error code], [[error userInfo] description]);
            }
        
            // 録音ファイルパス
            NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,YES);
            NSString *documentDir = [filePaths objectAtIndex:0];
            //wavファイルとして保存する
            path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
            NSURL *recordingURL = [NSURL fileURLWithPath:path];
            NSDictionary *dic;
            //AVEncoderAudioQualityKey オーディオ品質を設定するキー?
            //AVEncoderBitRateKey オーディオビットレートを設定するキー?
            //AVSampleRateKey 周波数(ヘルツ)を設定するキー?(このキーの値が小さいほどデータのサイズは小さくなる?)
            //AVNumberOfChannelsKey　チャネルの数を設定するキー?
            dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
               [NSNumber numberWithInt:16],
               AVEncoderBitRateKey,
               [NSNumber numberWithInt: 1],
               AVNumberOfChannelsKey,
               [NSNumber numberWithFloat:100.0],//fileのデータサイズ設定
               AVSampleRateKey,
               nil];
            avRecorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:dic error:&error];
        
            if(error){
                NSLog(@"patherror = %@",error);
                return;
            }
            //録音開始
            [avRecorder record];
            rokuonStarting = YES;
        }
        //録音状態であるかどうか
        else if(rokuonStarting == YES)
        {
            self.rokuonStartStopImage.alpha = 0.3;
        
            [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常に録音が完了しました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil]show];
        
        
            //録音をやめる
            [avRecorder stop];
            rokuonStarting = NO;
            NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,YES);
            NSString *documentDir = [filePaths objectAtIndex:0];
            path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
            
            
            self.kuwokakunin.hidden = NO;
            [self listenYikku];

    }
    
}




- (IBAction)rokuonListen:(UIButton *)sender {
    if(avPlayer.playing == NO){
        //self.kuwokakunin.alpha = 1;

    audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    //rec.wavファイルがあるパスの文字列を格納
    path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:recordingURL error:nil];
    avPlayer.volume=1.0;
    //再生
    [avPlayer play];
    }

}

-(void)plaYikku
{
    DCAnimation *dcAnimation = [[DCAnimation alloc] init];
    dcAnimation.dc_delegate = (id)self;
    //アニメーション秒数と目標スケール値を指定
    [dcAnimation scale:self.rokuonStartStopImage
              duration:1.5f
              aimScale:2.0f];
    
}

-(void)listenYikku
{
    DCAnimation *dcAnimation = [[DCAnimation alloc] init];
    dcAnimation.dc_delegate = (id)self;
    //アニメーション秒数と目標スケール値を指定
    [dcAnimation scale:self.kuwokakunin
              duration:1.5f
              aimScale:2.0f];
    
}

- (IBAction)remindIkku:(id)sender
{
   
    [self performSegueWithIdentifier:@"NextToukouView" sender:self];
}




@end
