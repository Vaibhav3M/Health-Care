//
//  Connection.h
//  PatientHealth
//

#import <Foundation/Foundation.h>
#import "Header.h"
@interface Connection : NSObject

typedef void (^CompletionBlock) (id obj, NSError * err);

@property (nonatomic,copy)CompletionBlock block;
@property (nonatomic,strong) NSURLSession *session;
+ (id)sharedInstance;
-(void)requestWithURLFolder:(NSString*)folderName andParameter:(NSDictionary*)paramDict withCompletionBlock:(CompletionBlock)block;
-(void)offlineDummyDataWithFileName:(NSString*)jsonFileName withCompletionBlock:(CompletionBlock)block;
@end
