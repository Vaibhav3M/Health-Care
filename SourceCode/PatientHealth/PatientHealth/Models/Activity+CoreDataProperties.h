//
//  Activity+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Activity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Activity (CoreDataProperties)

+ (NSFetchRequest<Activity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *activity;
@property (nullable, nonatomic, copy) NSString *current;
@property (nullable, nonatomic, copy) NSString *endDate;
@property (nullable, nonatomic, copy) NSString *startDate;
@property (nullable, nonatomic, copy) NSString *target;

@end

NS_ASSUME_NONNULL_END
