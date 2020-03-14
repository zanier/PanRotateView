//
//  PanRotateCell.m
//  PanRotateViewDemo
//
//  Created by ZZ on 2020/3/14.
//  Copyright © 2020 zz. All rights reserved.
//

#import "PanRotateCell.h"
#import "PanRotateView.h"

@implementation PanRotateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    PanRotateView *view = [[PanRotateView alloc] initWithFrame:CGRectMake(16, 4, [UIScreen mainScreen].bounds.size.width - 32, 80)];
    view.backgroundColor = [UIColor colorWithRed:(random() % 256) / 255.0 green:(random() % 256) / 255.0 blue:(random() % 256) / 255.0 alpha:1.0];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    [self addSubview:view];
}

@end
