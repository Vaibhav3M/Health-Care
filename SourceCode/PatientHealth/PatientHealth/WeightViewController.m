//
//  WeightViewController.m
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "WeightViewController.h"

@interface WeightViewController ()

@end

@implementation WeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)onCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSaveClicked:(id)sender {
    //save data in core data
    
    //dismiss controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
