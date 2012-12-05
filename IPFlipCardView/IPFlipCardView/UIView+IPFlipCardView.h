//
//  UIView+IPFlipCardView.h
//  IPFlipCardView
//
//  Created by Ying on 12/3/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IPFlipCardView)

- (void)flipView;
- (void)flipViewWithDuration:(CFTimeInterval)duration
                       curve:(UIViewAnimationCurve)curve;



@end