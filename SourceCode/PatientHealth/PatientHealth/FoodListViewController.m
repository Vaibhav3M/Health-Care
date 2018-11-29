//
//  FoodListViewController.m
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "FoodListViewController.h"

@interface FoodListViewController ()

@end

@implementation FoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.foodListTableView setHidden:YES];
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Food"];
    self.food = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if([self.food count] > 0){
        [self.lblNoFoodData setHidden:YES];
        [self.foodListTableView setHidden:NO];
        [self.foodListTableView reloadData];
    }else{
        [self.lblNoFoodData setHidden:NO];
        [self.foodListTableView setHidden:YES];
    }

    //[self.foodListTableView reloadData];
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
    return self.food.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSManagedObject *food = [self.food objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@" ,[food valueForKey:@"foodname"]]];
    

    
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
        [context deleteObject:[self.food objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.food removeObjectAtIndex:indexPath.row];
        [self.foodListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelBtnFood:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editFoodBtn:(id)sender {
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFoodDetail"]) {
        NSManagedObject *editdatafood = [self.food objectAtIndex:[[self.foodListTableView indexPathForSelectedRow] row]];
        FoodDetailViewController *destViewController = segue.destinationViewController;
        destViewController.fooddataedit = editdatafood;

    }
}
@end
