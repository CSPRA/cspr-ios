//
//  FullImageContainerView.h
//  ICS
//
//  Created by aam-fueled on 08/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnosisPhoto.h"
@protocol FullImageContainerViewDelegate;

@interface FullImageContainerView : UIView
@property (weak, nonatomic) id<FullImageContainerViewDelegate>delegate;
@property (assign, nonatomic) NSInteger containerTag;
+ (FullImageContainerView *)newView;
-(void)setupFullImageContainerWithDiagnosisPicture:(DiagnosisPhoto*)photo;
@end

@protocol FullImageContainerViewDelegate <NSObject>
- (void)fullView:(FullImageContainerView *)fullContainerView didCloseWithSuspectStatus:(BOOL)suspectStatus;
- (void)fullView:(FullImageContainerView *)fullContainerView didDeletePhotoWithAnimation:(BOOL)deleteAnimation;
@end