//
//  BloodSugarViewController.h
//  PatientHealth
//
//  Created by VM on 11/29/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BloodSugarViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtFasting;
@property (strong, nonatomic) IBOutlet UITextField *txtAfterMeal;
@property (strong, nonatomic) IBOutlet UITextField *txtRandom;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *txtSave;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSaveClicked:(id)sender;
@end
