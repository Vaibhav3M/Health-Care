//
//  RegisterViewController.m
//  PatientHealth
//
//  Created by VM on 8/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "RegisterViewController.h"
#import "BasicInfoView.h"
#import "MedInfoView.h"
#import "UploadPhotoView.h"
#import "Connection.h"
#import "Utilities.h"
#import "HTTPHandler.h"

@interface RegisterViewController ()


@property(nonatomic,weak) BasicInfoView *viewBasicInfo;
@property(nonatomic,weak) MedInfoView *viewMedInfo;
@property(nonatomic,weak) UploadPhotoView *viewUploadPhoto;
@property(nonatomic,weak) Utilities *utils;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
   
    
    [self setupUI];
    [self setupView];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(recivingMethodOnListnerR:)
     name:@"registerNotification"
     object:nil];

     [super viewDidLoad];
}

    
//- (void)setCustomNavigationBackButton
//{
//    UIImage *temp = [[UIImage imageNamed:@"Back"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:temp style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
//    self.navigationItem.leftBarButtonItem = barButtonItem;
//}

-(void) setRegisterButton{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStylePlain target:self action:@selector(onRegisterClick)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    NSLog(@"self.navigationController.navigationItem.rightBarButtonItem:%@",[self.navigationController.navigationItem.rightBarButtonItem description]);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    [_segmentControlRegister setSelectedSegmentIndex:0];
    _segmentControlRegister.tintColor = [UIColor whiteColor];
    [self setRegisterButton];
    
//    [self setCustomNavigationBackButton];
    SEL selector = @selector(backAction);
    [[Utilities sharedInstance] setCustomBackButton:self withSelector:selector];
    [self loadBasicInfoView];
    [self initPicker];
    [self initBloodGroupPicker];
}

-(void)loadBasicInfoView{
    _viewBasicInfo = [[[NSBundle mainBundle] loadNibNamed:@"BasicInfo" owner:self options:nil] lastObject];
    [_containerView addSubview:_viewBasicInfo];
    _viewBasicInfo.scrollView.contentSize = CGSizeMake(_viewBasicInfo.bounds.size.width, 900);
    [self setConstraints:_viewBasicInfo];
    _viewBasicInfo.txtFieldSetPassword.secureTextEntry = YES;
    _viewBasicInfo.txtFieldConfirmPassword.secureTextEntry = YES;

}

-(void)loadMedInfoView{
    _viewMedInfo = [[[NSBundle mainBundle] loadNibNamed:@"MedInfo" owner:self options:nil] lastObject];
    
    [_containerView addSubview:_viewMedInfo];
    [self setConstraints:_viewMedInfo];
    [self setupPickerData];
}

-(void)loadUploadPhotoView{
    _viewUploadPhoto = [[[NSBundle mainBundle] loadNibNamed:@"UploadPhoto" owner:self options:nil] lastObject];
    
    [_containerView addSubview:_viewUploadPhoto];
    [self setConstraints:_viewUploadPhoto];
    [_viewUploadPhoto setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)setConstraints:(UIView *)viewName{
    viewName.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:400];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeHeight multiplier:1 constant:639];
    
    [_containerView addConstraints:@[leadingConstraint,topConstraint,widthConstraint,heightConstraint]];
    
    NSLog(@"ContainerView : %@ and %@ : %@",NSStringFromCGSize(_containerView.frame.size),viewName,NSStringFromCGSize(viewName.frame.size));

}


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) validateFields{
    if(([[Utilities sharedInstance] isTextFieldEmpty:_viewBasicInfo.txtFieldUsername]== NO)||([[Utilities sharedInstance] isTextFieldEmpty:_viewBasicInfo.txtFieldSetPassword]== NO)||([[Utilities sharedInstance] isTextFieldEmpty:_viewBasicInfo.txtFieldConfirmPassword]== NO)||([[Utilities sharedInstance] isTextFieldEmpty:_viewBasicInfo.txtFieldAge]== NO)||([[Utilities sharedInstance] isTextFieldEmpty:_viewBasicInfo.txtFieldEmail]== NO)||[[Utilities sharedInstance] isTextFieldEmpty:_viewBasicInfo.txtGender]== NO){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)  validatePassword
{
    if (!([[Utilities sharedInstance] isPasswordMatch:_viewBasicInfo.txtFieldSetPassword.text :_viewBasicInfo.txtFieldConfirmPassword.text]))
    {
        return NO;
        
    }else {
        
    return YES;
    }
    
}

-(void) onRegisterClick{
//  
//if(![self validateFields] ){
//    [self showFieldEmptyALert :_strError :_strAllFieldsAreMandatory];
//}else if(![self validatePassword]){
//    [self showFieldEmptyALert :_strError :self.strPasswordDonotMatch];
//}else{
#ifdef DEMO
    
    HTTPHandler *serviceCall =[[HTTPHandler alloc]init];
    serviceCall.registerUserName=_viewBasicInfo.txtFieldUsername.text;
    serviceCall.registerPassword=_viewBasicInfo.txtFieldSetPassword.text;
    serviceCall.registerConfirmPassword=_viewBasicInfo.txtFieldConfirmPassword.text;
    serviceCall.registerEmail=_viewBasicInfo.txtFieldEmail.text;
    serviceCall.registerAge=_viewBasicInfo.txtFieldAge.text;
    
    [serviceCall registration];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess:) name:@"RegisterNotification" object:nil];
    
