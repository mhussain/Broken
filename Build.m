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
  
  NSString *color = [dictionary objectForKey:@"color"];
  
  if (color == @"red") {
    [build setCurrentState:[UIColor redColor]];
  }
  else if(color == @"blue") {
    [build setCurrentState:[UIColor greenColor]];
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
@synthesize currentState = currentState_;

//- (UIColor *)color;
//{
//  UIColor *color;
//  
//  NSDictionary *colors = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:0x2E8B57 ], @"success",
//                          [UIColor redColor], @"failure",
//                          [UIColor blueColor], @"building",
//                          nil];
//  if ([[self activity] isEqualToString:@"building"])
//  {
//    color = [UIColor blueColor];
//  }
//  else 
//  {
//    color = [colors objectForKey:[self lastBuildStatus]];
//  }
//  
//  return color;
//}

@end
