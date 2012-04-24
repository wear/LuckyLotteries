//
//  DialView.m
//  LuckyLotteries
//
//  Created by  on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DialView.h"
#import "UIColor+RGBColor.h"

#define DialRadius 300.
#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)
#define PrizeCount 2
#define ArcAngle 360/PrizeCount


@implementation DialView
@synthesize currentPoint = _currentPoint;
@synthesize pathArray = _pathArray;

-(NSMutableArray*)pathArray{
	if(!_pathArray) _pathArray = [[NSMutableArray alloc] init];
    return _pathArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2); 
    
    // 外圈的装饰
    for (int i=0; i<24; i++) {
        UIBezierPath *outCirclePath = [UIBezierPath bezierPath];
        [outCirclePath moveToPoint:center];
        [outCirclePath addArcWithCenter:center radius:DialRadius+30 startAngle:DEGREES_TO_RADIANS(15*i) endAngle:DEGREES_TO_RADIANS(15*(i+1)) clockwise:YES];
        CGContextSetFillColorWithColor(context, (i%2 != 0) ? [UIColor colorFromHexRGB:@"AC7100" inAlpha:1.0].CGColor : [UIColor colorFromHexRGB:@"F8C622" inAlpha:1.0].CGColor);
        [outCirclePath fill];
            CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3., [UIColor brownColor].CGColor);
    }
    
    // 画内圈并用圆形渐变填充
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:center];
    [circlePath addArcWithCenter:center radius:DialRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    CGContextSaveGState(context);
    
    [circlePath fill];
    [circlePath addClip];
                                                                                                            
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *gradient_colors = [NSArray arrayWithObjects:(id)[UIColor colorFromHexRGB:@"F1DA7D" inAlpha:1.0].CGColor,(id)[UIColor colorFromHexRGB:@"F8BF28" inAlpha:1.0].CGColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,                                                  (__bridge CFArrayRef) gradient_colors, locations);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, 300, kCGGradientDrawsAfterEndLocation);
    //        CGContextDrawLinearGradient(context, gradient, startPoint,endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);

    
    // 然后画各种弧形
    for (int i=0; i < PrizeCount; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:center];
        [path addArcWithCenter:center radius:DialRadius startAngle:DEGREES_TO_RADIANS(i*ArcAngle) endAngle:DEGREES_TO_RADIANS((i+1)*ArcAngle) clockwise:YES];
        [path closePath];
        if ([path containsPoint:self.currentPoint]) {
            CGContextSetFillColorWithColor(context,[UIColor lightTextColor].CGColor);
        } else {
            CGContextSetFillColorWithColor(context,i%2==0 ? [UIColor colorFromHexRGB:@"F4990A" inAlpha:1.0].CGColor : [UIColor colorFromHexRGB:@"C84907" inAlpha:1.0].CGColor);
        }
        CGContextSetStrokeColorWithColor(context, [UIColor brownColor].CGColor);
        [path fillWithBlendMode:kCGBlendModeMultiply alpha:0.2];
        [self.pathArray addObject:path];
    }
}

@end
