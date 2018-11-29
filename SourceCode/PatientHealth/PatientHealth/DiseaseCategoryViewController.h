//
//  DiseaseCategoryViewController.h
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPHandler.h"


@interface DiseaseCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    
    NSMutableDictionary *resultC;
    
    
    
}


@property (strong, nonatomic) IBOutlet UITableView *tableViewCategory;

-(void)dataLoad;


@end
