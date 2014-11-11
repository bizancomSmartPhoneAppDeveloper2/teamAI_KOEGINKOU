//
//  SecondViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"



@interface SecondViewController ()

@end

@implementation SecondViewController{
    AVAudioRecorder *avRecorder;
    AVAudioSession *audioSession;
    AVAudioPlayer *avPlayer;
    BOOL rokuonStarting;
    NSInteger number;
    NSString *userNameString;
    NSString *filename;
    NSString *path;
    NSString *updateURL;
    NSInteger tsurugisan_number;
    NSInteger bizan_number;
    NSInteger now_number;
    NSMutableArray *inRejon;
    NSMutableArray *buttonTitleArray;
}


- (void)viewDidLoad {
    rokuonStarting = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tokushimajoukouenTourokuImage.hidden = YES;
    self.bizanTourokuImage.hidden = YES;
    self.bunkanomoriTourokuImage.hidden = YES;
    
    self.myTextField.delegate = self;
    number = 0;
    
    //配列を空で生成
    inRejon = [NSMutableArray array];
    
    //デリゲートに保存したを取得する
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; // デリゲート呼び出し
    //imageviewの画像をimageに設定
    inRejon = appDelegate.didRejon;
    
    
    buttonTitleArray = [NSMutableArray array];
    buttonTitleArray =
    [NSMutableArray arrayWithObjects:@"徳島城公園:吟行地", @"眉山:吟行地", @"文化の森:吟行地", nil];
    
    [self rokuonStartHidden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rokuonStart:(UIButton *)sender {
    //録音状態でないかどうか
    if (rokuonStarting == NO) {
        self.rokuonStartStopImage.alpha = 1;
        audioSession = [AVAudioSession sharedInstance];
        NSError *error = nil;
        // 使用している機種が録音に対応しているか
        if ([audioSession inputIsAvailable]) {
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        }
        if(error){
            NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
        }
        // 録音機能をアクティブにする
        [audioSession setActive:YES error:&error];
        if(error){
            NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
        }
        
        // 録音ファイルパス
        NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,YES);
        NSString *documentDir = [filePaths objectAtIndex:0];
        //wavファイルとして保存する
        NSString *path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
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
    else if(rokuonStarting == YES){
        self.rokuonStartStopImage.alpha = 0.3;
        
        [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常に録音が完了しました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
        
        //録音をやめる
        [avRecorder stop];
        rokuonStarting = NO;
        NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,YES);
        NSString *documentDir = [filePaths objectAtIndex:0];
        path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
        //[self update];
    }
}

- (IBAction)rokuonListen:(UIButton *)sender {
    audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    //rec.wavファイルがあるパスの文字列を格納
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:recordingURL error:nil];
    avPlayer.volume=1.0;
    //再生
    [avPlayer play];
}

- (IBAction)bizantourokuButton:(UIButton *)sender {
    if (userNameString == nil) {
        [[[UIAlertView alloc] initWithTitle:@"エラー"
                                    message:@"登録文を入力してください"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
    }else {
        
        NSLog(@"眉山吟行地へ登録クリックされました");
        
        NSURL *bizan_suburl = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/bizan_sub_listen_dengoe.php"];
        NSData *bizan_urldata = [NSData dataWithContentsOfURL:bizan_suburl];
        NSString *bizan_numstr = [[NSString alloc]initWithData:bizan_urldata encoding:NSUTF8StringEncoding];
        NSLog(@"眉山%@",bizan_numstr);
        bizan_number = [bizan_numstr intValue];
        now_number = bizan_number;
        updateURL = @"http://sayaka-sawada.main.jp/keijiban/bizan_listen_dengoe.php";
        [self update];
        
        [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常にアップロードされました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
        
        //webViewに遷移
        bizanViewController *bizan_webView = [self.storyboard instantiateViewControllerWithIdentifier:@"bizanWebView"];
        [self presentViewController:bizan_webView animated:YES completion:nil];
    }
}

- (IBAction)tsurugisantourokuButton:(UIButton *)sender {
    if (userNameString == nil) {
        [[[UIAlertView alloc] initWithTitle:@"エラー"
                                    message:@"登録文を入力してください"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
    }else {
        
        NSLog(@"文化の森吟行地へ登録クリックされました");
        
        
        NSURL *tsurugisan_suburl = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/tsurugisan_sub_listen_dengoe.php"];
        NSData *tsurugisan_urldata = [NSData dataWithContentsOfURL:tsurugisan_suburl];
        NSString *tsurugisan_numstr = [[NSString alloc]initWithData:tsurugisan_urldata encoding:NSUTF8StringEncoding];
        NSLog(@"剣山%@",tsurugisan_numstr);
        tsurugisan_number = [tsurugisan_numstr intValue];
        now_number = tsurugisan_number;
        updateURL = @"http://sayaka-sawada.main.jp/keijiban/tsurugisan_listen_dengoe.php";
        [self update];
        
        [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常にアップロードされました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
        
        //webViewに遷移
        tsurugisanViewController *tsurugisan_webView = [self.storyboard instantiateViewControllerWithIdentifier:@"tsurugisanWebView"];
        [self presentViewController:tsurugisan_webView animated:YES completion:nil];
    }
}

- (IBAction)tourokuButton:(UIButton *)sender {
    if (userNameString == nil) {
        [[[UIAlertView alloc] initWithTitle:@"エラー"
                                    message:@"登録文を入力してください"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
    }else {
        
        NSLog(@"徳島城公園吟行地へ登録クリックされました");
        
        NSURL *suburl = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/sub_listen_dengoe.php"];
        NSData *urldata = [NSData dataWithContentsOfURL:suburl];
        NSString *numstr = [[NSString alloc]initWithData:urldata encoding:NSUTF8StringEncoding];
        NSLog(@"番号%@",numstr);
        number = [numstr intValue];
        NSLog(@"徳島吟行地のテーブルのカウント数%d",number);
        
        updateURL = @"http://sayaka-sawada.main.jp/keijiban/listen_dengoe.php";
        now_number = number;
        [self update];
        
        [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常にアップロードされました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
        //webViewに遷移
        WebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        [self presentViewController:webView animated:YES completion:nil];
    }
}


- (IBAction)userName:(UITextField *)sender {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    userNameString = self.myTextField.text;
    NSLog(@"%@",userNameString);
    return NO;
}



-(void)update{
    
    //パスからデータを取得
    NSData *musicdata = [[NSData alloc]initWithContentsOfFile:path];
    //ファイルをサーバーにアップするためのプログラムのURLを生成
    NSURL *url = [NSURL URLWithString:updateURL];
    //urlをもとにしたリクエストを生成
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //リクエストメッセージのbody部分を作るための変数
    NSMutableData *body = [NSMutableData data];
    //バウンダリ文字列(仕切線)を格納している変数
    NSString *boundary = @"---------------------------168072824752491622650073";
    //Content-typeヘッダに設定する情報を格納する変数
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    //POST形式の通信を行うようにする
    [request setHTTPMethod:@"POST"];
    //bodyの最初にバウンダリ文字列(仕切線)を追加
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //サーバー側に送るファイルの項目名をsample
    
    
    [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    self.dateString = [formatter stringFromDate:date];
    //送るファイル名をdateと設定
    [body appendData:[@"Content-Disposition: form-data; name=\"date\"\r\n\r\n"  dataUsingEncoding:NSUTF8StringEncoding]];
    //現在日時の文字列データ追加
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.dateString] dataUsingEncoding:NSUTF8StringEncoding]];
    //bodyの最初にバウンダリ文字列(仕切線)を追加
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //送るファイル名をusernameと設定
    [body appendData:[@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"  dataUsingEncoding:NSUTF8StringEncoding]];
    //文字列データ追加
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", userNameString] dataUsingEncoding:NSUTF8StringEncoding]];
    //bodyの最初にバウンダリ文字列(仕切線)を追加
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    //サーバー側に送るファイルの項目名をsample
    //送るファイル名をsaple.mp3と設定
    now_number++;
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sample\"; filename=\"%dsample.mp3\"\r\n",now_number]  dataUsingEncoding:NSUTF8StringEncoding]];
    filename = [NSString stringWithFormat:@"%dsample.mp3",now_number];
    
    NSLog(@"%d",now_number);
    //送るファイルのデータのタイプを設定する情報を追加
    [body appendData:[@"Content-Type: audio/mpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //音楽ファイルのデータを追加
    [body appendData:musicdata];
    NSLog(@"録音のデータサイズ%dバイト",musicdata.length);
    //最後にバウンダリ文字列を追加
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //ヘッダContent-typeに情報を追加
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    //リクエストのボディ部分に変数bodyをセット
    [request setHTTPBody:body];
    NSURLResponse *response;
    NSError *err = nil;
    //サーバーとの通信を行う
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //サーバーからのデータを文字列に変換
    NSString *datastring = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",datastring);
}

-(void)rokuonStartHidden{
    //領域内のボタンが押された場合はWebViewに遷移
    for (int i = 0; i < inRejon.count; i++) {
        NSLog(@"%ldaaaaaa%@%@",(inRejon.count),[inRejon objectAtIndex:0],[inRejon objectAtIndex:1]);
        
        if ([inRejon containsObject:@"徳島城公園:吟行地"]) {
            self.tokushimajoukouenTourokuImage.hidden = NO;
        }else{
            nil;
        }
        if ([inRejon containsObject:@"眉山:吟行地"]) {
            self.bizanTourokuImage.hidden = NO;
        }else{
            nil;
        }
        if ([inRejon containsObject:@"文化の森:吟行地"]) {
            self.bunkanomoriTourokuImage.hidden = NO;
        }else{
            nil;
        }
    }
}
@end
