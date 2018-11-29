//
//  ContactsViewController.h
//  newContact
//
//  Created by VM on 27/09/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactObject.h"

@interface ContactsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *table1;
@property (strong,nonatomic) NSMutableArray *arrayTableData;
@property (strong, nonatomic) NSMutableArray *contactArray;
@property (assign, nonatomic) BOOL isFirstContact; // to detect if the contact being added is for first time.
-(void)saveContact:(ContactObject *)co;
@end
