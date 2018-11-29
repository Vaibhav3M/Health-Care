//
//  AddActivityTableViewCell.h
//  PatientHealth
//
//  Created by VM on 9/2/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomViewDelegateProtocol

-(void)customTextFieldDidEndEditing:(UITextField *)textField;

@end

@interface AddActivityTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak,nonatomic) id<CustomViewDelegateProtocol> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtValue;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
