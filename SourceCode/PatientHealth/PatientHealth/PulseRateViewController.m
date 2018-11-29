//
//  PulseRateViewController.m
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "PulseRateViewController.h"
#import "AppDelegate.h"
#import "PulseReport+CoreDataProperties.h"

@interface PulseRateViewController ()

@end

@implementation PulseRateViewController

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
    [self saveData];
    //dismiss controller
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PulseNotification" object:nil];
    }];
}

-(void)saveData{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    PulseReport *pulseReport;
    pulseReport = [NSEntityDescription
               insertNewObjectForEntityForName:@"PulseReport"
               inManagedObjectContext:context];
    [pulseReport setValue:@"bpm" forKey:@"unit"];
    [pulseReport setValue:dateString forKey:@"date"];
    [pulseReport setValue:self.txtPulse.text forKey:@"pulse"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }else{
        NSLog(@"data Saved");
    }
}

@end
