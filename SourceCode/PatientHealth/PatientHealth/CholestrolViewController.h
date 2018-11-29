//
//  CholestrolViewController.h
//  PatientHealth
//
//  Created by VM on 11/29/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CholestrolViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtLDLCholestrol;
@property (strong, nonatomic) IBOutlet UITextField *txtHDLCholestrol;
@property (strong, nonatomic) IBOutlet UITextField *txtTDLCholestrol;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)onCancelClick:(id)sender;
- (IBAction)onSaveClick:(id)sender;



@end
