//
//  listOfActivityViewController.h
//  PatientHealth
//
//  Created by VM  on 24/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKitUI/EventKitUI.h>
#import <EventKit/EventKit.h>
#import "ActivityDetailViewController.h"
@import CoreData;
@interface ActivityListViewController : UIViewController
@property (strong) NSMutableArray *activities;
- (IBAction)editActivityBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *activityTableView;
@property (weak, nonatomic) IBOutlet UILabel *lblactivitydata;
- (IBAction)cancelBtnActivity:(id)sender;

@end
