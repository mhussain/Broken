//
//  Build.m
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "NSString+Utilities.h"
#import "UIColor+Hex.h"
#import "Build.h"


@implementation Build


+ (id)buildFromDictionary:(NSDictionary *)dictionary;
{
  Build *build = [[[Build alloc] init] autorelease];
  
  [build setName:[dictionary objectForKey:@"name"]];
  [build setUrl:[dictionary objectForKey:@"url"]];
  [build setCurrentState:[UIColor grayColor]];
  [build setBroken:NO];
  [build setBrokenWhen:@"Unknown"];
  [build setCommitID:@"Unknown"];
  [build setComment:@"No Comment"];
  [build setCulprit:@"Unknown"];
  
  NSString *color = [dictionary objectForKey:@"color"];
  
  if ([color isEqualToString:@"red"]) {
    [build setCurrentState:[UIColor redColor]];
    [build setBroken:YES];
  }
  else if([color isEqualToString:@"blue"]) {
    [build setCurrentState:[UIColor colorWithHex:0x006633]];
  }
  else {
    [build setCurrentState:[UIColor blueColor]];
  }
  
  return build;
}

- (void) dealloc
{
  [name_ release];
	[currentState_ release];
  [url_ release];
  
  [super dealloc];
}


#pragma mark -
#pragma mark properties

@synthesize name = name_;
@synthesize url = url_;
@synthesize description = description_;
@synthesize currentState = currentState_;
@synthesize lastBuildURL = lastBuildURL_;
@synthesize culprit = culprit_;
@synthesize comment = comment_;
@synthesize commitID = commitID_;
@synthesize brokenWhen = brokenWhen_;

- (void)setBroken:(BOOL)yesOrNo;
{
	broken = yesOrNo;
}

- (BOOL)isBroken;
{
  return broken;
}

@end