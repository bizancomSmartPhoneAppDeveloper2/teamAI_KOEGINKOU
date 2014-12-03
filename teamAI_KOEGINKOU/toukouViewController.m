//
//  toukouViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "toukouViewController.h"
#import "AppDelegate.h"
#import "tokushimajoukouenViewController.h"
#import "bunkanomoriViewController.h"
#import "bizanViewController.h"
#import "FirstViewController.h"

@interface toukouViewController ()

@end

@implementation toukouViewController{
    NSInteger number;
    NSInteger bizan_number;
    NSInteger bunkanomori_number;
    NSInteger now_number;
    NSMutableArray *inRejon;
    NSMutableArray *buttonTitleArray;
    NSString *userNameString;
    NSString *updateURL;
    NSString *path;
    NSString *filename;
    
    NSTimer *timeTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tokushimajoukouenTourokuImage.hidden = YES;
    self.bizanTourokuImage.hidden = YES;
    self.bunkanomoriTourokuImage.hidden = YES;
    
    self.myTextField.delegate = self;
    
    self.tokushimaParkLabel.hidden = YES;
    self.mtBizanLabel.hidden = YES;
    self.bunkaNoMori.hidden = YES;

    //配列を空で生成
    inRejon = [NSMutableArray array];
    
    //デリゲートに保存したを取得する
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; // デリゲート呼び出し
    inRejon = appDelegate.didRejon;
    NSLog(@"nnnnnnnnn%@",inRejon[0]);
    
   [self rokuonStartHidden];
    
    buttonTitleArray = [NSMutableArray array];
    buttonTitleArray =
    [NSMutableArray arrayWithObjects:@"徳島城公園:吟行地", @"眉山:吟行地", @"文化の森:吟行地", nil];

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
- (IBAction)bizantourokuButton:(UIButton *)sender {
    if (userNameString == nil) {
        [[[UIAlertView alloc] initWithTitle:@"エラー"
                                    message:@"名前を入力してください"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
    }
    else
    {
        
        NSLog(@"眉山吟行地へ登録クリックされました");
        
        [self update:1];
        
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

- (IBAction)bunkanomoritourokuButton:(UIButton *)sender
{
    if (userNameString == nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"エラー"
                                    message:@"名前を入力してください"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
     
        
    }
    else
    {
        
        NSLog(@"文化の森吟行地へ登録クリックされました");
        

        [self update:2];
        
        [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常にアップロードされました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
       // [self usetimer];
        
        //webViewに遷移
        bunkanomoriViewController *bunkanomori_webView = [self.storyboard instantiateViewControllerWithIdentifier:@"bunkanomoriWebView"];
        [self presentViewController:bunkanomori_webView animated:YES completion:nil];
    }
}

- (IBAction)tokushimajoukouentourokuButton:(UIButton *)sender {
    if (userNameString == nil) {
        [[[UIAlertView alloc] initWithTitle:@"エラー"
                                    message:@"名前を入力してください"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
    }
    else
    {
        
        NSLog(@"徳島城公園吟行地へ登録クリックされました");
        
        [self update:3];
        
        [[[UIAlertView alloc] initWithTitle:@"完了"
                                    message:@"正常にアップロードされました。"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil]show];
        
        //tokushimajoukouenwebViewに遷移
        tokushimajoukouenViewController *tokushimajoukouenWebView = [self.storyboard instantiateViewControllerWithIdentifier:@"tokushimajoukouenWebView"];
        [self presentViewController:tokushimajoukouenWebView animated:YES completion:nil];
    }
}


- (IBAction)tourokubunField:(UITextField *)sender {
}

//キーボードに”改行”から”完了”の文字に変えた
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    textField.returnKeyType = UIReturnKeyDone;
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    userNameString = self.myTextField.text;
    NSLog(@"%@",userNameString);
    return NO;
}



-(void)update:(int)placeNumber {
    updateURL = @"http://koeginkou.miraiserver.com/file.php";

    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    //rec.wavファイルがあるパスの文字列を格納
    path = [documentDir stringByAppendingPathComponent:@"rec.wav"];
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
    /*
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
     */
    //bodyの最初にバウンダリ文字列(仕切線)を追加
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //送るファイル名をusernameと設定
    [body appendData:[@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"  dataUsingEncoding:NSUTF8StringEncoding]];
    //文字列データ追加
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.myTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
    //bodyの最初にバウンダリ文字列(仕切線)を追加
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //送るファイル名をusernameと設定
    [body appendData:[@"Content-Disposition: form-data; name=\"place\"\r\n\r\n"  dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *placestr = @"";
    
    switch(placeNumber){
        case 1:
            placestr = @"眉山";
            break;
        case 2:
            placestr = @"文化の森";
            break;
        case 3:
            placestr = @"徳島城公園";
            break;
    }
    
    //文字列データ追加
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", placestr] dataUsingEncoding:NSUTF8StringEncoding]];
    //bodyの最初にバウンダリ文字列(仕切線)を追加
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    //サーバー側に送るファイルの項目名をsample
    //送るファイル名をsaple.mp3と設定
    now_number++;
    [body appendData:[@"Content-Disposition: form-data; name=\"sample\"; filename=\"sample.mp3\"\r\n"  dataUsingEncoding:NSUTF8StringEncoding]];
    filename = [NSString stringWithFormat:@"%ldsample.mp3",(long)now_number];
    
    NSLog(@"%ld",(long)now_number);
    //送るファイルのデータのタイプを設定する情報を追加
    [body appendData:[@"Content-Type: audio/mpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //音楽ファイルのデータを追加
    [body appendData:musicdata];
    NSLog(@"録音のデータサイズ%ldバイト",(unsigned long)musicdata.length);
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
     NSLog(@"%ldaaaaaa%@",(unsigned long)(inRejon.count),[inRejon objectAtIndex:0]);
    
    //領域内のボタンが押された場合はWebViewに遷移
    for (int i = 0; i < inRejon.count; i++) {
        NSLog(@"%ldaaaaaa%@",(unsigned long)(i),[inRejon objectAtIndex:i]);
        
        
        
        if ([inRejon containsObject:@"徳島城公園:吟行地"])
        {
            self.tokushimajoukouenTourokuImage.hidden = NO;
            self.tokushimaParkLabel.hidden = NO;
            
        }
        else if ([inRejon containsObject:@"眉山:吟行地"])
        {
            self.bizanTourokuImage.hidden = NO;
            self.mtBizanLabel.hidden = NO;
            
        }
        else if ([inRejon containsObject:@"文化の森:吟行地"])
        {
            self.bunkanomoriTourokuImage.hidden = NO;
            self.bunkaNoMori.hidden = NO;
        }
 
    }
}


//-(void)usetimer
//{
//
////タイマーをセット
//timeTimer =[NSTimer scheduledTimerWithTimeInterval:5
//                                      target:self
//                                    selector:@selector(nextPage:)
//                                    userInfo:nil
//                                     repeats:NO];
//}
//
//-(void)nextPage:(NSTimer*)timer{
//    FirstViewController * newView = [[ FirstViewController alloc] initWithNibName:@"2Launch Screen" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:newView animated:YES];
//    [timeTimer invalidate];
//}


@end
