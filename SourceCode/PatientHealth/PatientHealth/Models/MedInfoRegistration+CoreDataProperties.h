//
//  MedInfoRegistration+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "MedInfoRegistration+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MedInfoRegistration (CoreDataProperties)

+ (NSFetchRequest<MedInfoRegistration *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *doseTimes;
@property (nullable, nonatomic, copy) NSNumber *medId;
@property (nullable, nonatomic, copy) NSString *medName;

@end

NS_ASSUME_NONNULL_END
