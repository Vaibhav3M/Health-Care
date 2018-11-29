//
//  Food+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Food+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Food (CoreDataProperties)

+ (NSFetchRequest<Food *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *enddate;
@property (nullable, nonatomic, copy) NSString *foodname;
@property (nullable, nonatomic, copy) NSString *input;
@property (nullable, nonatomic, copy) NSString *startdate;

@end

NS_ASSUME_NONNULL_END
