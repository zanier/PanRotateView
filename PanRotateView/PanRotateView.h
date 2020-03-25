//
//  PanRotateView.h
//  Bichon
//
//  Created by ZZ on 2017/11/9.
//  Copyright © 2017年 Bichon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanRotateView : UIView

/// 水平滑动一个屏幕的宽度时，视图反转的角度。默认值为 M_PI / 15。
@property (nonatomic, assign) CGFloat rotateRateX;

/// 水平滑动一个屏幕的高度时，视图反转的角度。默认值为 M_PI / 10。
@property (nonatomic, assign) CGFloat rotateRateY;

@end
