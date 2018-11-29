//
//  Connection.m
//  PatientHealth
//

#import "Connection.h"

@implementation Connection

+ (id)sharedInstance {
    static Connection *sharedMyModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
        
    });
    return sharedMyModel;
}

-(void)requestWithURLFolder:(NSString*)folderName andParameter:(NSDictionary*)paramDict withCompletionBlock:(CompletionBlock)block{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URL,folderName]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:APPLICATION_ID forHTTPHeaderField:APPLICATION_ID_KEY];
    [request setValue:SECRET_KEY_VALUE forHTTPHeaderField:SECRET_KEY_KEY];
    [request setValue:CONTENT_TYPE_VALUE forHTTPHeaderField:CONTENT_TYPE_KEY];
    [request setValue:APPLICATION_TYPE_VALUE forHTTPHeaderField:APPLICATION_TYPE_KEY];
    
    //NSDictionary *bodyDict = @{@"login" : [paramDict valueForKey:@"Username"] , @"password" : [paramDict valueForKey:@"Password"]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramDict options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = jsonData;
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"dataSrt : %@",dataStr);
            NSError *jsonError = nil;
            NSDictionary *returnedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            block(returnedData,nil);
        }else{
            block(nil,error);
        }
       
    }];
    
    [task resume];
}

-(void)offlineDummyDataWithFileName:(NSString*)jsonFileName withCompletionBlock:(CompletionBlock)block{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"];
    if (!jsonFilePath) {
        // ... do something ...
    }
    
    NSError *error = nil;
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:jsonFilePath];
    [inputStream open];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithStream: inputStream
                                                      options:kNilOptions
                                                        error:&error];
    [inputStream close];
    if (error) {
        block(nil,error);
    }else
        block(jsonObject,nil);
}

@end
