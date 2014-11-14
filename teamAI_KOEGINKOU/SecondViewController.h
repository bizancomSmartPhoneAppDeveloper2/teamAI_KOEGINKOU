//
//  SecondViewController.h
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface SecondViewController : UIViewController
- (IBAction)rokuonStart:(UIButton *)sender;
- (IBAction)rokuonListen:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *rokuonStartStopImage;
@property (weak, nonatomic) IBOutlet UIButton *kuwokakunin;
- (IBAction)yarinaosuButton:(UIButton *)sender;

@end

