//
//  UIColor+RGBColor.h
//  LuckyLotteries
//
//  Created by  on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBColor)
+ (UIColor *) colorFromHexRGB:(NSString *)inColorString inAlpha:(CGFloat)AlphaValue;
@end
