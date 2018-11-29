//
//  listOfActivityViewController.m
//  PatientHealth
//
//  Created by VM  on 24/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ActivityListViewController.h"

@interface ActivityListViewController ()

@end

@implementation ActivityListViewController
- (void)viewDidLoad
{
        [self.activityTableView setHidden:YES];
    [super viewDidLoad];
//    [self.activityTableView registerNib:[UINib nibWithNibName:@"activityTableView" bundle:nil] forCellReuseIdentifier:@"Cell"];
//    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Activity"];
    self.activities = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if([self.activities count] > 0){
        [self.lblactivitydata setHidden:YES];
        [self.activityTableView setHidden:NO];
        [self.activityTableView reloadData];
    }else{
        [self.lblactivitydata setHidden:NO];
        [self.activityTableView setHidden:YES];
    }

//    [self.activityTableView reloadData];
}
//- (id)initWithStyle:(UITableViewStyle)style
//{
//   // self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSManagedObject *activity = [self.activities objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@" ,[activity valueForKey:@"activity"]]];

  //  [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [activity valueForKey:@"activity"], [activity valueForKey:@"target"]]];
    //[cell.detailTextLabel setText:[activity valueForKey:@"current"]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"ncjncj");
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.activities objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.activities removeObjectAtIndex:indexPath.row];
        [self.activityTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(void)alert
{
    //    if (addeventGranted == 1){
    //        UIAlertView *alert = [ [ UIAlertView alloc]initWithTitle:@"sucsess" message:@"eventadded" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    //        [alert show];
    //    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate
//- (void)eventEditViewController:(EKEventEditViewController *)controller
//          didCompleteWithAction:(EKEventEditViewAction)action {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    }


- (IBAction)cancelBtnActivity:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editActivityBtn:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showActivityDetail"]) {
        NSManagedObject *editdata = [self.activities objectAtIndex:[[self.activityTableView indexPathForSelectedRow] row]];
        ActivityDetailViewController *destViewController = segue.destinationViewController;
        destViewController.activitydataedit = editdata;
      
    }
}
@end
