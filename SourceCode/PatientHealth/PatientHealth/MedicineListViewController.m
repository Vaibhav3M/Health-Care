//
//  MedicineListViewController.m
//  PatientHealth
//
//  Created by VM  on 02/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedicineListViewController.h"

@interface MedicineListViewController ()

@end

@implementation MedicineListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.medicineListTableView setHidden:YES];
    // Do any additional setup after loading the view.
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Medicine"];
    self.medicines = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if([self.medicines count] > 0){
        [self.lblDataRecorded setHidden:YES];
        [self.medicineListTableView setHidden:NO];
        [self.medicineListTableView reloadData];
    }else{
        [self.lblDataRecorded setHidden:NO];
        [self.medicineListTableView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
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
    return self.medicines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSManagedObject *medicine = [self.medicines objectAtIndex:indexPath.row];
  [cell.textLabel setText:[NSString stringWithFormat:@"%@" ,[medicine valueForKey:@"medicinename"]]];
   // [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [medicine valueForKey:@"medicinename"], [medicine valueForKey:@"dosagenature"]]];
    
         return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.medicines objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.medicines removeObjectAtIndex:indexPath.row];
        [self.medicineListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


//- (id)initWithStyle:(UITableViewStyle)style
//{
//   // self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}



#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editBtn:(id)sender {

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMedicineDetail"]) {
        NSManagedObject *editdata = [self.medicines objectAtIndex:[[self.medicineListTableView indexPathForSelectedRow] row]];
        MedicineDetailViewController *destViewController = segue.destinationViewController;
        destViewController.medicinedataedit = editdata;
//        NSIndexPath *indexPath = [self.medicineListTableView indexPathForSelectedRow];
//        MedicineDetailViewController *destViewController = segue.destinationViewController;
//        NSArray*medicineNameArrey= [_medicines valueForKey:@"medicinename"];
//        NSString*medname=[medicineNameArrey objectAtIndex:indexPath.row];
//     destViewController.medicinedataedit =medname;
    }
   }
@end
