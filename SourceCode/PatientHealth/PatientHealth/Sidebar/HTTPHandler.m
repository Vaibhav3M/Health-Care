//
//  HTTPHandler.m
//  PatientHealth
//
//  Created by VM  on 21/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "HTTPHandler.h"
#import "Header.h"
//#define kServerURL @"http://192.168.2.2:8089/"
#define kServerURL @"http://10.200.204.120:8089/"

//#define kServerURL @"http://127.0.0.1:8089/"
//NSObject *serverURL1=@"http://localhost:8089/";
//NSObject *serverURL1=@"http://192.168.2.2:8080/";


@implementation HTTPHandler


@synthesize registerUserName,registerAge,registerEmail,registerPassword,registerConfirmPassword,BloodGp,Height,Weight,Gender,Allergies,Smoking,Drinking,disease,CheckDiabeties,BloodPressure,HeartCondtn,Asthma,httpvideoID;


#define PROD
-(NSString *)getserverIP
{
#ifdef PROD
    return kServerURL;
    
#else
    NSString *serverIP=[NSString stringWithFormat:@"http://%@:8080/",[[NSUserDefaults standardUserDefaults]
                                                                      stringForKey:@"ServerIPAddress"]];
    
    return serverIP;
#endif
    return nil;
}

-(NSData *)getJsonPostData{
    
    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc] init];
    //BasicInfo details
    NSMutableDictionary *dictBasic = [NSMutableDictionary new];
//    [dictBasic setValue:registerUserName forKey:@"UserName"];
//    [dictBasic setValue:registerAge forKey:@"Age"];
//    [dictBasic setValue:registerPassword forKey:@"SetPassword"];
//    [dictBasic setValue:registerConfirmPassword forKey:@"Confirmpassword"];
//    [dictBasic setValue:BloodGp forKey:@"BloodGroup"];
//    [dictBasic setValue:Height forKey:@"Height"];
//    [dictBasic setValue:Weight forKey:@"Weight"];
//    [dictBasic setValue:Gender forKey:@"Gender"];
//    [dictBasic setValue:Allergies forKey:@"Allergies"];
//    [dictBasic setValue:Smoking forKey:@"Smoking"];

    [dictBasic setValue:@"A" forKey:@"UserName"];
    [dictBasic setValue:@"1" forKey:@"Age"];
    [dictBasic setValue:@"1" forKey:@"SetPassword"];
    [dictBasic setValue:@"1" forKey:@"Confirmpassword"];
    [dictBasic setValue:@"1" forKey:@"BloodGroup"];
    [dictBasic setValue:@"1" forKey:@"Height"];
    [dictBasic setValue:@"1" forKey:@"Weight"];
    [dictBasic setValue:@"1" forKey:@"Gender"];
    [dictBasic setValue:@"1" forKey:@"Allergies"];
    [dictBasic setValue:@"1" forKey:@"Smoking"];
    NSMutableDictionary *dictDisease = [[NSMutableDictionary alloc] init];
    [dictDisease setValue:[NSNumber numberWithBool:YES]
                forKey:@"Diabeties"];
    [dictBasic setValue:dictDisease forKey:@"Diseases"];
    
    //MedInfo details
    NSMutableDictionary *dictMed = [NSMutableDictionary new];
    [dictMed setValue:@"1" forKey:@"Medicine1"];
    [dictMed setValue:@"1" forKey:@"Medicine2"];
    
    //Photo details
    NSMutableDictionary *dictPhoto = [NSMutableDictionary new];
    [dictPhoto setValue:@"1" forKey:@"ProfilePic"];
    
    
    [finalDict setValue:[NSArray arrayWithObject:dictBasic] forKey:@"BasicInfo"];
    [finalDict setValue:[NSArray arrayWithObject:dictMed] forKey:@"MedInfo"];
    [finalDict setValue:[NSArray arrayWithObject:dictPhoto] forKey:@"Uploadphoto"];
    
    
    NSData *postData =  [NSJSONSerialization dataWithJSONObject:finalDict options:0 error:nil];
    return postData;
    
}



