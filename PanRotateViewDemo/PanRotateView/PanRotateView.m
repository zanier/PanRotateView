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
        [self _initPanRotateView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self _initPanRotateView];
    }
    return self;
}

- (void)_initPanRotateView {
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
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
        
        // 在此修改拖动旋转的系数
        CGFloat conversioFactorX = (M_PI/15) / [UIScreen mainScreen].bounds.size.width;
        CGFloat conversioFactorY = (M_PI/10) / [UIScreen mainScreen].bounds.size.height;
        
        CGFloat distanceX = location.x - self.initialLocationX;
        CGFloat distanceY = self.initialLocationY - location.y;
        
        distanceX = (distanceX > self.bounds.size.width) ? self.bounds.size.width : distanceX;
        distanceX = (distanceX < -self.bounds.size.width) ? -self.bounds.size.width : distanceX;
        
        distanceY = (distanceY > self.bounds.size.height * 2) ? self.bounds.size.height * 2 : distanceY;
        distanceY = (distanceY < -self.bounds.size.height * 2) ? -self.bounds.size.height * 2 : distanceY;
        
        CGFloat angelY = distanceX * conversioFactorX;
        CGFloat angelX = distanceY * conversioFactorY;
        
        self.layer.transform = [self getTransForm3DWithAngleX:angelX angleY:angelY];
    }
    
}

- (CATransform3D)getTransForm3DWithAngleX:(CGFloat)angleX angleY:(CGFloat)angleY {
    
    CATransform3D transform = CATransform3DIdentity;//获取一个标准默认的CATransform3D仿射变换矩阵
    
    transform.m34 = 4.5/-2000; //透视效果
    
    CATransform3D transformX = CATransform3DRotate(transform, angleX, 1, 0, 0);//获取旋转angle角度后的rotation矩阵。
    CATransform3D transformY = CATransform3DRotate(transform, angleY, 0, 1, 0);//获取旋转angle角度后的rotation矩阵。
    
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

//- (BOOL)isLocation:(CGPoint)location inView:(UIView *)view {
//    if ((location.x > 0 && location.x < CGRectGetWidth(view.frame)) && (location.y > 0 &&location.y<CGRectGetHeight(view.frame))) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

/*
 - (void)scaleAnimation {
 POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
 scaleAnimation.duration = 0.1;
 scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.1, 1.1)];
 [self pop_addAnimation:scaleAnimation forKey:@"scalingUp"];
 }
 - (void)sprintAnimation {
 POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
 sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
 sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
 sprintAnimation.springBounciness = 20.f;
 [self pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
 }
 */

@end
