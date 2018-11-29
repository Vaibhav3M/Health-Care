//
//  CalenderSelectedDateSubview.h
//  PatientHealth
//
//  Created by VM  on 09/12/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderSelectedDateSubview : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblMessage_;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property NSString *strSelectedType;
@property NSString *strselectedDate;
- (IBAction)btnAdd:(id)sender;

@end
