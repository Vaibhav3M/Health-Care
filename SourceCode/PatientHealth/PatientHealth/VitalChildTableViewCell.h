//
//  VitalChildTableViewCell.h
//  PatientHealth
//
//  Created by VM on 12/6/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BPReport+CoreDataProperties.h"

@class VitalChildTableViewCell;
@protocol VitalTableViewCellProtocol <NSObject>
-(void)showReportScreen:(VitalChildTableViewCell*)cell indexPath:(NSIndexPath*)indexPath;
-(void)saveDataToCoreData:(VitalChildTableViewCell*)cell textField:(UITextField *)valToSave indexPath:(NSIndexPath*)indexPath;
//-(void)fillPercentageInProgress:(MedicineTableViewCell *)cell progressBar:(KNCirclePercentView *)progressbar;
@end

@interface VitalChildTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *txtVal0;
@property (weak,nonatomic) id<VitalTableViewCellProtocol> delegate;
//@property (strong, nonatomic) IBOutlet UITextField *txtVal1;
@property (strong, nonatomic) IBOutlet UIButton *btnReport;
//@property (strong, nonatomic) IBOutlet UITextField *txtVal2;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)onSaveClick:(id)sender;
- (IBAction)onShowReportClick:(id)sender;

-(void)saveBPData:(NSString*) systolic : (NSString*)diastolic;
@end
