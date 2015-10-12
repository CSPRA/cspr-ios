
//
//  RatingViewCell.m
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "RatingViewCell.h"

NSString * const XLFormRowDescriptorTypeRate = @"XLFormRowDescriptorTypeRate";

@implementation RatingViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
}

+ (void)load {
//  RatingViewCell *ratingViewCell =
//  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RatingViewCell class])
//                                owner:nil options:nil][0];
  [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([RatingViewCell class]) forKey:XLFormRowDescriptorTypeRate];
}


- (void)configure
{
  [super configure];
  
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self.ratingView addTarget:self action:@selector(rateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)update
{
  [super update];
  
  self.ratingView.value = [self.rowDescriptor.value floatValue];
  
  
  [self.ratingView setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}

#pragma mark - Events

-(void)rateChanged:(RatingView *)ratingView
{
  self.rowDescriptor.value = [NSNumber numberWithFloat:ratingView.value];
}

- (IBAction)assignButtonTapped:(UIButton *)sender {
}

@end
