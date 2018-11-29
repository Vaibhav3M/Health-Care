//
//  ListedContactsViewController.m
//  PatientHealth
//
//  Created by VM on 10/17/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//
#import "ContactObject.h"
#import "AppDelegate.h"
#import "ListedContactsViewController.h"
#import "EmergencyContactTableViewCell.h"

@interface ListedContactsViewController () <SwipeableCellDelegate> {
    NSMutableArray *_objects;
}
@property (nonatomic, strong) NSMutableArray *cellsCurrentlyEditing;
@end

@implementation ListedContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objects = [NSMutableArray array];
    self.cellsCurrentlyEditing = [NSMutableArray array];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    _objects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tblContactList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmergencyContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    NSManagedObject *contactObject = [_objects objectAtIndex:indexPath.row];
    cell.lblFullName.text = [NSString stringWithFormat:@"%@ ", [contactObject valueForKey:@"name"]];
    cell.lblPhoneNumber.text = [NSString stringWithFormat:@"%@ ", [contactObject valueForKey:@"number"]];
    [cell.button1.layer setValue:indexPath forKey:@"indexPath"];
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
        [cell openCell];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
        [context deleteObject:[_objects objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [_objects removeObjectAtIndex:indexPath.row];
        [self.tblContactList deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - SwipeableCellDelegate

- (void)closeModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cellDidOpen:(UITableViewCell *)cell
{
    NSIndexPath *currentEditingIndexPath = [self.tblContactList indexPathForCell:cell];
    [self.cellsCurrentlyEditing addObject:currentEditingIndexPath];
}

- (void)cellDidClose:(UITableViewCell *)cell
{
    [self.cellsCurrentlyEditing removeObject:[self.tblContactList indexPathForCell:cell]];
}

- (void)btnDeleteAction:(UIButton *)delButton{
//    NSLog(@"Delete button clicked LIstedController" );
//    
//    NSIndexPath *delButtonTableIndex = [delButton.layer valueForKey:@"indexPath"];
//    NSLog(@"Delete button clicked index value %ld", (long)delButtonTableIndex.row );
//    NSInteger lastRow = [_objects count] - 1;
//    if (lastRow == -1)
//    {
//        return; // bail if there are no rows in the table
//    }
//    
//    [_tblContactList beginUpdates];
//    [_objects removeObjectAtIndex:delButtonTableIndex.row];
//    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow: delButtonTableIndex.row inSection:0];
//    NSManagedObject *contactObject = [_objects objectAtIndex:delButtonTableIndex.row];
//
//    [_tblContactList deleteRowsAtIndexPaths:@[delButtonTableIndex] withRowAnimation:UITableViewRowAnimationLeft];
//    [_tblContactList endUpdates];
//    [[self managedObjectContext] deleteObject:contactObject];
}

-(void)fetchEmergencyContactData{
    
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

- (IBAction)onAddMoreClicked:(id)sender {
    if([_objects count] >= 5){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Cannot add more than 5 contacts." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UINavigationController *vc = (UINavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactsNavigationController"];
        //[self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
@end
