//
//  VitalSectionTableViewCell.m
//  PatientHealth
//
//  Created by VM on 12/6/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "VitalSectionTableViewCell.h"

@implementation VitalSectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onSectionAddClick:(id)sender {
    [self.delegate expandCollapseSectionRows:self addButton:(UIButton *)sender];
}
@end
