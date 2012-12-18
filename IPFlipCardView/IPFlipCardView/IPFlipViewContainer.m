//
//  IPFlipViewContainer.m
//  IPFlipCardView
//
//  Created by Ying on 12/14/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import "IPFlipViewContainer.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+IPFlipCardView.h"

@interface IPFlipViewContainer ()
@property (strong, nonatomic) NSArray *currentViews;
- (void)setup;
- (void)addView:(UIView *)view;
@end

@implementation IPFlipViewContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark Private methods

- (void)setup {
    _direction = IPFlipViewDirectionHorizontal;
    _animationDuration = 1.3;
}

- (void)addView:(UIView *)view {
}


#pragma mark Implementation

- (void)showView:(UIView *)view {
    self.currentViews = self.subviews;
    if (self.subviews.count > 0) {
        //if we have subviews, we need to fade all of them out.
        for (UIView *current in self.currentViews) {
            [current flipViewWithDuration:self.animationDuration
                                    curve:UIViewAnimationCurveEaseIn
                               horizontal:self.direction == IPFlipViewDirectionHorizontal ? YES : NO
                            directionAway:NO
                                  frontal:YES
                                  fadeOut:YES
                                 delegate:self];
        }
    }
    
    view.layer.opacity = 0;
    [self addSubview:view];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC * 0.5);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [view flipViewWithDuration:self.animationDuration
                             curve:UIViewAnimationCurveEaseIn
                        horizontal:self.direction == IPFlipViewDirectionHorizontal ? YES : NO
                     directionAway:NO
                           frontal:NO
                           fadeOut:NO
                          delegate:self];
        view.layer.opacity = 1.0;
    });

}

- (void)hideView:(UIView *)view {
    self.currentViews = self.subviews;
    if (self.subviews.count > 0) {
        //if we have subviews, we need to fade all of them out.
        for (UIView *current in self.currentViews) {
            [current flipViewWithDuration:self.animationDuration
                                    curve:UIViewAnimationCurveEaseIn
                               horizontal:self.direction == IPFlipViewDirectionHorizontal ? YES : NO
                            directionAway:YES
                                  frontal:NO
                                  fadeOut:YES
                                 delegate:self];
        }
    }
    
    view.layer.opacity = 0;
    [self addSubview:view];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC * 0.5);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [view flipViewWithDuration:self.animationDuration
                             curve:UIViewAnimationCurveEaseIn
                        horizontal:self.direction == IPFlipViewDirectionHorizontal ? YES : NO
                     directionAway:YES
                           frontal:YES
                           fadeOut:NO
                          delegate:self];
        view.layer.opacity = 1.0;
    });
}

#pragma mark CALayer Delegate Methods

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.currentViews.count > 0) {
        UIView *view = self.currentViews[0];
        
        for (NSString *animKey in view.layer.animationKeys) {
            if ([view.layer animationForKey:animKey] == anim) {
                [self.currentViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                self.currentViews = nil;
                NSLog(@"current views is now nil");
                break;
            }
        }
        
    }
    
}
@end
