//
//  AddActivityTableViewCell.m
//  PatientHealth
//
//  Created by VM on 9/2/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "AddActivityTableViewCell.h"

@implementation AddActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self.delegate customTextFieldDidEndEditing:textField];
}

@end
