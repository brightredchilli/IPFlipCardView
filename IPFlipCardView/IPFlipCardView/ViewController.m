//
//  ViewController.m
//  IPFlipCardView
//
//  Created by Ying on 12/3/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import "ViewController.h"
#import "UIView+IPFlipCardView.h"


@interface ViewController ()

@property (strong, nonatomic) NSArray *allStrings;
@property (readwrite, nonatomic) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.allStrings = @[@"Food", @"Music", @"Art", @"Travel", @"Lifestyle", @"Fashion", @"Beat", @"Opinion"];

}

- (void)viewDidAppear:(BOOL)animated {
//    self.contentView.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flipViewClicked:(id)sender {
    self.count++;
    if (self.count >= self.allStrings.count) {
        self.count = 0;
    }
    self.titleLabel.text = [self.allStrings objectAtIndex:self.count];
    
    [self.contentView flipViewWithDuration:7 curve:UIViewAnimationCurveLinear];
    
}
@end
