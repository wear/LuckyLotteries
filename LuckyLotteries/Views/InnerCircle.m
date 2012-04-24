//
//  InnerCircle.m
//  LuckyLotteries
//
//  Created by  on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InnerCircle.h"
#import "UIColor+RGBColor.h"

#define Radius 200.
#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@implementation InnerCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addArcWithCenter:center radius:80 startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    CGContextSetStrokeColorWithColor(context, [UIColor colorFromHexRGB:@"0A0C07" inAlpha:1.0].CGColor);
    [path setLineWidth:5.0];
    [path stroke];
    [path fill];
    
    CGContextSaveGState(context);
    [path addClip];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0};
    NSArray *gradient_colors = [NSArray arrayWithObjects:(id)[UIColor colorFromHexRGB:@"FEFF00" inAlpha:1.0].CGColor,(id)[UIColor colorFromHexRGB:@"F38900" inAlpha:1.0].CGColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,                                                  (__bridge CFArrayRef) gradient_colors, locations);
    CGPoint gradientCenter = CGPointMake(center.x-20, center.y-20);
    CGContextDrawRadialGradient(context, gradient, gradientCenter, 0, gradientCenter, Radius, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
    
}


@end
