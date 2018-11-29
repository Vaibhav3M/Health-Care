//
//  ContactsViewController.m
//  newContact
//
//  Created by VM on 27/09/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "ContactsViewController.h"
#import <Contacts/Contacts.h>
#import "ContactObject.h"
#import "AppDelegate.h"

@interface ContactsViewController ()
@end

@implementation ContactsViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchContactsandAuthorization];
    [self.table1 registerNib:[UINib nibWithNibName:@"DiscussionTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiscussionTableViewCell"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    
    
}

-(void)dismissController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchContactsandAuthorization
{
    self.arrayTableData = [[NSMutableArray alloc]init];
    self.contactArray = [[NSMutableArray alloc]init];
    // Request authorization to Contacts
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES)
        {
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
            NSString *containerId = store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error)
            {
                NSLog(@"error fetching contacts %@", error);
            }
            else
            {
                NSString *phone;
                NSString *fullName;
                NSString *firstName;
                NSString *lastName;
                UIImage *profileImage;
                NSMutableArray *contactNumbersArray = [[NSMutableArray alloc]init];
                for (CNContact *contact in cnContacts) {
                    // copy data to my custom Contacts class.
                    ContactObject *co = [ContactObject new] ;
                    firstName = contact.givenName;
                    lastName = contact.familyName;
                    if (lastName == nil) {
                        fullName=[NSString stringWithFormat:@"%@",firstName];
                    }else if (firstName == nil){
                        fullName=[NSString stringWithFormat:@"%@",lastName];
                    }
                    else{
                        fullName=[NSString stringWithFormat:@"%@ %@",firstName,lastName];
                    }
                    co.coName = fullName;
                    UIImage *image = [UIImage imageWithData:contact.imageData];
                    if (image != nil) {
                        profileImage = image;
                    }else{
                        profileImage = [UIImage imageNamed:@"person-icon.png"];
                    }
                    co.coImage = profileImage;
                    for (CNLabeledValue *label in contact.phoneNumbers) {
                        phone = [label.value stringValue];
                        if ([phone length] > 0) {
                            [contactNumbersArray addObject:phone];
                        }
                        co.coNumber = phone;
                    }
                    NSDictionary* personDict = [[NSDictionary alloc] initWithObjectsAndKeys: fullName,@"fullName",profileImage,@"userImage",phone,@"PhoneNumbers", nil];
                    [self.arrayTableData addObject:[NSString stringWithFormat:@"%@",[personDict objectForKey:@"fullName"]]];
                    [self.contactArray addObject:co];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_table1 reloadData];
                });
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrayTableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.arrayTableData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    
    if(![self fetchContactList]){
        NSMutableArray *arrayOfVC = [[[SlideNavigationController sharedInstance] viewControllers]mutableCopy];
        [arrayOfVC removeObjectAtIndex:2];
        [[SlideNavigationController sharedInstance] setViewControllers:arrayOfVC animated:NO];
    }
    NSLog(@"didSelectRowAtIndexPath : %@" ,[NSString stringWithFormat:@"%ld", indexPath.row]);
    ContactObject *co = _contactArray[indexPath.row];
    [self saveContact:co];
    
    
    NSLog(@"Value for name : %@" ,co.coName);
}

-(void)saveContact:(ContactObject *)co{
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
        NSManagedObject *contact;
        contact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Contact"
                      inManagedObjectContext:context];
        [contact setValue:co.coName forKey:@"name"];
        [contact setValue:co.coNumber forKey:@"number"];
        NSData *dataImage = UIImageJPEGRepresentation(co.coImage, 0.0);
        [contact setValue:dataImage forKey:@"image"];
        
        NSError *error = nil;
        
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            if (_isFirstContact) {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ListedContactsViewController"];
                [[SlideNavigationController sharedInstance] pushViewController:vc animated:YES];
            }
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)fetchContactList{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    NSMutableArray *addedContacts = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    if([addedContacts count] > 0){
        return YES;
    }else{
        return NO;
    }
}

//- (NSManagedObjectContext *)managedObjectContext {
//    NSManagedObjectContext *context = nil;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    if ([delegate performSelector:@selector(managedObjectContext)]) {
//        context = [delegate managedObjectContext];
//    }
//    return context;
//}

@end