-(void)registration
{
    //HTTPHandler *obj =[[HTTPHandler  alloc] init];
    m_servicecall = 1;
//    NSDictionary *tmpDict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                         @"HelloTest", @"UserName",
//                         nil];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:tmpDict options:0 error:nil];

    NSData *postData = [self getJsonPostData];
    NSString *postURL = [NSString stringWithFormat:@"%@registration",[self getserverIP]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:postURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:postData];
    
    
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Reponse data %@", response);
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
    

    
//
//    NSString *data = [NSString stringWithFormat:@"%@signup2?username=%@&password=%@&email=%@&phoneNumber=%@&age=%@&gender=M&streetName=VIP Road&cityName=Kolkata&stateName=West Bengal&countryName=India&secQ1=What is your place of Birth&secAns1=Krishnanagar&secQ2=What is your favourite colour&secAns2=Blue",[self getserverIP],registerUserName,registerPassword,registerEmail,registerAge];
    
        //NSLog(@"register data is  %@",postData);
        //Url = [NSURL URLWithString:[post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create the request.
   // NSURLRequest *request1 = [NSURLRequest requestWithURL:Url];
    
    // Create url connection and fire request
//   NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [conn start];
    
    
}


-(void)Category{
    m_servicecall = 2;
    NSString *data = [NSString stringWithFormat:@"%@Category",[self getserverIP]];
    
    NSLog(@"Category data is  %@",data);
    Url = [NSURL URLWithString:[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    
    // Create url connection and fire request
//    NSURLConnection *CategoryConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

   
   
     //NSError *error;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Reponse data %@", response);
    
        
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        NSData *jsonData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        
       
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"CategoryNotification" object:self userInfo:jsonDic];
    
    }] resume];

}
-(void)Videos:(NSString *)videoID{


    m_servicecall = 3;
    NSString *data = [NSString stringWithFormat:@"%@Videos",[self getserverIP]];
    
    NSLog(@"Video data is  %@",data);
    Url = [NSURL URLWithString:[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    
    // Create url connection and fire request
    //    NSURLConnection *CategoryConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    //NSError *error;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Reponse data %@", response);
        
        
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        NSData *jsonData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"VideoNotification" object:self userInfo:jsonDic];
        
    }] resume];




}



-(void)PDFList{
    m_servicecall = 4;
    NSString *data = [NSString stringWithFormat:@"%@PDFList",[self getserverIP]];
    
    NSLog(@"PDF data is  %@",data);
    Url = [NSURL URLWithString:[data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    
    // Create url connection and fire request
    //    NSURLConnection *CategoryConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    //NSError *error;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Reponse data %@", response);
        
        
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        NSData *jsonData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"PDFListNotification" object:self userInfo:jsonDic];
        
    }] resume];
    
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
    
    _responseData = [[NSMutableData alloc] init];
        [_responseData setLength:0];
    
        NSLog(@"did recieve response");

}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
    NSLog(@"did recieve data");
    [self sessionDidfinishLoading];
    
}


- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler{
    
}



- (void)sessionDidfinishLoading{
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString *response = [NSString stringWithFormat:@"%@",_responseData];
    
    
    NSLog(@"%@",response);
    
    NSLog(@"did finish loading");
    
    
    
    m_response   = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSError *error;
    
    
    
    tmp  = [NSJSONSerialization JSONObjectWithData:_responseData
                                           options:NSJSONReadingMutableContainers
                                             error:&error];
    NSLog(@"%@",tmp);

    
    
    NSDictionary* userInfo = @{@"total":m_response};
    
    
    if ( m_servicecall == 2)
    {
        // Send all call to login view controller
        
        
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"CategoryNotification" object:self userInfo:userInfo];
        
         }
    
    else if (m_servicecall == 3){
    
    
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"VideoNotification" object:self userInfo:userInfo];
        
    }
    else if (m_servicecall == 4){
        
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"PDFListNotification" object:self userInfo:userInfo];
        
    }

}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if (error != nil)
    {
        NSLog(@"Error in service call");
    }
}

@end
