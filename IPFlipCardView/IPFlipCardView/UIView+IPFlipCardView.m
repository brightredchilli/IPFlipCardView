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
    
    //shift anchor point so we will rotate by the top of the view
    CABasicAnimation *anchorPoint = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    anchorPoint.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0)];
    anchorPoint.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0)];
    anchorPoint.duration = 0;
    anchorPoint.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    anchorPoint.fillMode = kCAFillModeBoth;
    anchorPoint.removedOnCompletion = NO;
    
    //shift position so that the anchor point does not cause shift.
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position.y"];
    position.fromValue = [NSNumber numberWithDouble:CGRectGetMinY(self.frame)];
    position.toValue = [NSNumber numberWithDouble:CGRectGetMinY(self.frame)];
    position.duration = 0;
    position.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    position.fillMode = kCAFillModeBoth;
    position.removedOnCompletion = NO;
    
    //make the rotation happen
    CABasicAnimation *rotationTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationTransform.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, DegreesToRadians(90) , 1, 0, 0)];
    rotationTransform.duration = duration;
    rotationTransform.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    rotationTransform.fillMode = kCAFillModeBackwards;
    
    [self.layer addAnimation:anchorPoint forKey:@"anchorPoint"];
    [self.layer addAnimation:position forKey:@"position"];
    [self.layer addAnimation:rotationTransform forKey:@"transform"];
}

@end
