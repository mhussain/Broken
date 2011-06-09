//
//  BuildsFilterView.m
//  Broken
//
//  Created by Mujtaba Hussain on 9/06/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "BuildsFilterView.h"
#import "CustomButton.h"

#import <QuartzCore/QuartzCore.h>

@implementation BuildsFilterView

- (id)initWithFrame:(CGRect)frame;
{
  self = [super initWithFrame:frame];
  if (self) {
    
    bottomBar_ = [[[UIView alloc] initWithFrame:CGRectMake(0., 0., 320., 50.)] autorelease];
    
    passingBuilds_ = [[[CustomButton alloc] initWithFrame:CGRectMake(35., 5., 80., 30.)] autorelease];
    [passingBuilds_ setTitle:@"Stable" forState:UIControlStateNormal];
    [passingBuilds_ addTarget:self action:@selector(passingBuildsTapped) forControlEvents:UIControlEventTouchUpInside];
    [passingBuilds_ setHighColor:[UIColor greenColor]];
    [passingBuilds_ setLowColor:[UIColor whiteColor]];    
    [bottomBar_ addSubview:passingBuilds_];
    
    failingBuilds_ = [[[CustomButton alloc] initWithFrame:CGRectMake(120., 5., 80., 30.)] autorelease];	
    [failingBuilds_ setTitle:@"Failing" forState:UIControlStateNormal];
    [failingBuilds_ addTarget:self action:@selector(failingBuildsTapped) forControlEvents:UIControlEventTouchUpInside];
    [failingBuilds_ setHighColor:[UIColor redColor]];
    [failingBuilds_ setLowColor:[UIColor whiteColor]];    
    [bottomBar_ addSubview:failingBuilds_];

    allBuilds_ = [[[CustomButton alloc] initWithFrame:CGRectMake(205., 5., 80., 30.)] autorelease];	
    [allBuilds_ setTitle:@"All" forState:UIControlStateNormal];
    [allBuilds_ addTarget:self action:@selector(allBuildsTapped) forControlEvents:UIControlEventTouchUpInside];
    [allBuilds_ setHighColor:[UIColor purpleColor]];
    [allBuilds_ setLowColor:[UIColor whiteColor]];
    [bottomBar_ addSubview:allBuilds_];    
    
    [self addSubview:bottomBar_];
    [self setBackgroundColor:[UIColor clearColor]];    
  }
  return self;
}

- (void)dealloc;
{	
  [bottomBar_ dealloc];
  [passingBuilds_ dealloc];
  [failingBuilds_ dealloc];
  [allBuilds_ dealloc];
    [super dealloc];
}

#pragma mark - Buttons

@synthesize bottomBar = bottomBar_;

@synthesize passingBuilds = passingBuilds_;
@synthesize allBuilds = allBuilds_;
@synthesize failingBuilds = failingBuilds_;

@synthesize delegate = delegate_;

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - BuildsFilterViewDelegate

- (void)failingBuildsTapped;
{
  [delegate_ filterFailingBuilds];
}

- (void)allBuildsTapped;
{
  [delegate_ filterAllBuilds];
}

- (void)passingBuildsTapped;
{
  [delegate_ filterPassingBuilds];
}

@end
