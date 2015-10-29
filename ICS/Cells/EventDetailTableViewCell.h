//
//  EventDetailTableViewCell.h
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@interface EventDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;

@property (nonatomic,strong) Event * event;

@end
