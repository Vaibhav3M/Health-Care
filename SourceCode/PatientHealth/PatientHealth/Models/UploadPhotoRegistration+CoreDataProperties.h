//
//  UploadPhotoRegistration+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "UploadPhotoRegistration+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UploadPhotoRegistration (CoreDataProperties)

+ (NSFetchRequest<UploadPhotoRegistration *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
