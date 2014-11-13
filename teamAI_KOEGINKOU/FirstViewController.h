//
//  FirstViewController.h
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "SecondViewController.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"



@interface FirstViewController : UIViewController<CLLocationManagerDelegate,MKAnnotation,MKMapViewDelegate>

@property CLLocationManager *locationManager;
//緯度、経度の情報を格納するための変数
@property(nonatomic)CLLocationCoordinate2D coordinate;
//タイトルを持つ変数
@property(nonatomic,copy)NSString *title;
//サブタイトルを持つ変数
@property(nonatomic,copy)NSString *subtitle;
//初期化用のメソッド
//マップの変数
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *rejonLabel;
@property (weak, nonatomic) IBOutlet UIView *StartUpUIView;
@property (weak, nonatomic) IBOutlet UIImageView *StartUpUIImages;

//-(void)checkFirstStartUp;
-(IBAction)closeStartUpView;



@end



