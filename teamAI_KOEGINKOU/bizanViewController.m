//
//  bizanViewController.m
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import "bizanViewController.h"

@interface bizanViewController ()

@end

@implementation bizanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *bizan_url = [NSURL URLWithString:@"http://sayaka-sawada.main.jp/keijiban/bizan_listen_dengoe.php"];
    NSURLRequest *bizan_request = [NSURLRequest requestWithURL:bizan_url];
    [self.webView loadRequest:bizan_request];
    
    
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
