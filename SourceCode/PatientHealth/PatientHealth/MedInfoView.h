//
//  MedInfoView.h
//  PatientHealth
//
//  Created by VM on 15/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedInfoTableViewCell.h"
#import "CustomPicker.h"
#import "Medicine+CoreDataProperties.h"
@import CoreData;
#import "AppDelegate.h"
@interface MedInfoView : UIView <UITableViewDelegate , UITableViewDataSource,CustomPickerDelegate>

{
//    int counter;
    BOOL checked;
    
    //new
    NSMutableArray *arrayData;
    NSMutableArray *arrayToDelete;

}
@property(weak,nonatomic)CustomPicker *dosagePicker;
//@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, weak) IBOutlet UIButton *btnAdd;
//@property (weak, nonatomic) IBOutlet UITextField *dosageTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerRow2;
- (IBAction)btnAdd:(id)sender;
- (IBAction)btnRemove:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *medicineNametxtfield;
@property (weak, nonatomic) IBOutlet UITextField *dosageTxtField;

@property (weak, nonatomic) IBOutlet UITableView *medInfotableView;

//@property (strong, nonatomic) NSArray *arraylist;
@property (strong, nonatomic) NSArray *pickerData;

@end
