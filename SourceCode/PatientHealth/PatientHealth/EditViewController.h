//
//  EditViewController.h
//  PatientHealth
//
//  Created by VM on 31/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *ageText;
@property (strong, nonatomic) IBOutlet UITextField *emailText;
@property (strong, nonatomic) IBOutlet UITextField *bloodTxt;
@property (strong, nonatomic) IBOutlet UITextField *heightTxt;
@property (strong, nonatomic) IBOutlet UITextField *weightTxt;
@property (strong, nonatomic) IBOutlet UITextField *alergiesTxt;
@property (strong, nonatomic) IBOutlet UIView *smoking;
@property (strong, nonatomic) IBOutlet UIView *drinking;
@property (strong, nonatomic) IBOutlet UIView *diabetes;
@property (strong, nonatomic) IBOutlet UIView *bloodPressure;
@property (strong, nonatomic) IBOutlet UIView *heartDiease;
@property (strong, nonatomic) IBOutlet UIView *asthama;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UILabel *smokingLbl;
@property (strong, nonatomic) IBOutlet UILabel *drinkingLbl;
@property (strong, nonatomic) IBOutlet UILabel *diabetesLbl;
@property (strong, nonatomic) IBOutlet UILabel *bloodpressureLbl;
@property (strong, nonatomic) IBOutlet UILabel *heartLbl;
@property (strong, nonatomic) IBOutlet UILabel *asthamaLbl;


@property (weak, nonatomic) NSString *strSmoking;
@property (weak, nonatomic) NSString *strDrinking;
@property (weak, nonatomic) NSString *strDiabeties;
@property (weak, nonatomic) NSString *strBloodPressure;
@property (weak, nonatomic) NSString *strHeart;
@property (weak, nonatomic) NSString *strAsthma;




@property (strong, nonatomic) IBOutlet UIButton *smokingBtn;
@property (strong, nonatomic) IBOutlet UIButton *drinkingBtn;
@property (strong, nonatomic) IBOutlet UIButton *diabetesBtn;

@property (strong, nonatomic) IBOutlet UIButton *bloodBtn;
@property (strong, nonatomic) IBOutlet UIButton *heartBtn;
@property (strong, nonatomic) IBOutlet UIButton *asthamaBtn;

- (IBAction)smokingBtn:(id)sender;
- (IBAction)drinkingBtn:(id)sender;
- (IBAction)diabetesBtn:(id)sender;
- (IBAction)bloodBtn:(id)sender;
- (IBAction)heartBtn:(id)sender;
- (IBAction)asthamaBtn:(id)sender;
- (IBAction)save:(id)sender;



@end
