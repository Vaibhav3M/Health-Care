//
//  BPViewController.h
//  PatientHealth
//
//  Created by VM on 11/29/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BPReport+CoreDataProperties.h"

@interface BPViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtSystolicBP;
@property (strong, nonatomic) IBOutlet UITextField *txtDiastolicBP;
@property (strong, nonatomic) IBOutlet UITextField *txtBPRecordDate;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)onCancelClick:(id)sender;
- (IBAction)onSaveClick:(id)sender;

@end
