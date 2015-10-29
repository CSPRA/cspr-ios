//
//  EventDetailTableViewCell.m
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "EventDetailTableViewCell.h"

@implementation EventDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initialSetup {
  
}
- (void)setViewForEvent:(Event *)event{

}

- (void)setEvent:(Event *)event{
  _event = event;
  [self initialSetup];
  [self setViewForEvent:event];
}
@end
