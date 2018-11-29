//
//  MedicineDetailViewController.h
//  PatientHealth
//
//  Created by VM  on 02/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
#import <EventKit/EventKit.h>
@import CoreData;
@interface MedicineDetailViewController : UIViewController<CustomPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dosageNatureTextField;
@property (nonatomic, strong) NSString *medicineName;
@property (weak, nonatomic) IBOutlet UITextField *medicineNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *diseaseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dosageTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@property(weak,nonatomic)CustomPicker *fromDatePicker;
@property(weak,nonatomic)CustomPicker *endDatePicker;
@property(weak,nonatomic)CustomPicker *diseasePicker;
@property(weak,nonatomic)CustomPicker *dosagePicker;
@property(weak,nonatomic)CustomPicker *dosageNaturePicker;
@property (strong) NSMutableArray *medicinedata;
@property (strong) NSMutableArray *medicinedataedit;
@property  (nonatomic, strong)  NSString *savedEventId ;
@property (strong, nonatomic) EKEventStore *Store;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSDate *date1;

@property NSString *dateFromCalender;
@end
