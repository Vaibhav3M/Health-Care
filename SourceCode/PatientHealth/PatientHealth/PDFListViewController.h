//
//  PDFListViewController.h
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPHandler.h"


@interface PDFListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *resultP;


}

@property (strong, nonatomic) IBOutlet UITableView *tableViewPDFList;
@property (strong, nonatomic) IBOutlet UILabel *lblPdfName;


-(void)dataLoad;

@end
