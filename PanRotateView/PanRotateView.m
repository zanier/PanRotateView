//
//  PanRotateView.m
//  Bichon
//
//  Created by ZZ on 2017/11/9.
//  Copyright © 2017年 Bichon. All rights reserved.
//

#import "PanRotateView.h"

@interface PanRotateView () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat initialLocationX;
@property (nonatomic, assign) CGFloat initialLocationY;

@end

@implementation PanRotateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _rotateRateX = M_PI / 15;
        _rotateRateY = M_PI / 10;
        [self _setup];
    }
    return self;
}

- (void)_setup {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
}

- (void)panHandle:(UIPanGestureRecognizer *)pan {
    CGPoint location = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.initialLocationX = location.x;
        self.initialLocationY = location.y;
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [self identityAnimation];
    } else {
        // 转换拖动旋转的系数
        CGFloat conversioFactorX = _rotateRateX / [UIScreen mainScreen].bounds.size.width;
        CGFloat conversioFactorY = _rotateRateY / [UIScreen mainScreen].bounds.size.height;
        // 计算移动距离
        CGFloat distanceX = location.x - self.initialLocationX;
        CGFloat distanceY = self.initialLocationY - location.y;
        // 最大距离限制
        distanceX = (distanceX > self.bounds.size.width) ? self.bounds.size.width : distanceX;
        distanceX = (distanceX < -self.bounds.size.width) ? -self.bounds.size.width : distanceX;
        distanceY = (distanceY > self.bounds.size.height * 2) ? self.bounds.size.height * 2 : distanceY;
        distanceY = (distanceY < -self.bounds.size.height * 2) ? -self.bounds.size.height * 2 : distanceY;
        // 计算获得角度
        CGFloat angelY = distanceX * conversioFactorX;
        CGFloat angelX = distanceY * conversioFactorY;
        // 添加动画
        self.layer.transform = [self getTransForm3DWithAngleX:angelX angleY:angelY];
    }
}

- (CATransform3D)getTransForm3DWithAngleX:(CGFloat)angleX angleY:(CGFloat)angleY {
    // 获取一个标准默认的CATransform3D仿射变换矩阵
    CATransform3D transform = CATransform3DIdentity;
    // 透视效果
    transform.m34 = 4.5/-2000;
    //获取旋转angle角度后的rotation矩阵。
    CATransform3D transformX = CATransform3DRotate(transform, angleX, 1, 0, 0);
    //获取旋转angle角度后的rotation矩阵。
    CATransform3D transformY = CATransform3DRotate(transform, angleY, 0, 1, 0);
    transform = CATransform3DConcat(transformX, transformY);
    return transform;
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)identityAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DIdentity;
    }];
}

@end
