//
//  AllowAccessViewController.m
//  ICS
//
//  Created by Harshita on 01/11/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "AllowAccessViewController.h"

@interface AllowAccessViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView         * accessTableView;
@property (nonatomic, strong) NSMutableDictionary * onboardingMain;
@end

@implementation AllowAccessViewController
@synthesize accessTableView;


- (void)viewDidLoad {
    [super viewDidLoad];

    UIEdgeInsets accessTableViewSeparatorInset = UIEdgeInsetsMake(0, 21, 0, 15);
    accessTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    accessTableView.delegate = self;
    accessTableView.dataSource = self;
    accessTableView.showsVerticalScrollIndicator = NO;
    accessTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:accessTableView];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    accessTableView.tableFooterView = footer;
    
    if ([accessTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [accessTableView setSeparatorInset:accessTableViewSeparatorInset];
    }
    
    if ([accessTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [accessTableView setLayoutMargins:accessTableViewSeparatorInset];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
