//
//  WeightReport+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "WeightReport+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface WeightReport (CoreDataProperties)

+ (NSFetchRequest<WeightReport *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSNumber *weight;
@property (nullable, nonatomic, copy) NSString *unit;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
