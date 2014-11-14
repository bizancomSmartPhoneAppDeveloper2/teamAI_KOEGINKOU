//
//  FirstViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "FirstViewController.h"
#import "CustomAnnotation.h"
#import "tokushimajoukouenViewController.h"
#import "AppDelegate.h"
#import "bizanViewController.h"
#import "bunkanomoriViewController.h"

@interface FirstViewController ()
@end

@implementation FirstViewController
{
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    CLLocationCoordinate2D co;
    CLLocationCoordinate2D coTokushimajoukouen;
    CLLocationCoordinate2D coBizan;
    CLLocationCoordinate2D coBunkanomori;


    MKCircle *circleTokushimaeki;
    MKCircle *circleBizan;
    MKCircle *circleTsurugisan;
    MKCoordinateRegion regionMap;
    CLRegion *grRegionTokushimaeki;
    CLRegion *grRegionBizan;
    CLRegion *grRegionTsurugisan;
    NSMutableArray *inRejon;
    NSString *nsstringInRejon;
    
    UIView *_StartUpUIView;//説明文を書く
    NSArray *DescImage;
    int ID;
}

@synthesize locationManager;
@synthesize StartUpUIView;



-(void)viewWillAppear:(BOOL)animated
{
   //[self checkFirstStartUp];
    [super viewWillAppear:animated];
    
    
    
}




- (void)viewDidLoad {
    [self newAnnotation];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    latitude = 0;
    longitude = 0;
    [self.map setDelegate:self];
    [self locationManagerMethod];
    [self.locationManager startMonitoringForRegion:grRegionTokushimaeki];
    [self.locationManager startMonitoringForRegion:grRegionBizan];
    [self.locationManager startMonitoringForRegion:grRegionTsurugisan];
    
    
    //配列を空で生成
    inRejon = [NSMutableArray array];
    
    // 200mの範囲円を追加
    circleTokushimaeki = [MKCircle circleWithCenterCoordinate:coTokushimajoukouen radius: 2000.0];
    circleBizan =        [MKCircle circleWithCenterCoordinate:coBizan             radius: 2000.0];
    circleTsurugisan =   [MKCircle circleWithCenterCoordinate:coBunkanomori       radius: 2000.0];
    //[self getObject];
    //[self defaultMapSettei];
    CLLocationDistance radiusOnMeter = 2000.0;
    
    grRegionTokushimaeki = [[CLCircularRegion alloc] initWithCenter:coTokushimajoukouen radius:radiusOnMeter identifier:@"徳島城公園:吟行地"];
    [self.locationManager startMonitoringForRegion:grRegionTokushimaeki];
    
    grRegionBizan = [[CLCircularRegion alloc] initWithCenter:coBizan radius:radiusOnMeter identifier:@"眉山:吟行地"];
    [self.locationManager startMonitoringForRegion:grRegionBizan];
    
    grRegionTsurugisan = [[CLCircularRegion alloc] initWithCenter:coBunkanomori radius:radiusOnMeter identifier:@"文化の森:吟行地"];
    [self.locationManager startMonitoringForRegion:grRegionTsurugisan];
    
    self.rejonLabel.numberOfLines = 4;
    self.rejonLabel.hidden = YES;
    
    
    //説明の画面表示
    ID = 0;
    DescImage = @[@"ginkou.png",@"katyou.png",@"wa2.png"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//アノテーションを追加してアノテーション(ピン)が表示されるときに呼ばれるメソッド
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //現在地の情報でないか
    if (annotation != self.map.userLocation) {
        NSString *pin = @"pin";
        //pinで示すリサイクル可能なアノテーションビューかnilが返ってくる
        MKAnnotationView *av = (MKAnnotationView*)[self.map dequeueReusableAnnotationViewWithIdentifier:pin];
        if (av == nil) {
            //anotetionとpinを用いて値を代入
            av = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pin];
            //表示する画像を設定
            av.image = [UIImage imageNamed:@"haiku2.png"];
            //ピンをクリックしたときに情報を表示するようにする
            av.canShowCallout = YES;
        }
        return av;
    }else{
        return nil;
    }
}

