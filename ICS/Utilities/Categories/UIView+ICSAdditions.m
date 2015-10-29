//
//  UIView+ICSAdditions.m
//  ICS
//
//  Created by Aqsa on 29/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "UIView+ICSAdditions.h"
#import <QuartzCore/QuartzCore.h>

#define kBorderColor [UIColor colorWithRed:245.0f/255 green:166.0/255 blue:36.0/255 alpha:1.0].CGColor

@implementation UIView (ICSAdditions)

- (void)ICSViewBackgroungColor {
  self.backgroundColor = [UIColor whiteColor];
  self.layer.borderWidth = 2.0;
  self.layer.borderColor = kBorderColor;
  self.layer.shadowColor =  kBorderColor;
  self.layer.shadowRadius = 10;
  
}
@end
