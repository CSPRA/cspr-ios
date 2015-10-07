//
//  FullImageContainerView.m
//  ICS
//
//  Created by aam-fueled on 08/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "FullImageContainerView.h"

@implementation FullImageContainerView

+ (FullImageContainerView *)newView {
  FullImageContainerView *imageFullView =
  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FullImageContainerView class])
                                owner:nil options:nil][0];
  return imageFullView;
}


- (void)awakeFromNib {
  [super awakeFromNib];
}

- (IBAction)crossTapped:(id)sender {
  [UIView animateWithDuration:kAnimationFactor
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     
                     if ([self.delegate respondsToSelector:@selector(didTappedCrossButton:)]) {
                       [self.delegate didTappedCrossButton:self];
                     }
                     self.alpha = kMinAlpha;
                   } completion:nil];
}



@end
