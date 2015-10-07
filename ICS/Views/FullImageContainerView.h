//
//  FullImageContainerView.h
//  ICS
//
//  Created by aam-fueled on 08/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullImageContainerViewDelegate;

@interface FullImageContainerView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) id<FullImageContainerViewDelegate>delegate;
+ (FullImageContainerView *)newView;

@end

@protocol FullImageContainerViewDelegate <NSObject>

- (void)didTappedCrossButton: (FullImageContainerView*)fullView;

@end