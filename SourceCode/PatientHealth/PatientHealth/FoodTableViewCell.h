//
//  FoodTableViewCell.h
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodprogressimageview;
@property (weak, nonatomic) IBOutlet UILabel *foodlbl;
@property (weak, nonatomic) IBOutlet UILabel *intakelbl;
@property (weak, nonatomic) IBOutlet UITextField *foodTakenTextField;



@end
