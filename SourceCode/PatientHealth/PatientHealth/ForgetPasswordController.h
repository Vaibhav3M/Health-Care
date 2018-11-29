//
//  ForgetPasswordController.h
//  PatientHealth
//
//  Created by VM on 8/22/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnGetEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UIImageView *imgAnimatedImage;
- (IBAction)onGetEmailClick:(id)sender;
@property (strong, atomic) NSMutableArray *imgArray;
@end
