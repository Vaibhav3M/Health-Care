//
//  FoodListViewController.h
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;
#import "FoodDetailViewController.h"
@interface FoodListViewController : UIViewController
@property (strong) NSMutableArray *food;
@property (weak, nonatomic) IBOutlet UITableView *foodListTableView;
- (IBAction)editFoodBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblNoFoodData;

- (IBAction)cancelBtnFood:(id)sender;
@end
