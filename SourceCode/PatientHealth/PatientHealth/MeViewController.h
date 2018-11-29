//
//  MeViewController.h
//  PatientHealth
//
//  Created by VM on 31/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *ageTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *outletPreExistingdiseases;
- (IBAction)actionPreExistingDisease:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *outletAllergies;
- (IBAction)btnActionAllergies:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableViewPreExistingDisease;
@property (weak, nonatomic) IBOutlet UITableView *tableViewAllergies;

@end
