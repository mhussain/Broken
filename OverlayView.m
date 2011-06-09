//
//  Overlay.m
//  Broken
//
//  Created by Mujtaba Hussain on 8/06/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self setBackgroundColor:[UIColor blackColor]];
      [self setAlpha:0.6];
      [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];

    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
