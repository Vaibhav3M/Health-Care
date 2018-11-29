//
//  VitalChildTableViewCell.m
//  PatientHealth
//
//  Created by VM on 12/6/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "VitalChildTableViewCell.h"

@implementation VitalChildTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onSaveClick:(id)sender {
    NSIndexPath *indexPath = [self.btnSave.layer valueForKey:@"indexPath"];
    [self.delegate saveDataToCoreData:self textField:self.txtVal0 indexPath:indexPath];
}

- (IBAction)onShowReportClick:(id)sender {
    NSIndexPath *indexPath = [self.btnReport.layer valueForKey:@"indexPath"];
    [self.delegate showReportScreen:self indexPath:indexPath];
}

-(NSString*) getValuefromTableview:(VitalChildTableViewCell*)currentCell{
    NSString *returnString = currentCell.txtVal0.text;
    return returnString;
}

@end
