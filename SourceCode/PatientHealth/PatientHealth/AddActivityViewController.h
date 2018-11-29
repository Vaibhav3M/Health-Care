//
//  AddActivityViewController.h
//  PatientHealth
//
//  Created by VM on 9/1/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface AddActivityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblControllerTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
/**
 values for activity
 */
@property (copy, nonatomic) NSString *strCurrWeight;
@property (copy, nonatomic) NSString *strTargetWeight;
@property (copy, nonatomic) NSString *strCurrRunning;
@property (copy, nonatomic) NSString *strTargetRunning;
@property (copy, nonatomic) NSString *strCurrSteps;
@property (copy, nonatomic) NSString *strTargetSteps;
/**
 values for Medicine
 */
@property (copy, nonatomic) NSString *strMorningDoseTarget;
@property (copy, nonatomic) NSString *strMorningDoseConsumed;
@property (copy, nonatomic) NSString *strAfternoonDoseTarget;
@property (copy, nonatomic) NSString *strAfternoonDoseConsumed;
@property (copy, nonatomic) NSString *strEveningDoseTarget;
@property (copy, nonatomic) NSString *strEveningDoseConsumed;
/**
 values for Food
 */
@property (copy, nonatomic) NSString *data;
- (IBAction)onAddButtonClick:(id)sender;
-(void)setActivityDataDefaultValues;
@end
