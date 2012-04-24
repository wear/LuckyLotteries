//
//  UIColor+RGBColor.m
//  LuckyLotteries
//
//  Created by  on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+RGBColor.h"

@implementation UIColor (RGBColor)
+ (UIColor *) colorFromHexRGB:(NSString *)inColorString inAlpha:(CGFloat)AlphaValue{
    UIColor *result = nil;
	unsigned int colorCode = 0;
	unsigned char redByte, greenByte, blueByte;
	
	if (nil != inColorString)
	{
		NSScanner *scanner = [NSScanner scannerWithString:inColorString];
		(void) [scanner scanHexInt:&colorCode];	// ignore error
	}
	redByte		= (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte	= (unsigned char) (colorCode);	// masks off high bits
	result = [UIColor
              colorWithRed:(float)redByte/ 0xff
              green:	(float)greenByte/ 0xff
              blue:	(float)blueByte	/ 0xff
              alpha:AlphaValue];
	return result;
}
@end
