//
//  DiscussionMainModel.h
//  PatientHealth
//
//  Created by VM on 10/14/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscussionMainModel : NSObject
@property (strong, nonatomic) NSString *strDiscussionTitle;
@property (strong, nonatomic) NSString *strDate;
@property (strong, nonatomic) NSString *strNumberOfPeople;
@property (strong, nonatomic) NSString *strNumberOfMessages;
//@property (strong, nonatomic) NSMutableDictionary<NSString* string, DiscussionMainModel *> *discussionMainModelList;
@end