- (void)mapView:(MKMapView*)mapView didAddAnnotationViews:(NSArray*)views{
    // アノテーションビューを取得する
    for (MKAnnotationView *annotationView in views) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        // コールアウトの左側のアクセサリビューにボタンを追加する
        annotationView.leftCalloutAccessoryView = button;
        //NSLog(@"ボタン配列の要素が%ld個",buttonArray.count);
    }
    
}

//アノテーションのコールアウトに追加したボタンがタップされるとこのメソッドが呼ばれる
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //領域外のボタンが押された場合は何も動作しない
    //領域内のボタンが押された場合はWebViewに遷移
    for (int i = 0; i < inRejon.count; i++) {
        NSLog(@"%@%@",view.annotation.title,[inRejon objectAtIndex:i]);}
    
    if ([inRejon containsObject:view.annotation.title]) {
        NSLog(@"入ってます");
        if ([view.annotation.title isEqualToString:@"徳島城公園:吟行地"]) {
            //webViewに遷移
            tokushimajoukouenViewController *tokushimajoukouenWebView = [self.storyboard instantiateViewControllerWithIdentifier:@"tokushimajoukouenWebView"];
            [self presentViewController:tokushimajoukouenWebView animated:YES completion:nil];
            
        }else if ([view.annotation.title isEqualToString:@"眉山:吟行地"]) {
            //webViewに遷移
            bizanViewController *bizan_webView = [self.storyboard instantiateViewControllerWithIdentifier:@"bizanWebView"];
            [self presentViewController:bizan_webView animated:YES completion:nil];
            
        }else if ([view.annotation.title isEqualToString:@"文化の森:吟行地"]) {
            //webViewに遷移
            bunkanomoriViewController *bunkanomoriWebView = [self.storyboard instantiateViewControllerWithIdentifier:@"bunkanomoriWebView"];
            [self presentViewController:bunkanomoriWebView animated:YES completion:nil];
            
        }
        
        
        
        //アノテーションの情報を取得
        NSLog(@"title: %@", view.annotation.title);
        NSLog(@"subtitle: %@", view.annotation.subtitle);
        NSLog(@"coord: %f, %f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
    }else{
        [[[UIAlertView alloc] initWithTitle:@"領域外です"
                                    message:@"領域外のため只今閲覧・投稿できません。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
    }
    
    
}


-(void)locationManagerMethod{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        // iOS バージョンが 8 以上で、requestAlwaysAuthorization メソッドが
        // 利用できる場合
        
        // 位置情報測位の許可を求めるメッセージを表示する
        [self.locationManager requestAlwaysAuthorization];
        //      [self.locationManager requestWhenInUseAuthorization];
    } else {
        // iOS バージョンが 8 未満で、requestAlwaysAuthorization メソッドが
        // 利用できない場合
        
        // 測位を開始する
        [self.locationManager startUpdatingLocation];
    }
}

//現在地を取得
//現在地の緯度と経度を取得
- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 位置情報測位の許可状態が「常に許可」または「使用中のみ」の場合、
        // 測位を開始する（iOS バージョンが 8 以上の場合のみ該当する）
        // ※iOS8 以上の場合、位置情報測位が許可されていない状態で
        // 　startUpdatingLocation メソッドを呼び出しても、何も行われない。
        [self.locationManager startUpdatingLocation];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
    NSLog(@"現在地経度%f 現在地緯度%f",
          location.coordinate.latitude,
          location.coordinate.longitude);
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    [self defaultMapSettei];
    [self.locationManager stopUpdatingLocation];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"エラー"
                                message:@"位置情報が取得できませんでした。"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles: nil]show];
    
}

