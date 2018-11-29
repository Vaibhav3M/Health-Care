//
//  Entity+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Entity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSNumber *userId;
@property (nullable, nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
