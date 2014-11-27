//
//  bunkanomoriViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "bunkanomoriViewController.h"

@interface bunkanomoriViewController ()

@end

@implementation bunkanomoriViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSURL *tsurugisan_url = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/tsurugisan_listen_dengoe.php"];
    NSURL *tsurugisan_url = [NSURL URLWithString:self.urlstr];
    NSURLRequest *tsurugisan_request = [NSURLRequest requestWithURL:tsurugisan_url];
    [self.webView loadRequest:tsurugisan_request];
    
}

- (void)didReceiveMemoryWarning
{
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
