//
//  PDFViewController.h
//  PatientHealth
//
//  Created by VM  on 11/09/1938 Saka.
//  Copyright © 1938 Saka vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface PDFViewController : UIViewController
{
    
    NSData *pdfData;
}
@property (strong, nonatomic) IBOutlet UIWebView *webViewPdf;
@property (strong,nonatomic) NSString *Pdffile;


@property (strong, nonatomic) IBOutlet UITextField *txtFieldEnterMailAddress;

- (IBAction)btnSendMail:(id)sender;

@end
