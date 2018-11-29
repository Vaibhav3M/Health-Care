//
//  SettingsTableViewController.h
//  PatientHealth
//
//  Created by VM on 01/09/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *settingLbl;
@property (strong, nonatomic) IBOutlet UILabel *mobileLbl;
@property (strong, nonatomic) IBOutlet UILabel *emailLbl;
@property (strong, nonatomic) IBOutlet UILabel *calender;
@property (strong, nonatomic) IBOutlet UILabel *emergencyLbl;
@property (strong, nonatomic) IBOutlet UILabel *galleryLbl;
@property (strong, nonatomic) IBOutlet UILabel *cameraLbl;

@end
