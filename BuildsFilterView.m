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
    [passingBuilds_ setHighColor:[UIColor redColor]];
    [passingBuilds_ setLowColor:[UIColor grayColor]];
    
//		passingBuilds_ = [[[UIButton alloc] initWithFrame:CGRectMake(35., 5., 80., 30.)] autorelease];
//    [passingBuilds_ setTitle:@"Stable" forState:UIControlStateNormal];
//    [passingBuilds_ setBackgroundImage:[UIImage imageNamed:@"FilterButtonBg.png"] forState:UIControlStateNormal];

    [bottomBar_ addSubview:passingBuilds_];
    
    failingBuilds_ = [[[CustomButton alloc] initWithFrame:CGRectMake(120., 5., 80., 30.)] autorelease];	
    [failingBuilds_ setTitle:@"Failing" forState:UIControlStateNormal];
    [failingBuilds_ setBackgroundImage:[UIImage imageNamed:@"FilterButtonBg.png"] forState:UIControlStateNormal];
    [failingBuilds_ setHighColor:[UIColor redColor]];
    [failingBuilds_ setLowColor:[UIColor grayColor]];
    
    [bottomBar_ addSubview:failingBuilds_];

    allBuilds_ = [[[CustomButton alloc] initWithFrame:CGRectMake(205., 5., 80., 30.)] autorelease];	
    [allBuilds_ setTitle:@"All" forState:UIControlStateNormal];
    [allBuilds_ setBackgroundImage:[UIImage imageNamed:@"FilterButtonBg.png"] forState:UIControlStateNormal];
    [allBuilds_ setHighColor:[UIColor redColor]];
    [allBuilds_ setLowColor:[UIColor grayColor]];

    [bottomBar_ addSubview:allBuilds_];    
    
    [[bottomBar_ layer] setCornerRadius:8.];
    
    [bottomBar_ sizeToFit];
    [bottomBar_ layoutSubviews];
    
    [self addSubview:bottomBar_];
    [self setBackgroundColor:[UIColor clearColor]];
    [self layoutSubviews];
    
  }
  return self;
}

- (void)dealloc;
{
    [super dealloc];
}

#pragma mark - Buttons

@synthesize bottomBar = bottomBar_;

@synthesize passingBuilds = passingBuilds_;
@synthesize allBuilds = allBuilds_;
@synthesize failingBuilds = failingBuilds_;

- (void)didReceiveMemoryWarning;
{
//  // Releases the view if it doesn't have a superview.
//  [super didReceiveMemoryWarning];
//  
//  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)layoutSubviews;
{
  
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
