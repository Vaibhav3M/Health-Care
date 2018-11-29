//
//  EmergencyContactTableCellTableViewCell.h
//  PatientHealth
//
//  Created by VM on 10/15/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeableCellDelegate <NSObject>
- (void)btnDeleteAction:(UIButton *)delButton;
- (void)cellDidOpen:(UITableViewCell *)cell;
- (void)cellDidClose:(UITableViewCell *)cell;
@end

@interface EmergencyContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UISwitch *switchSendMessage;
- (IBAction)onDeleteBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (nonatomic, strong) NSString *itemText;
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;
- (void)openCell;@end
