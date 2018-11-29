//
//  DiscussionDetailViewController.m
//  PatientHealth
//
//  Created by VM  on 21/10/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "DiscussionDetailViewController.h"
#import "DiscussionDetailTableViewCell.h"

@interface DiscussionDetailViewController ()

@end

@implementation DiscussionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lblDiscussionTitle.text=_strDiscussionTitle;
    _lblDiscussionDateTime.text=_strDiscussionDateTime;
    
    
    
    
    [self.tableViewDiscussionDetail registerNib:[UINib nibWithNibName:@"DiscussionDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiscussionDetailTableViewCell"];
    

    
    self.tableViewDiscussionDetail.delegate = self;
    self.tableViewDiscussionDetail.dataSource = self;
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _arrayDiscussionContent.count;
    //return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscussionDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscussionDetailTableViewCell" forIndexPath:indexPath];

   
    cell.lblDiscussionDetails.text=_arrayDiscussionContent[indexPath.row];
        return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.view.frame.size.height/5;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    
    
}


@end
