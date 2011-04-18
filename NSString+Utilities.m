//
//  NSString+Utilities.m
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

- (BOOL)isEmpty;
{
  return [[self trim] isEqualToString:@""];
}

- (BOOL)isNotEmpty;
{
  return ![self isEmpty];
}

- (NSString *)trim;
{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)contains:(NSString *)partialString;
{
  return [self rangeOfString:partialString].location != NSNotFound;
}

- (BOOL)doesNotContain:(NSString *)partialString;
{
  return [self rangeOfString:partialString].location == NSNotFound;
}

- (BOOL)isValidEmailAddress
{
  BOOL result = NO;
  
  NSError *error = NULL;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]+$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
  if (error == NULL)
  {
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, [self length])];
    result = (numberOfMatches > 0);
  }
  
  return result;
}

- (NSString *)repeat:(NSUInteger)times;
{
  return [@"" stringByPaddingToLength:times * [self length] withString:self startingAtIndex:0];
}

@end
