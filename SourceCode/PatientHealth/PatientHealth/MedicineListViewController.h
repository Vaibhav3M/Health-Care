//
//  MedicineListViewController.h
//  PatientHealth
//
//  Created by VM  on 02/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineDetailViewController.h"
@import CoreData;
@interface MedicineListViewController : UIViewController
- (IBAction)editBtn:(id)sender;
@property (strong) NSMutableArray *medicines;
@property (weak, nonatomic) IBOutlet UILabel *lblDataRecorded;
@property (weak, nonatomic) IBOutlet UITableView *medicineListTableView;
- (IBAction)onCancel:(id)sender;

@end
