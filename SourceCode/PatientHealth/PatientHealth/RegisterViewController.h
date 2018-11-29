//
//  RegisterViewController.h
//  PatientHealth
//
//  Created by VM on 8/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"

@interface RegisterViewController : UIViewController<CustomPickerDelegate>
{
    NSMutableData *_responseData;
    NSURL *UrlR;
    NSString *strPrintRepeat;
    

    
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlRegister;
@property (weak, nonatomic) IBOutlet UIView *containerView;


- (IBAction)onSegmentControlClick:(id)sender;
@property(weak,nonatomic)NSString *strError;
@property(weak,nonatomic)NSString *strAllFieldsAreMandatory;
@property(weak,nonatomic)NSString *strOOPS;
@property(weak,nonatomic)NSString *strPasswordDonotMatch;
@property(weak,nonatomic)CustomPicker *bloodGroupPicker;
@property(weak,nonatomic)CustomPicker *genderPicker;
-(void)initBloodGroupPicker;
-(void)initPicker;
@end
