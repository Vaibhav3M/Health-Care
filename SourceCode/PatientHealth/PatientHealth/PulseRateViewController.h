//
//  PulseRateViewController.h
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PulseRateViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtPulse;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSaveClicked:(id)sender;

@end
