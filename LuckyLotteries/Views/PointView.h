//
//  PointView.h
//  LuckyLotteries
//
//  Created by  on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointView : UIView
@property(assign) CGFloat rotateValue;

- (void)animateRotateInDiaView:(UIView*)dialView;
@end
