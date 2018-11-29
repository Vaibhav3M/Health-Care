//
//  DiscussionViewController.h
//  PatientHealth
//
//  Created by VM on 10/13/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblDiscussionMain;
@property (strong, nonatomic) NSArray *discussionMainDataArray;
@property (strong, nonatomic) NSMutableArray *discussionMainMutableArray;
-(void)parseData;
-(void)getData;
@end
