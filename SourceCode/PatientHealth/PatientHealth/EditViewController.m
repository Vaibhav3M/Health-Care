//
//  EditViewController.m
//  PatientHealth
//
//  Created by VM on 31/08/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"Edit Profile";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)smokingBtn:(id)sender {
    [self setInputString:_smokingBtn :_strSmoking];
    
}

- (IBAction)drinkingBtn:(id)sender {
    
[self setInputString:_drinkingBtn :_strDrinking];
    
    
    
}

- (IBAction)diabetesBtn:(id)sender {
    
   [self setInputString:_diabetesBtn:_strDiabeties];
    
}

- (IBAction)bloodBtn:(id)sender {
    [self setInputString:_bloodBtn :_strBloodPressure];
    
}

- (IBAction)heartBtn:(id)sender {
    
    [self setInputString:_heartBtn :_strHeart];
    
}

- (IBAction)asthamaBtn:(id)sender {
    
    [self setInputString:_asthamaBtn :_strAsthma];
}

- (IBAction)save:(id)sender
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"EDITTED !!"
                                message:@"Editted Data Successfully Saved."
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





-(void)setInputString:(UIButton*)currBtn :(NSString*)currStr {
    
    if(currBtn.isSelected == NO){
        [currBtn setSelected:YES];
        currStr = @"Yes";
        [currBtn setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateSelected];
    }else{
        [currBtn setSelected:NO];
        currStr = @"No";
        [currBtn setImage:[UIImage imageNamed:@"Uncheck.png"] forState:UIControlStateNormal];
    }
}


@end
