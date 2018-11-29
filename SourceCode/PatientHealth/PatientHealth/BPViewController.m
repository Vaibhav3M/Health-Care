//
//  BPViewController.m
//  PatientHealth
//
//  Created by VM on 11/29/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BPViewController.h"

@implementation BPViewController

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
    [self saveData];
    //dismiss controller
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BPNotification" object:nil];
    }];
}

-(void) saveData{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    BPReport *bpReport;
    bpReport = [NSEntityDescription
                   insertNewObjectForEntityForName:@"BPReport"
                   inManagedObjectContext:context];
    [bpReport setValue:@"mmHg" forKey:@"unit"];
    [bpReport setValue:dateString forKey:@"date"];
    [bpReport setValue:self.txtSystolicBP.text forKey:@"systolic"];
    [bpReport setValue:self.txtDiastolicBP.text forKey:@"diastolic"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }

}
@end
