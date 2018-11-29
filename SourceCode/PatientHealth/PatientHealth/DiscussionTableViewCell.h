//
//  DiscussionTableViewCell.h
//  PatientHealth
//
//  Created by VM on 10/13/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDiscussionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPeopleCount;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageCount;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@end
