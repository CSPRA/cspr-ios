//
//  RatingViewCell.h
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "XLFormBaseCell.h"
#import "RatingView.h"

extern NSString * const XLFormRowDescriptorTypeRate;

@protocol RatingViewCellDelegate;

@interface RatingViewCell : XLFormBaseCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *docInfoLabel;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *assignButton;
@property (weak, nonatomic) id<RatingViewCellDelegate>delegate;
@end


@protocol RatingViewCellDelegate <NSObject>

- (void)didAssignedDoctor: (RatingViewCell*)cell;

@end