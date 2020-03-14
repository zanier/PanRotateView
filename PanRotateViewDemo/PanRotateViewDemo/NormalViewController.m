//
//  NormalViewController.m
//  PanRotateViewDemo
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "NormalViewController.h"
#import "PanRotateView.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    PanRotateView *view0 = [[PanRotateView alloc] initWithFrame:CGRectMake(16, 100, 50, 50)];
    view0.backgroundColor = [UIColor orangeColor];
    view0.layer.cornerRadius = 5.0;
    view0.layer.masksToBounds = YES;
    [self.view addSubview:view0];
    
    PanRotateView *view1 = [[PanRotateView alloc] initWithFrame:CGRectMake(82, 100, [UIScreen mainScreen].bounds.size.width - 82 - 16, 50)];
    view1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view1];

    PanRotateView *view2 = [[PanRotateView alloc] initWithFrame:CGRectMake(16, 170, [UIScreen mainScreen].bounds.size.width - 32, 45)];
    view2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view2];

    PanRotateView *view3 = [[PanRotateView alloc] initWithFrame:CGRectMake(50, 230, [UIScreen mainScreen].bounds.size.width - 100, 200)];
    view3.backgroundColor = [UIColor redColor];
    view3.layer.cornerRadius = 10.0;
    view3.layer.masksToBounds = YES;
    [self.view addSubview:view3];
        
}

@end
