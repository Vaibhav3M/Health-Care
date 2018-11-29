//
//  LoginViewController.h
//  PatientHealth
//
//  Created by VM on 8/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)registerButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
- (IBAction)onLoginClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end
