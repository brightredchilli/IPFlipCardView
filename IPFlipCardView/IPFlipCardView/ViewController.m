//
//  ViewController.m
//  IPFlipCardView
//
//  Created by Ying on 12/3/12.
//  Copyright (c) 2012 Ying. All rights reserved.
//

#import "ViewController.h"
#import "UIView+IPFlipCardView.h"
#import "IPFlipViewContainer.h"


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

- (void)upCurrentCount {
    self.count++;
    if (self.count >= self.allStrings.count) {
        self.count = 0;
    }
}

- (void)downCurrentCount {
    self.count--;
    if (self.count < 0) {
        self.count = self.allStrings.count - 1;
    }
}

+ (UILabel *)labelWithString:(NSString *)string {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.text = string;
    return label;
}

- (IBAction)flipViewClicked:(id)sender {
    [self upCurrentCount];
    [self.contentView showView:[ViewController labelWithString:self.allStrings[self.count]]]; // for now just to test the fadeout functionality
}

- (IBAction)flipBackClicked:(id)sender {
    [self downCurrentCount];
    [self.contentView showView:[ViewController labelWithString:self.allStrings[self.count]]]; // for now just to test the fadeout functionality
}

- (IBAction)swapViewClicked:(id)sender {
    
}
@end
