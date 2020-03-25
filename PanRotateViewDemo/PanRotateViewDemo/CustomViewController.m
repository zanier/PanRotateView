//
//  CustomViewController.m
//  PanRotateViewDemo
//
//  Created by ZZ on 2020/3/18.
//  Copyright © 2020 zz. All rights reserved.
//

#import "CustomViewController.h"
#import "PanRotateView.h"

@interface CustomViewController ()
@property (nonatomic, copy) void (^cycle)(void);
@end

@implementation CustomViewController

- (void)dealloc {
    NSLog(@"dealloc %@", self);
}
- (void)receiveNoti:(NSNotification *)noti {
    NSLog(@"did receive noti, %@, %@", noti.name, noti.object);
}
- (void)test {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:@"qwe" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:@"qwe" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:nil object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL tag = NO;
    if (tag) {
        NSLog(@"YES");
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"qwe" object:self];
         
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification new]];
    } else {
        NSLog(@"NO");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"qwe" object:nil];
    }
    tag = !tag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setCycle:^{
//        NSLog(@"%@", self);
//    }];
    [self test];
    return;
    
    PanRotateView *view4 = [[PanRotateView alloc] initWithFrame:CGRectMake(50, 400, [UIScreen mainScreen].bounds.size.width - 100, 150)];
    view4.layer.cornerRadius = 10.0;
    view4.layer.masksToBounds = YES;
    view4.rotateRateY = M_PI / 5;
    view4.rotateRateX = M_PI / 5;
    [self.view addSubview:view4];
    
    UISlider *sliderX = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    UISlider *sliderY = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    sliderX.minimumValue = 0;
    sliderX.maximumValue = M_PI;
    sliderY.minimumValue = 0;
    sliderY.maximumValue = M_PI;
    
    [self.view addSubview:sliderX];
    [self.view addSubview:sliderY];

}


@end
