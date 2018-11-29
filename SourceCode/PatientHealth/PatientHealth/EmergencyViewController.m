//
//  EmergencyViewController.m
//  PatientHealth
//
//  Created by VM on 9/27/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "EmergencyViewController.h"
#import "AppDelegate.h"
#import "ContactsViewController.h"
@interface EmergencyViewController ()

@property(strong, nonatomic) NSArray *objects;

@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    _objects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if ([_objects count] > 0) {
        
    }
}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *contactsNavVC = [segue destinationViewController];
    ContactsViewController *contactsVC = (ContactsViewController *)[contactsNavVC topViewController];
    contactsVC.isFirstContact = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
