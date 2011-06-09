//
//  BuildsFilterView.h
//  Broken
//
//  Created by Mujtaba Hussain on 9/06/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "BuildsFilterViewDelegate.h"

@interface BuildsFilterView : UIView
{
  UIView *bottomBar_;
  
	CustomButton *passingBuilds_;
  CustomButton *failingBuilds_;
  CustomButton *allBuilds_;
  id<BuildsFilterViewDelegate> delegate_;
}

@property (nonatomic, assign) UIView *bottomBar;

@property (nonatomic, assign) CustomButton *passingBuilds;
@property (nonatomic, assign) CustomButton *failingBuilds;
@property (nonatomic, assign) CustomButton *allBuilds;
@property (nonatomic, assign) id<BuildsFilterViewDelegate> delegate;

@end
