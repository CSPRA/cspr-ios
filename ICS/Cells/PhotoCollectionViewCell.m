//
//  PhotoCollectionViewCell.m
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell()
@property (nonatomic, strong) UIView * overlayView;
@end
@implementation PhotoCollectionViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self setupOverlay];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupOverlay];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupOverlay];
    }
    
    return self;
}

- (void)setupOverlay {
    self.overlayView = [[UIView alloc] initWithFrame:self.frame];
    self.overlayView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
    self.overlayView.alpha = kMinAlpha;
    
    [self.contentView addSubview:self.overlayView];
}

#pragma mark - 

-(void)layoutSubviews {
    if(self.isSuspectedPhoto) {
        self.overlayView.alpha = kMaxAlpha;
        [self.contentView bringSubviewToFront:self.overlayView];
    }
    else {
        self.overlayView.alpha = kMinAlpha;
    }
}

@end
