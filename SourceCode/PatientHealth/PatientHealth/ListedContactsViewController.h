//
//  ListedContactsViewController.h
//  PatientHealth
//
//  Created by VM on 10/17/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListedContactsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tblContactList;
@property (weak, nonatomic) IBOutlet UIButton *btnAddMore;
- (IBAction)onAddMoreClicked:(id)sender;

@end
