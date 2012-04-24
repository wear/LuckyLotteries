//
//  LuckyLotteriesViewController.m
//  LuckyLotteries
//
//  Created by  on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "LuckyLotteriesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PointView.h"
#import "InnerCircle.h"

#define ArrowViewHeight 60

#define InnerCircleRadius 240.

@interface LuckyLotteriesViewController ()
@property(strong) PointView *pointView;
@end

@implementation LuckyLotteriesViewController
@synthesize pointView = _pointView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGPoint center = CGPointMake(self.view.bounds.size.width/2 , self.view.bounds.size.height/2);
    self.pointView = [[PointView alloc] initWithFrame:CGRectMake(center.x, center.y-ArrowViewHeight/2, 200., ArrowViewHeight)];
    [self.view addSubview:self.pointView];
    
    InnerCircle *innerCircle = [[InnerCircle alloc] initWithFrame:CGRectMake(center.x-InnerCircleRadius/2, center.y-InnerCircleRadius/2, InnerCircleRadius, InnerCircleRadius)];
    [self.view addSubview:innerCircle];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:self.view];
        self.pointView.rotateValue = translation.y/10.;
        [recognizer setTranslation:CGPointZero inView:self.view];
        [self.pointView animateRotateInDiaView:self.view];
    }
}

@end
