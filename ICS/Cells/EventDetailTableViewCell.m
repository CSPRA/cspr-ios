//
//  EventDetailTableViewCell.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "EventDetailTableViewCell.h"
#import "UIView+ICSAdditions.h"
#import "Cancer.h"

@interface EventDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *eventType;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cancerName;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;

@end

@implementation EventDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews {
  [super layoutSubviews];
  [self.contentView ICSViewBackgroungColor];
  [self initialSetup];
}
- (void)initialSetup {
//  self.eventType.text = _event.eventType;
//  self.eventNameLabel.text = _event.eventName;
//  self.startDate.text = [NSString stringWithFormat:@"%@",_event.startingDate];
//  self.endDate.text = [NSString stringWithFormat:@"%@",_event.endingDate];
  NSDictionary *cancerDict = [self.eventDict valueForKey:kCancerType];
  NSDictionary *formDict = [self.eventDict valueForKey:@"form"];
  self.eventNameLabel.text = [self.eventDict valueForKey:kEventName];
  self.eventType.text = [self.eventDict valueForKey:kEventType];
  self.startDate.text = [self.eventDict valueForKey:kStartingDate];
  self.endDate.text = [self.eventDict valueForKey:kEndingDate];
  self.cancerName.text = [cancerDict valueForKey:kCancerName];
  self.textView.text = [cancerDict valueForKey:kCancerDescription];

}

- (void)prepareForReuse {
  [super prepareForReuse];
}
@end
