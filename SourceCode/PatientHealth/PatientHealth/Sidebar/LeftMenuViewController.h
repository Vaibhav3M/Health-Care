//
//  LeftMenuViewController.h
//  loginSample
//
//  Created by AthithChandra on 22/07/16.
//  Copyright © 2016 Vaibhav . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuTableViewCell.h"



@interface LeftMenuViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@end
