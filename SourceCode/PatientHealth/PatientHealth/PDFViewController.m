//
//  PDFViewController.m
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@property(strong,nonatomic) NSArray* PdfArray;


@end

@implementation PDFViewController

{
    
    NSDictionary *PdfDataRecieved;
    NSDictionary *dataPdf;
    
    
    NSArray *PdfFile;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSString *path = [[NSBundle mainBundle]pathForResource:@"health1" ofType:@"pdf"];
    //NSURL *url = [NSURL fileURLWithPath:path];
    NSURL *url = [[NSBundle mainBundle]URLForResource:_Pdffile withExtension:@"pdf"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webViewPdf loadRequest:request];
    [_webViewPdf setScalesPageToFit:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSendMail:(id)sender {
    
    
    if ([MFMailComposeViewController canSendMail])
    {
        if ([_txtFieldEnterMailAddress.text isEqualToString:@""]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Opps" message:@"Please Enter E-mail address" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                
            }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            
            
            NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
            
            
            if ([emailTest evaluateWithObject:_txtFieldEnterMailAddress.text] == NO){
                
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please Enter Valid E-mail Address" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    //  NSLog(@"You pressed button OK");
                    
                }];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else{
                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                mail.mailComposeDelegate = self;
                [mail setSubject:@"Sending test pdf"];
                
                NSURL *targetURL = [[NSBundle mainBundle] URLForResource:@"testpdf" withExtension:@"pdf"];
                
                pdfData = [NSData dataWithContentsOfURL:targetURL];
                
                
                [mail addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"TestPDF"];
                
                
                [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
                [mail setToRecipients:@[_txtFieldEnterMailAddress.text]];
                
                
                [self presentViewController:mail animated:YES completion:NULL];
            }
        }
        
        
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error sending mail" message:@"%@"delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        [errorAlert setMessage:@"This device cannot sending mail"];
        
    }
    
    
}


@end