-(void)defaultMapSettei{
    //デリゲートを自分自身に設定
    self.map.delegate = self;
    NSLog(@"中心経度%f 中心緯度%f",latitude,longitude);
    
    //地図の真ん中の位置を緯度と経度で設定
    co.latitude = latitude;
    co.longitude = longitude;
    
    
    
    //地図の縮尺を設定、coを中心に1000m四方で設定
    self.map.region = MKCoordinateRegionMakeWithDistance(co, 10000, 10000);
    //区画内の建物表示プロパティ、初期値NO
    [self.map setShowsBuildings:YES];
    //コンビニなどランドマークの表示プロパティ、初期値NO
    [self.map setShowsPointsOfInterest:YES];
    //ユーザの現在地表示プロパティ（表示のされ方は純正マップアプリを参照）初期値NO
    [self.map setShowsUserLocation:YES];
    
}


-(void)newAnnotation{
    //デリゲートを自分自身に設定
    self.map.delegate = self;
    
    NSInteger number;
    NSURL *suburl = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/sub_listen_dengoe.php"];
    NSData *urldata = [NSData dataWithContentsOfURL:suburl];
    NSString *numstr = [[NSString alloc]initWithData:urldata encoding:NSUTF8StringEncoding];
    NSLog(@"徳島城公園%@",numstr);
    number = [numstr intValue];
    
    NSInteger bizan_number;
    NSURL *bizan_suburl = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/bizan_sub_listen_dengoe.php"];
    NSData *bizan_urldata = [NSData dataWithContentsOfURL:bizan_suburl];
    NSString *bizan_numstr = [[NSString alloc]initWithData:bizan_urldata encoding:NSUTF8StringEncoding];
    NSLog(@"眉山%@",bizan_numstr);
    bizan_number = [bizan_numstr intValue];
    
    NSInteger tsurugisan_number;
    NSURL *tsurugisan_suburl = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/tsurugisan_sub_listen_dengoe.php"];
    NSData *tsurugisan_urldata = [NSData dataWithContentsOfURL:tsurugisan_suburl];
    NSString *tsurugisan_numstr = [[NSString alloc]initWithData:tsurugisan_urldata encoding:NSUTF8StringEncoding];
    NSLog(@"文化の森%@",tsurugisan_numstr);
    tsurugisan_number = [tsurugisan_numstr intValue];
    
    //緯度と経度情報を格納
    coBizan.latitude = 34.061101;
    coBizan.longitude = 134.516636;
    //coを元にsampleannotetion型の変数を生成
    CustomAnnotation *annotetion = [[CustomAnnotation alloc]initwithCoordinate:coBizan];
    annotetion.title = @"眉山:吟行地";
    annotetion.subtitle = [NSString stringWithFormat:@"%ld句の登録があります",(long)bizan_number];
    
    
    
    //緯度と経度情報を格納する変数の値を変更
    coTokushimajoukouen.latitude = 34.076229;
    coTokushimajoukouen.longitude = 134.556612;
    //coを元にannotetion型の2つめの変数を生成
    CustomAnnotation *annotetion2 = [[CustomAnnotation alloc]initwithCoordinate:coTokushimajoukouen];
    annotetion2.title = @"徳島城公園:吟行地";
    annotetion2.subtitle = [NSString stringWithFormat:@"%ld句の登録があります",(long)number];
    
    //緯度と経度情報を格納する変数の値を変更
    coBunkanomori.latitude = 34.044114;
    coBunkanomori.longitude = 134.543109;
    //coを元にannotetion型の2つめの変数を生成
    CustomAnnotation *annotetion3 = [[CustomAnnotation alloc]initwithCoordinate:coBunkanomori];
    annotetion3.title = @"文化の森:吟行地";
    annotetion3.subtitle = [NSString stringWithFormat:@"%ld句の登録があります",(long)tsurugisan_number];
    
    //2つアノテーションを追加
    [self.map addAnnotation:annotetion];
    [self.map addAnnotation:annotetion2];
    [self.map addAnnotation:annotetion3];
    
    //現在地を表示
    self.map.showsUserLocation = YES;
}

