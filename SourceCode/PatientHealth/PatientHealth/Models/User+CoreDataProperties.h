//
//  User+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *age;
@property (nullable, nonatomic, copy) NSString *bloodGroup;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *fullName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, retain) NSData *profilePhoto;
@property (nullable, nonatomic, copy) NSNumber *smoker;
@property (nullable, nonatomic, copy) NSNumber *userId;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSNumber *weight;
@property (nullable, nonatomic, retain) User *relationship;

@end

NS_ASSUME_NONNULL_END
