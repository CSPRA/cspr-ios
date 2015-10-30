//
//  NSDate+ICSFormattedString.m
//  ICS
//
//  Created by Aqsa on 30/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "NSDate+ICSFormattedString.h"

@implementation NSDate (ICSFormattedString)
- (NSString *)formattedDateString {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  return [dateFormatter stringFromDate:self];
}

@end
