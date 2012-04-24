//
//  PointView.m
//  LuckyLotteries
//
//  Created by  on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#define radius 60.

#import "PointView.h"
#import "DialView.h"
#import "UIColor+RGBColor.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h> 
#import <AudioToolbox/AudioToolbox.h>

@interface PointView()
@property(strong,nonatomic) DialView* dialView;
@property(strong,nonatomic) AVAudioPlayer *audioPlayer;
@end

@implementation PointView
@synthesize dialView = _dialView;
@synthesize rotateValue = _rotateValue;
@synthesize audioPlayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/200922412923771.mp3", [[NSBundle mainBundle] resourcePath]]];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        self.audioPlayer.numberOfLoops = -1;
        [self.audioPlayer prepareToPlay];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
//    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 线起点
    [path moveToPoint:CGPointMake(0., 5.)];
    // 箭头起点
    [path addLineToPoint:CGPointMake(160., radius/4)];
    // 箭头高度
    [path addLineToPoint:CGPointMake(160., 3.)];
    // 箭头点
    [path addLineToPoint:CGPointMake(200.,radius/2-5)];
    // 箭头下点
    [path addLineToPoint:CGPointMake(160.,radius-3)];
    // 下线起点
    [path addLineToPoint:CGPointMake(160.,radius-radius/4)];
    // 下线终点
    [path addLineToPoint:CGPointMake(0.,radius-radius/4)];
    [path closePath];
    CGContextSetFillColorWithColor(context, [UIColor colorFromHexRGB:@"BCBCB9" inAlpha:1.0].CGColor);
    [path fill];
    [path setLineWidth:3.0];
    [path stroke];
    
    CGContextSaveGState(context);
    [path addClip];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 0.5 ,1.0};
    NSArray *gradient_colors = [NSArray arrayWithObjects:(id)[UIColor colorFromHexRGB:@"F1DA7D" inAlpha:1.0].CGColor,(id)[UIColor colorFromHexRGB:@"F8BF28" inAlpha:1.0].CGColor,(id)[UIColor whiteColor].CGColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,                                                  (__bridge CFArrayRef) gradient_colors, locations);
    
    CGContextDrawLinearGradient(context, gradient, startPoint,endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
}

- (void)animateRotateInDiaView:(DialView*)dialView{
    self.dialView = dialView;
    // Set up a basic animation for rotation on z axis (spinning)
	CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spin.delegate = self;
//    
//    // Set the value of the spin to 2*pi, this is 1 complete rotation in radians
	spin.toValue = [NSNumber numberWithDouble:M_PI*self.rotateValue];
	spin.duration = self.rotateValue/2.5234; // duration to animate a full revolution of 2*Pi radians.
    
    self.layer.anchorPoint = CGPointMake(0., 0.5);
    self.layer.position = CGPointMake(dialView.center.x, dialView.center.y - radius/2);
    spin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    // 隐式动画
    [self setTransform:CGAffineTransformMakeRotation(M_PI*self.rotateValue)];
    [self.layer addAnimation:spin forKey:@"transform"];
}

- (void)animationDidStart:(CAAnimation *)theAnimation{
    self.dialView.currentPoint = CGPointZero;
    [self.dialView setNeedsDisplay];
    // 播放音频
    [self.audioPlayer play];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{   
    self.dialView.currentPoint = [self.dialView.layer convertPoint:CGPointMake(200.,radius/2) fromLayer:self.layer];
    [self.audioPlayer stop];
    [self.dialView setNeedsDisplay];
    
}


@end
