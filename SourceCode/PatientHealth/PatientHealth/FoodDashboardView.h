//
//  FoodDashboardView.h
//  PatientHealth
//
//  Created by VM on 8/24/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"
#import "FoodTableViewCell.h"
@import CoreData;
@interface FoodDashboardView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *indexDataFoodCalender;

}
@property (weak, nonatomic) IBOutlet UITableView *foodProgressViewTableView;

@property (strong) NSMutableArray *foodData;
@end
