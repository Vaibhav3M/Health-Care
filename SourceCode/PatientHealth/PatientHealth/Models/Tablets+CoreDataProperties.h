//
//  Tablets+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Tablets+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tablets (CoreDataProperties)

+ (NSFetchRequest<Tablets *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *tabselected;

@end

NS_ASSUME_NONNULL_END
