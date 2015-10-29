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

@property (nonatomic,strong) Event * event;
@property (nonatomic, strong) NSDictionary *eventDict;
@end
