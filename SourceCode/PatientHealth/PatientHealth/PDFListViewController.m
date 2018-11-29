//
//  PDFListViewController.m
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import "PDFListViewController.h"
#import "PDFViewController.h"


@interface PDFListViewController ()


@property(strong,nonatomic) NSArray* PdfListArray;


@end

NSString *httpLink4;


@implementation PDFListViewController
{
    NSDictionary *PdfDataRecieved;
    NSDictionary *dataPdf;
    NSArray *PdfList;
    NSString *pdfID;
    NSDictionary *errorPDF;
    NSString *errorCodePDF;
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewPDFList.delegate = self;
    self.tableViewPDFList.dataSource = self;
    
#ifdef DEMO
    {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    PdfDataRecieved = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSArray *items = [PdfDataRecieved valueForKeyPath:@"service_response"];
    NSLog(@"%@",items);
    NSEnumerator *enumerator = [items objectEnumerator];
    NSDictionary* item;
    while (item = (NSDictionary*)[enumerator nextObject]) {
        
    }
    [self dataLoad];
    [self.tableViewPDFList reloadData];
    
    }
#else
    {

    HTTPHandler *object = [[HTTPHandler alloc] init];
    
    [object PDFList];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(recivingMethodOnListnerE:)
     name:@"PDFListNotification"
     object:nil];
    
    //        [self.tableViewCategory registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"CategoryCell"];
    //
    
    
    
    [self.tableViewPDFList reloadData];


}

    
#endif
}


-(void)recivingMethodOnListnerE: (NSNotification*) n{
    
    PdfDataRecieved = n.userInfo;
    
    NSLog(@"%@",PdfDataRecieved);
    
    resultP = ([PdfDataRecieved valueForKey:@"error_response"]);
    errorPDF = ([resultP valueForKey:@"error"]);
    errorCodePDF = ([errorPDF valueForKey:@"code"]);
    
    if ([errorCodePDF isEqualToString:@""]) {
        
        NSLog(@"%@",resultP);
        
        [self dataLoad];
        [self.tableViewPDFList reloadData];
    }
    else{
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"%@"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        [errorAlert setMessage:errorCodePDF];
        
        
    }
}


-(void)dataLoad
{
    
    httpLink4 =@"";
    
    dataPdf = [PdfDataRecieved valueForKey:@"service_response"];
    PdfList = [dataPdf valueForKey:@"pdfName"];
    
    self.PdfListArray = PdfList;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViewPDFList reloadData];
    });
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataPdf.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString *CellIdentifier = @"PdfCell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    //NSManagedObject *food = [self.food objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.PdfListArray objectAtIndex:indexPath.row];
    
    
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PdfCell"];
    
    // cell.textLabel.text = [self.PdfListArray objectAtIndex:indexPath.row];
    return  cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PDFViewController *controller4;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];// like Main.storyboard for used "Main"
    controller4 = [storyboard instantiateViewControllerWithIdentifier:@"PDFViewController"];
    [self.navigationController pushViewController:controller4 animated:YES];
    controller4.Pdffile=self.PdfListArray[indexPath.row];
    
}







@end
