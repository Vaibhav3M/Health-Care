//
//  CholestrolViewController.m
//  PatientHealth
//
//  Created by VM on 11/29/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "CholestrolViewController.h"

@implementation CholestrolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSaveClick:(id)sender {
    //save data in core data
    
    //dismiss controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
