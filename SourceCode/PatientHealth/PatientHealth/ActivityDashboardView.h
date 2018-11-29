//
//  ActivityDashboardView.h
//  PatientHealth
//
//  Created by VM on 8/24/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"
#import "ActivityTableViewCell.h"
#import "Activity+CoreDataClass.h"
@import CoreData;
@interface ActivityDashboardView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *indexDataActivityCalender;
}
@property (weak, nonatomic) IBOutlet UITableView *activityProgressTableView;

@property (strong) NSMutableArray *activityData;
@property (weak, nonatomic) IBOutlet UILabel *lblGoal;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIView *looseWeightView;
@property (strong, nonatomic) IBOutlet UIView *runningView;
@property (strong, nonatomic) IBOutlet UIView *stepsView;
@property (strong, nonatomic) IBOutlet UIImageView *looseWightImg;
@property (strong, nonatomic) IBOutlet UIImageView *runningImg;
@property (strong, nonatomic) IBOutlet UIImageView *stepsImg;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblTargetWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentRunning;
@property (weak, nonatomic) IBOutlet UILabel *lblTagetRunning;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentSteps;
@property (weak, nonatomic) IBOutlet UILabel *lblTargetSteps;

@property (nonatomic,strong) NSString *indexActivity;


@end
