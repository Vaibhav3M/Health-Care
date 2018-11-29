//
//  DiscussionDetailTableViewCell.h
//  PatientHealth
//
//  Created by VM  on 21/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussionDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDiscussionDetails;

@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@end
