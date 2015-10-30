//
//  Question.h
//  
//
//  Created by aam-fueled on 16/10/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APIInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface Question : NSManagedObject<RestKitAdditions>

- (Question*)fetchQuestion;

@end

NS_ASSUME_NONNULL_END

#import "Question+CoreDataProperties.h"
