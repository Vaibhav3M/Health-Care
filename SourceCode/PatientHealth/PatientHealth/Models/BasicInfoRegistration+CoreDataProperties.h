//
//  BasicInfoRegistration+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BasicInfoRegistration+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BasicInfoRegistration (CoreDataProperties)

+ (NSFetchRequest<BasicInfoRegistration *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *age;
@property (nullable, nonatomic, copy) NSString *allergies;
@property (nullable, nonatomic, copy) NSString *bloodGroup;
@property (nullable, nonatomic, copy) NSString *drinking;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nullable, nonatomic, copy) NSString *height;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *smoking;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *weight;

@end

NS_ASSUME_NONNULL_END
