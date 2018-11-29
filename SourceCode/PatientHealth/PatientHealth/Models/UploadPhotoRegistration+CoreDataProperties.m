//
//  UploadPhotoRegistration+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "UploadPhotoRegistration+CoreDataProperties.h"

@implementation UploadPhotoRegistration (CoreDataProperties)

+ (NSFetchRequest<UploadPhotoRegistration *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UploadPhotoRegistration"];
}


@end
