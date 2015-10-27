//
//  WalkthroughViewController.m
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "WalkthroughViewController.h"

@interface WalkthroughViewController ()
@property (nonatomic, strong) UIScrollView * wtScrollView;
@property (nonatomic, strong) UIButton * gotItButton;
@end

@implementation WalkthroughViewController
@synthesize gotItButton;
@synthesize wtScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * wtTextArray = @[
                      @"Add photos and click to enlarge and inspect. If it is suspected, mark as so.",
                      @"View will help you determine if user should be assigned to doctor or not.",
                      @"Detailed disgnosis consists of eating habits.",
                      @"When all is done, assign a doctor.",
                      @"Click on Quick Registration to open OCR.",
                      @"OCR helps you quickly take first level information of patient.",
                      ];
    
    wtScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    wtScrollView.backgroundColor = [UIColor whiteColor];
    wtScrollView.showsHorizontalScrollIndicator = NO;
    wtScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:wtScrollView];
    
    CGFloat x_point = 0;
    
    for(int i = 0; i < wtTextArray.count; i++ ) {
        UIView * wtView = [[UIView alloc] initWithFrame:CGRectMake(x_point, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        UIImageView * wtScreen = [[UIImageView alloc] initWithFrame:CGRectInset(self.view.frame, 0, -20)];
        wtScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"wtscreen%d", i+1]];
        wtScreen.contentMode = UIViewContentModeScaleAspectFill;
        wtScreen.backgroundColor = [UIColor clearColor];
        
        UILabel * wtTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.view.bounds)-40, 120)];
        wtTitle.text = wtTextArray[i];
        wtTitle.numberOfLines = 0;
        wtTitle.textAlignment = NSTextAlignmentCenter;
        [wtView addSubview:wtScreen];
        [wtView addSubview:wtTitle];
        [wtScrollView addSubview:wtView];
        
        x_point += CGRectGetWidth(self.view.frame);
    }
    
    wtScrollView.bounces = NO;
    wtScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*wtTextArray.count, CGRectGetHeight(self.view.bounds));
    wtScrollView.contentOffset = CGPointZero;
    wtScrollView.pagingEnabled = YES;
    
    gotItButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-50, CGRectGetWidth(self.view.frame), 50)];
    [gotItButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [gotItButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [gotItButton setTitle:@"Got It" forState:UIControlStateNormal];
    [gotItButton addTarget:self action:@selector(dismissWalkthrough) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotItButton];
    
}

-(void)dismissWalkthrough {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end