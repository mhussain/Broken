//
//  NSArray+Build.m
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "NSArray+Blocks.h"
#import "NSArray+Build.h"
#import "Build.h"


@implementation NSArray (Build)

- (NSArray *)asBuilds;
{
  return [self map:^(id build) {
    return [Build buildFromDictionary:build];
  }];
  
}

@end
