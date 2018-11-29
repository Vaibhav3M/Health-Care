//
//  GoodToKnowViewController.m
//  PatientHealth
//
//  Created by VM on 10/25/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "GoodToKnowViewController.h"

@interface GoodToKnowViewController ()

@end

@implementation GoodToKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readPDF];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma read pdf file
*/
-(void) readPDF{
    NSURL *targetURL = [[NSBundle mainBundle] URLForResource:@"goodToKnowFileText" withExtension:@"pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    self.webView.scalesPageToFit=YES;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}
@end
