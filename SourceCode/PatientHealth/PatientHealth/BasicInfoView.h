//
//  BasicInfoView.h
//  PatientHealth
//

#import <UIKit/UIKit.h>

@interface BasicInfoView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldAge;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSetPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldBloodGrp;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldWeight;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldAllergies;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
//@property (weak, nonatomic) IBOutlet UIButton *btnMale;
//@property (weak, nonatomic) IBOutlet UIButton *btnFemale;
@property (weak, nonatomic) IBOutlet UILabel *lblSmoking;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckSmoking;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckDrinking;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckDiabeties;
@property (weak, nonatomic) IBOutlet UIButton *btnBloodPressure;
@property (weak, nonatomic) IBOutlet UIButton *btnHeartCondtn;
@property (weak, nonatomic) IBOutlet UIButton *btnAsthma;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) NSString *strGender;
@property (weak, nonatomic) NSString *strSmoking;
@property (weak, nonatomic) NSString *strDrinking;
@property (weak, nonatomic) NSString *strDiabeties;
@property (weak, nonatomic) NSString *strBloodPressure;
@property (weak, nonatomic) NSString *strHeartCondition;
@property (weak, nonatomic) NSString *strAsthma;

//- (IBAction)btnMaleAction:(id)sender;
//- (IBAction)btnFemaleAction:(id)sender;
- (IBAction)btnCheckSmokingAction:(id)sender;
- (IBAction)btnDrinkingAction:(id)sender;
- (IBAction)btnDiabetiesAction:(id)sender;
- (IBAction)btnBPAction:(id)sender;
- (IBAction)btnAsthmaAction:(id)sender;
- (IBAction)btnSaveAction:(id)sender;
- (IBAction)btnNextAction:(id)sender;
- (IBAction)btnHeartCondtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewBasicInfo;
@end
