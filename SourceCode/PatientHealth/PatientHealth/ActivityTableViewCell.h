//
//  ActivityTableViewCell.h
//  PatientHealth
//
//  Created by VM  on 25/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sessionlbl;

@property (weak, nonatomic) IBOutlet UIImageView *progress;
//@property (weak, nonatomic) IBOutlet KNCirclePercentView *percentageView;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentActivity;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *progressBarView;
@property (weak, nonatomic) IBOutlet UILabel *lblTargetActivity;
@property (weak, nonatomic) IBOutlet UILabel *activitylbl;
@property (weak, nonatomic) IBOutlet UILabel *currentActivitynamelbl;
@property (weak, nonatomic) IBOutlet UILabel *targetActivitynamelbl;
+ (NSString *)reuseIdentifier ;
@end
