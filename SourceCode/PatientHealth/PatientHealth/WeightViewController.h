//
//  WeightViewController.h
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeightViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtWeight;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onSaveClicked:(id)sender;

@end
