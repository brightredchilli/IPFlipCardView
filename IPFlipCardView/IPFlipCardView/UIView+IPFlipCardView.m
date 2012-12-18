//
//  UIView+IPFlipCardView.m
//  IPFlipCardView
//
//  Created by Ying on 12/3/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import "UIView+IPFlipCardView.h"
#import <QuartzCore/QuartzCore.h>

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

@implementation UIView (IPFlipCardView)

- (void)flipView {
    //animate the current layer from a certain perspective.
    [self flipViewWithDuration:0.3 curve:UIViewAnimationCurveLinear];
}

- (void)flipViewWithDuration:(CFTimeInterval)duration
                       curve:(UIViewAnimationCurve)curve {
    [self flipViewWithDuration:duration
                         curve:curve
                    horizontal:YES
                 directionAway:NO
                       frontal:NO
                       fadeOut:NO
                      delegate:nil];
}

- (void)flipViewWithDuration:(CFTimeInterval)duration
                       curve:(UIViewAnimationCurve)curve
                  horizontal:(BOOL)isHorizontalFlip
               directionAway:(BOOL)isDirectionAway
                     frontal:(BOOL)isFrontal
                     fadeOut:(BOOL)isFade
                    delegate:(id)delegate {
    
    NSString *timingFunction = kCAMediaTimingFunctionLinear;
    
    switch (curve) {
        case UIViewAnimationCurveEaseIn:
            timingFunction = kCAMediaTimingFunctionEaseIn;
            break;
        case UIViewAnimationCurveEaseInOut:
            timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
            break;
        case UIViewAnimationCurveEaseOut:
            timingFunction = kCAMediaTimingFunctionEaseOut;
            break;
        default:
            break;
    }
    
    CATransform3D t, t1, t2;
    CGPoint newAnchor;
    CGPoint newPosition = self.layer.position;
//    CGFloat degrees = isFrontal ? -90 : 90;
    
    if (isHorizontalFlip) {
        newAnchor = CGPointMake(0.0, 0.5);
        newPosition.x = CGRectGetMinX(self.frame);
    } else {
        newAnchor = CGPointMake(0.5, 0);
        newPosition.y = CGRectGetMinY(self.frame);
    }
    
    if (isDirectionAway) {
        if (isFrontal) {
            t1 = CATransform3DRotate(self.layer.transform, DegreesToRadians(90) , 0, 1, 0);
            t2 = self.layer.transform;
        } else {
            t1 = self.layer.transform;
            t2 = CATransform3DRotate(self.layer.transform, DegreesToRadians(-90) , 0, 1, 0);
        }
    } else {
        if (isFrontal) {
            t1 = self.layer.transform;
            t2 = CATransform3DRotate(self.layer.transform, DegreesToRadians(90) , 0, 1, 0);
        } else {
            t1 = CATransform3DRotate(self.layer.transform, DegreesToRadians(-90) , 0, 1, 0);
            t2 = self.layer.transform;
        }
    }
    t1.m34 = -1.0/100.0;
    t2.m34 = -1.0/100.0;
    
    //shift anchor point so we will rotate by the top of the view
    CABasicAnimation *anchorPoint = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    anchorPoint.fromValue = [NSValue valueWithCGPoint:newAnchor];
    anchorPoint.toValue = [NSValue valueWithCGPoint:newAnchor];
    anchorPoint.duration = 0;
    anchorPoint.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    anchorPoint.fillMode = kCAFillModeBoth;
    anchorPoint.removedOnCompletion = NO;
    
    //shift position so that the anchor point does not cause shift.
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.fromValue = [NSValue valueWithCGPoint:newPosition];
    position.toValue = [NSValue valueWithCGPoint:newPosition];
    position.duration = 0;
    position.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    position.fillMode = kCAFillModeBoth;
    position.removedOnCompletion = NO;
    
    //make the rotation happen
    CABasicAnimation *rotationTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationTransform.fromValue = [NSValue valueWithCATransform3D:t1];
    rotationTransform.toValue = [NSValue valueWithCATransform3D:t2];
    rotationTransform.duration = duration;
    rotationTransform.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    rotationTransform.fillMode = kCAFillModeBackwards;
    rotationTransform.delegate = delegate;
    
    //make the rotation happen
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    if (isFade) {
        opacity.fromValue = [NSNumber numberWithDouble:1];
        opacity.toValue = [NSNumber numberWithDouble:0];
    } else {
        opacity.fromValue = [NSNumber numberWithDouble:0];
        opacity.toValue = [NSNumber numberWithDouble:1];
    }
    opacity.duration = duration;
//    opacity.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    opacity.removedOnCompletion = NO;
    opacity.fillMode = kCAFillModeBoth;
    opacity.delegate = delegate;
    
    [self.layer addAnimation:anchorPoint forKey:@"anchorPoint"];
    [self.layer addAnimation:position forKey:@"position"];
    [self.layer addAnimation:rotationTransform forKey:@"transform"];
    [self.layer addAnimation:opacity forKey:@"opacity"];
}

- (void)transitionToView:(UIView *)view
                duration:(CFTimeInterval)duration
                   curve:(UIViewAnimationCurve)curve
              horizontal:(BOOL)isHorizontalFlip {

    
}
@end
