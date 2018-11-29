//
//  BloodSugarViewController.m
//  PatientHealth
//
//  Created by VM on 11/29/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BloodSugarViewController.h"

@implementation BloodSugarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)onSaveClicked:(id)sender {
    //save data in core data
    
    //dismiss controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