//オーバーレイを作成
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay
{
    MKCircle* circle = overlay;
    MKCircleView* circleOverlayView =   [[MKCircleView alloc] initWithCircle:circle];
    circleOverlayView.strokeColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    circleOverlayView.lineWidth = 4.;
    circleOverlayView.fillColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.35];
    return circleOverlayView;
}

//ジオフェンス設定
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager startUpdatingLocation];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"didStartMonitoringForRegion:%@", region.identifier);
    [self.locationManager requestStateForRegion:region];
}

//最初に地図を表示した時に領域内にいるのかいないのか
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    switch (state) {
        case CLRegionStateInside:
            NSLog(@"%@は領域内です",region.identifier);
            //[[[UIAlertView alloc] initWithTitle:(@"%@",region.identifier)
            //message:@"投稿と閲覧が可能です。"
            //delegate:nil
            //cancelButtonTitle:@"OK"
            //otherButtonTitles: nil]show];
            
            //領域内の掲示板名を配列に格納
            [inRejon addObject:region.identifier];
            
            
            
            for (int i = 0; i < inRejon.count; i++) {
                nsstringInRejon = [inRejon objectAtIndex:i];
                NSLog(@"inRejonの中身は%@",nsstringInRejon);
            }
            break;
        case CLRegionStateOutside:
            NSLog(@"%@は領域外です",region.identifier);
            break;
        case CLRegionStateUnknown:
            NSLog(@"%@見つからないです",region.identifier);
            break;
        default:
            NSLog(@"%@見つからないです",region.identifier);
            break;
    }
    // グローバル変数に保存
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    delegate.didRejon = inRejon;
    
    for (int i = 0; i < inRejon.count; i++) {
        NSLog(@"%@",inRejon[i]);
    }
    self.rejonLabel.hidden = NO;
    if(inRejon.count == 1){
        self.rejonLabel.text = [NSString stringWithFormat:@"ただいま領域内の吟行地は…\n○%@",inRejon[0]];
    }else if(inRejon.count == 2){
        self.rejonLabel.text = [NSString stringWithFormat:@"ただいま領域内の吟行地は…\n○%@\n○%@",inRejon[0],inRejon[1]];
    }else if(inRejon.count == 3){
        self.rejonLabel.text = [NSString stringWithFormat:@"ただいま領域内の吟行地は…\n○%@\n○%@\n○%@",inRejon[0],inRejon[1],inRejon[2]];
    }
}

//ジオフェンス監視（入ったとき呼ばれるメソッド）
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
    NSLog(@"ジオフェンス領域%@に入りました",region.identifier);
    //[self.map addOverlay:circleTokushimaeki];
}

//ジオフェンス監視（出たとき呼ばれるメソッド）
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"ジオフェンス領域%@から出ました",region.identifier);
    //[self.map removeOverlay:circleTsurugisan];
}


- (IBAction)goBackHome:(UIStoryboardSegue *)segue{
}



//初期起動時に説明文を隠すか表すか判定する。
- (void)descriptionImg {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate.saveint == 0) {
        _StartUpUIImages.image = [UIImage imageNamed:@"katyou.png"];
        StartUpUIView.hidden = NO;
        
    }
    else
    {
        _StartUpUIImages.image = nil;
        StartUpUIView.hidden = YES;
        
    }
    
}

//説明文のイメージを表示するボタン
- (IBAction)forDescription:(id)sender
{

    ID++;
    if(DescImage.count <= ID)
    {
        ID = 0;
    }
    [self.StartUpUIImages setImage:[UIImage imageNamed:[DescImage objectAtIndex:ID]]];

}


//説明文を隠すボタン
-(void)closeStartUpView
{
    StartUpUIView.hidden = YES;
}


@end
