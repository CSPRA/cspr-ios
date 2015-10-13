//
//  CustomFormButtonCell.h
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "XLFormButtonCell.h"

extern NSString * const XLFormRowDescriptorTypeCustomButton;

typedef NS_ENUM(NSUInteger, CustonFormButtonType) {
  kButtonTypeAssignDoctor,
  kButtonTypeAddRow,
  kButtonTypeRating
};

@interface CustomFormButtonCell : XLFormButtonCell

@property (weak, nonatomic) IBOutlet UIImageView *buttonImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) CustonFormButtonType buttonType;
@end
