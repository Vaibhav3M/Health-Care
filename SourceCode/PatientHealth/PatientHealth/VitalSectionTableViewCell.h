//
//  VitalSectionTableViewCell.h
//  PatientHealth
//
//  Created by VM on 12/6/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VitalSectionTableViewCell;

@protocol VitalSectionTableViewCellProtocol <NSObject>
-(void)expandCollapseSectionRows:(VitalSectionTableViewCell *)cell addButton:(UIButton *)button;
@end

@interface VitalSectionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblSectionHeader;
@property (strong, nonatomic) IBOutlet UIButton *btnSectionHeaderAdd;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak,nonatomic) id<VitalSectionTableViewCellProtocol> delegate;

- (IBAction)onSectionAddClick:(id)sender;
@end
