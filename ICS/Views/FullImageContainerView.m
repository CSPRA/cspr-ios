//
//  FullImageContainerView.m
//  ICS
//
//  Created by aam-fueled on 08/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "FullImageContainerView.h"
@interface FullImageContainerView ()
@property (strong, nonatomic) IBOutlet UISwitch *suspectSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
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

-(void)setupFullImageContainerWithDiagnosisPicture:(DiagnosisPhoto*)photo {
    [self.imageView setImage:photo.dpImage];
    [self.suspectSwitch setOn:photo.dpSuspectStatus animated:NO];
}

- (IBAction)deleteTapped:(id)sender {
    [UIView animateWithDuration:kAnimationFactor
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         if ([self.delegate respondsToSelector:@selector(fullView:didDeletePhotoWithAnimation:)]) {
                             [self.delegate fullView:self didDeletePhotoWithAnimation:NO];
                         }
                         self.alpha = kMinAlpha;
                     } completion:nil];
}

- (IBAction)crossTapped:(id)sender {
    [UIView animateWithDuration:kAnimationFactor
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         if ([self.delegate respondsToSelector:@selector(fullView:didCloseWithSuspectStatus:)]) {
                             [self.delegate fullView:self didCloseWithSuspectStatus:self.suspectSwitch.isOn];
                         }
                         self.alpha = kMinAlpha;
                     } completion:nil];
}



@end
