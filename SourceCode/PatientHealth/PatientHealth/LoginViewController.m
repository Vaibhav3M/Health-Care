//
//  LoginViewController.m
//  PatientHealth
//
//  Created by VM on 8/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Connection.h"
#import "DashBoardViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setupUI{
    _txtPassword.secureTextEntry = YES;
}

- (IBAction)registerButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"RegisterSegueIdentifier" sender:self];
}

- (IBAction)onLoginClick:(id)sender {

#ifdef DEMO
    [[Connection sharedInstance] offlineDummyDataWithFileName:@"login" withCompletionBlock:^(id obj, NSError *err) {
        dispatch_async(dispatch_get_main_queue(),^ {
            [self performSegueWithIdentifier:@"loginBtnClickSegue" sender:self];
        });
    }];
    
#else
    [[Connection sharedInstance] requestWithURLFolder:@"users/login" andParameter:[NSDictionary dictionaryWithObjectsAndKeys:_txtUsername.text,@"login",_txtPassword.text,@"password", nil] withCompletionBlock:^(id obj, NSError *err) {
        if (!err) {
            dispatch_async(dispatch_get_main_queue(),^ {
                [self performSegueWithIdentifier:@"loginBtnClickSegue" sender:self];
            });
        }
    }];
    
#endif
}


@end