//        [[Connection sharedInstance] offlineDummyDataWithFileName:@"register" withCompletionBlock:^(id obj, NSError *err) {
//        dispatch_async(dispatch_get_main_queue(),^ {
//            [self performSegueWithIdentifier:@"registerBtnClickSegue" sender:self];
//        });
   // }];
    
#else
    [[Connection sharedInstance] requestWithURLFolder:@"users/register" andParameter:[NSDictionary dictionaryWithObjectsAndKeys:_viewBasicInfo.txtFieldUsername.text,@"username",_viewBasicInfo.txtFieldSetPassword.text,@"password",_viewBasicInfo.txtFieldAge.text,@"dob",_viewBasicInfo.txtFieldEmail.text,@"email",_viewBasicInfo.txtFieldWeight.text,@"weight",_viewBasicInfo.txtFieldHeight.text,@"height",_viewBasicInfo.strGender,@"gender",_viewBasicInfo.strSmoking,@"smoking",_viewBasicInfo.txtFieldBloodGrp.text,@"bloodGroup",_viewBasicInfo.txtFieldAllergies.text,@"allergic", nil] withCompletionBlock:^(id obj, NSError *err) {
        if (!err) {
            dispatch_async(dispatch_get_main_queue(),^ {
                [self performSegueWithIdentifier:@"registerBtnClickSegue" sender:self];
            });
        //}
    }];
    
#endif
    }
//}
-(void)registerSuccess: (NSNotification*)n
{
    
    NSLog(@"balle balle");
}


- (IBAction)onSegmentControlClick:(id)sender {
    NSInteger selectedSegment = [sender selectedSegmentIndex];
    if (selectedSegment == 0) {
        [self loadBasicInfoView];
    }else if (selectedSegment == 1){
        [self loadMedInfoView];
    }else if (selectedSegment == 2){
        [self loadUploadPhotoView];
    }
}

-(void)setupPickerData{
    _viewMedInfo.pickerData = [[NSArray alloc]initWithObjects:@"Once a day",@"Twice daily",@"Thrice Daily",@"4 times a Day", nil];
    [_viewMedInfo.dosePicker setShowsSelectionIndicator:YES];
}

-(void)showFieldEmptyALert :(NSString*)msgStr :(NSString*)titleStr
{
    UIAlertController *alert = [UIAlertController
                                 alertControllerWithTitle:  msgStr
                                message:   titleStr
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)initPicker{
    self.genderPicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"Male",@"Female", nil];
    self.genderPicker.dataSourceArrayForSimplePicker = array;
    self.genderPicker.delegate = self;
    [self.viewBasicInfo.txtGender setInputView:self.genderPicker];
}

-(void)didTapOnDoneOf:(CustomPicker *)picker{
    if (picker.tag==999) {
        self.viewBasicInfo.txtFieldBloodGrp.text = picker.selectedValue.text;
        [self.viewBasicInfo.txtFieldBloodGrp resignFirstResponder];
    } else {
        self.viewBasicInfo.txtGender.text = picker.selectedValue.text;
        [self.viewBasicInfo.txtGender resignFirstResponder];
    }
}
     
-(void) setupView{
 self.strError = @"Error";
 self.strAllFieldsAreMandatory = @"All Fields are Mandatory";
 self.strOOPS = @"OOPS";
 self.strPasswordDonotMatch = @"Password do not Match";
    
}

-(void)initBloodGroupPicker
{
    self.bloodGroupPicker = [[CustomPicker alloc] instantiateWithStyle:(CUSTOM_PICKER_SIMPLE)];
    [self.bloodGroupPicker setTag:999];
    NSMutableArray *array =[[NSMutableArray alloc]initWithObjects:@"O+",@"O-", @"B+",@"B-",@"A+",@"A-",@"AB+",@"AB-",nil];
    self.bloodGroupPicker.dataSourceArrayForSimplePicker = array;
    self.bloodGroupPicker.delegate = self;
    [self.viewBasicInfo.txtFieldBloodGrp setInputView:self.bloodGroupPicker];
}
@end
