//
//  toukouViewController.h
//  teamAI_KOEGINKOU
//
//  Created by ビザンコムマック０４ on 2014/11/11.
//  Copyright (c) 2014年 ビザンコムマック０４. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface toukouViewController : UIViewController<UITextFieldDelegate>
- (IBAction)bizantourokuButton:(UIButton *)sender;
- (IBAction)bunkanomoritourokuButton:(UIButton *)sender;

- (IBAction)tokushimajoukouentourokuButton:(UIButton *)sender;
- (IBAction)tourokubunField:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property NSString *userName;
@property NSString *dateString;
@property (weak, nonatomic) IBOutlet UIButton *tokushimajoukouenTourokuImage;
@property (weak, nonatomic) IBOutlet UIButton *bizanTourokuImage;
@property (weak, nonatomic) IBOutlet UIButton *bunkanomoriTourokuImage;


@property (weak, nonatomic) IBOutlet UILabel *tokushimaParkLabel;
@property (weak, nonatomic) IBOutlet UILabel *mtBizanLabel;

@property (weak, nonatomic) IBOutlet UILabel *bunkaNoMori;





@end
