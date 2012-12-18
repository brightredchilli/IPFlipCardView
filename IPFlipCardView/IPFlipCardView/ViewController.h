//
//  ViewController.h
//  IPFlipCardView
//
//  Created by Ying on 12/3/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IPFlipViewContainer;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet IPFlipViewContainer *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)flipViewClicked:(id)sender;
- (IBAction)flipBackClicked:(id)sender;
    
@end
