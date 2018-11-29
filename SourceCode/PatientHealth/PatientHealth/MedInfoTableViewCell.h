//
//  MedInfoTableViewCell.h
//  PatientHealth
//
//  Created by VM  on 02/12/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
@interface MedInfoTableViewCell : UITableViewCell
{
   BOOL checked;
}
@property(weak,nonatomic)CustomPicker *dosagePicker;
@property (weak, nonatomic) IBOutlet UILabel *lblMedName;

@property (weak, nonatomic) IBOutlet UILabel *lbldosage;


@end
