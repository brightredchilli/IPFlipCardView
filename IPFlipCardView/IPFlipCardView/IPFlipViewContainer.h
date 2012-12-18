//
//  IPFlipViewContainer.h
//  IPFlipCardView
//
//  Created by Ying on 12/14/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
   IPFlipViewDirectionHorizontal,
   IPFlipViewDirectionVertical
} IPFlipViewDirection;

@interface IPFlipViewContainer : UIView

@property (readwrite, nonatomic) CFTimeInterval animationDuration;
@property (readwrite, nonatomic) IPFlipViewDirection direction;

- (void)showView:(UIView *)view; //view slides up from front
- (void)hideView:(UIView *)view; //view goes back

@end
