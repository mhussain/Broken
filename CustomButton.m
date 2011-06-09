//
//  CustomButton.m
//  Broken
//
//  Created by Mujtaba Hussain on 9/06/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // Initialize the gradient layer
    gradientLayer = [[CAGradientLayer alloc] init];
    // Set its bounds to be the same of its parent
    [gradientLayer setBounds:[self bounds]];
    // Center the layer inside the parent layer
    [gradientLayer setPosition:
     CGPointMake([self bounds].size.width/2,
                 [self bounds].size.height/2)];
    
    // Insert the layer at position zero to make sure the 
    // text of the button is not obscured
    [[self layer] insertSublayer:gradientLayer atIndex:0];
    
    // Set the layer's corner radius
    [[self layer] setCornerRadius:8.0f];
    // Turn on masking
    [[self layer] setMasksToBounds:YES];
    // Display a border around the button 
    // with a 1.0 pixel width
    [[self layer] setBorderWidth:1.0f];
    
    [self setFrame:frame];
    
  }
  
  return self;
}

@synthesize _highColor;
@synthesize _lowColor;
@synthesize gradientLayer;


- (void)drawRect:(CGRect)rect;
{
  if (_highColor && _lowColor)
  {
    // Set the colors for the gradient to the 
    // two colors specified for high and low
    [gradientLayer setColors:
     [NSArray arrayWithObjects:
      (id)[_highColor CGColor], 
      (id)[_lowColor CGColor], nil]];
  }
  [super drawRect:rect];
}

- (void)setHighColor:(UIColor*)color;
{
  // Set the high color and repaint
  [self set_highColor:color];
  [[self layer] setNeedsDisplay];
}

- (void)setLowColor:(UIColor*)color;
{
  // Set the low color and repaint
  [self set_lowColor:color];
  [[self layer] setNeedsDisplay];
}

- (void)dealloc {
  // Release our gradient layer
  [gradientLayer release];
  [super dealloc];
}
@end