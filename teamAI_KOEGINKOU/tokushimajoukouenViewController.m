//
//  tokushimajoukouenViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "tokushimajoukouenViewController.h"

@interface tokushimajoukouenViewController ()

@end

@implementation tokushimajoukouenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //Do any additional setup after loading the view.
   

    NSString *urlstr = @"http://koeginkou.miraiserver.com/onsei.php?place=";
    NSString *placestr = @"徳島城公園";
    NSString *encode = [placestr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
              urlstr = [urlstr stringByAppendingString:encode];
    NSURL *uurl = [NSURL fileURLWithPath:urlstr];//NSStringタイプをNSURLに変化する
    NSURLRequest *request = [NSURLRequest requestWithURL:uurl];
    
    [self.webView loadRequest:request];
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
