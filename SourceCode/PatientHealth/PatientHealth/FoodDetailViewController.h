//
//  FoodDetailViewController.h
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
#import <EventKit/EventKit.h>
#import "FoodTableViewCell.h"
@import CoreData;
@interface FoodDetailViewController : UIViewController<CustomPickerDelegate>
@property (strong) NSMutableArray *fooddata;
@property (strong, nonatomic) EKEventStore *Store;
@property (weak, nonatomic) IBOutlet UITextField *foodTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *calorieCountTextField;

@property (weak, nonatomic) IBOutlet UITextField *intakeTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromdatetextfield;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property(weak,nonatomic)CustomPicker *fromDatePicker;
@property(weak,nonatomic)CustomPicker *endDatePicker;
@property(weak,nonatomic)CustomPicker *foodNamePicker;
@property(weak,nonatomic)CustomPicker *intakePicker;
@property (strong) NSMutableArray *fooddataedit;
@property NSString *dateFromCalender;
@end
