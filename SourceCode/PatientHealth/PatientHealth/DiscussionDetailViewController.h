//
//  DiscussionDetailViewController.h
//  PatientHealth
//
//  Created by VM  on 21/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussionDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblDiscussionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscussionDateTime;


@property (weak, nonatomic) IBOutlet UITableView *tableViewDiscussionDetail;


//for fetching data from selected Discussion

@property(strong,nonatomic) NSString *strDiscussionTitle;
@property(strong,nonatomic) NSString *strDiscussionDateTime;
@property(strong,nonatomic) NSArray *arrayDiscussionContent;

@end
