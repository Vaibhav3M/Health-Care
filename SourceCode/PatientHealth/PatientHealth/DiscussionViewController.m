//
//  DiscussionViewController.m
//  PatientHealth
//
//  Created by VM on 10/13/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "DiscussionViewController.h"
#import "DiscussionTableViewCell.h"
#import "Connection.h"
#import "DiscussionMainModel.h"
#import "DiscussionDetailViewController.h"
#import "SlideNavigationController.h"

@interface DiscussionViewController ()

@end

@implementation DiscussionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblDiscussionMain registerNib:[UINib nibWithNibName:@"DiscussionTableViewCell" bundle:nil] forCellReuseIdentifier:@"DiscussionTableViewCell"];
    [self getData];
    
}

-(void)getData{
    self.discussionMainMutableArray = [[NSMutableArray alloc]init];
    
    [[Connection sharedInstance] offlineDummyDataWithFileName:@"discussionMain" withCompletionBlock:^(id obj, NSError *err) {
        dispatch_async(dispatch_get_main_queue(),^ {
            if(err == nil){
                self.discussionMainDataArray = (NSArray *)obj;
//                NSLog(@"Count : %lu",(unsigned long)self.discussionMainDataArray.count);
                NSInteger looper = self.discussionMainDataArray.count;
                
                for(int i = 0;i < looper;i++){
                    DiscussionMainModel *model = [[DiscussionMainModel alloc]init];
                    NSObject *modelObject = self.discussionMainDataArray[i];
                    model.strDiscussionTitle = [modelObject valueForKey:@"discussionTitle"];
                    model.strDate = [modelObject valueForKey:@"date"];
                    model.strNumberOfPeople = [modelObject valueForKey:@"numberOfPeople"];
                    model.strNumberOfMessages = [modelObject valueForKey:@"numberOfMessages"];
                    [self.discussionMainMutableArray addObject:model];
                }
//                NSLog(@"Count Mutable Array: %lu",(unsigned long)self.discussionMainMutableArray.count);
                [self.tblDiscussionMain reloadData];
            }
        });
    }];
}

-(void) viewWillAppear{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.discussionMainMutableArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscussionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscussionTableViewCell"];
    DiscussionMainModel *model = (DiscussionMainModel *)self.discussionMainDataArray[indexPath.row];
    
    cell.lblDiscussionTitle.text = [model valueForKey:@"discussionTitle"];
    cell.lblDateTime.text = [model valueForKey:@"date"];
    cell.lblPeopleCount.text = [model valueForKey:@"numberOfPeople"];
    cell.lblMessageCount.text = [model valueForKey:@"numberOfMessages"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    NSLog(@"didSelectRowAtIndexPath : %@" ,[NSString stringWithFormat:@"%ld", indexPath.row]);
    
    DiscussionMainModel *model = (DiscussionMainModel *)self.discussionMainDataArray[indexPath.row];
    DiscussionDetailViewController *discussionDetailViewController=[[ DiscussionDetailViewController alloc]init];
    
    discussionDetailViewController.strDiscussionTitle=[model valueForKey:@"discussionTitle"];
    discussionDetailViewController.strDiscussionDateTime=[model valueForKey:@"date"];
    NSArray *contentDetails=[model valueForKey:@"contentarray"];
    discussionDetailViewController.arrayDiscussionContent=[contentDetails valueForKey:@"content"];
    
    [[SlideNavigationController sharedInstance] pushViewController:discussionDetailViewController animated:YES];
}

-(void)parseData{
    
}

@end
