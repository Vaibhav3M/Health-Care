//
//  HTTPHandler.h
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPHandler : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    NSURL *Url;
    
    NSDictionary *tmp;
    NSString *m_response;
    
    NSInteger m_servicecall;



}


@property (nonatomic, retain) NSString *registerUserName;
@property (nonatomic, retain) NSString *registerAge;
@property (nonatomic, retain) NSString *registerEmail;
@property (nonatomic, retain) NSString *registerPassword;
@property (nonatomic, retain) NSString *registerConfirmPassword;
@property (nonatomic, retain) NSString *BloodGp;
@property (nonatomic, retain) NSString *Height;
@property (nonatomic, retain) NSString *Weight;
@property (nonatomic, retain) NSString *Gender;
@property (nonatomic, retain) NSString *Allergies;
@property (nonatomic, retain) NSString *Smoking;
@property (nonatomic, retain) NSString *Drinking;
@property (nonatomic, retain) NSString *disease;

@property (nonatomic, retain) NSString *CheckDiabeties;
@property (nonatomic, retain) NSString *BloodPressure;
@property (nonatomic, retain) NSString *HeartCondtn;
@property (nonatomic, retain) NSString *Asthma;

@property (nonatomic, retain) NSString *httpvideoID;


-(void)registration;
-(NSData *)getJsonPostData;
-(void)Category;
-(void)Videos:(NSString *)videoID;
-(void)PDFList;


@end
