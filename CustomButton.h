//
//  CustomButton.h
//  Broken
//
//  Created by Mujtaba Hussain on 9/06/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomButton : UIButton {
	CAGradientLayer *gradientLayer;
  
  UIColor *_highColor;
  UIColor *_lowColor;
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, copy) UIColor *_highColor;
@property (nonatomic, copy) UIColor *_lowColor;
@property (nonatomic, copy) CAGradientLayer *gradientLayer;

- (void)setHighColor:(UIColor*)color;
- (void)setLowColor:(UIColor*)color;

@end
