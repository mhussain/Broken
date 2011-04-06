//
//  NSString+Utilities.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSString (Utilities)

- (BOOL)isNotEmpty;
- (NSString *)trim;
- (BOOL)contains:(NSString *)partialString;
- (BOOL)doesNotContain:(NSString *)partialString;
- (BOOL)isValidEmailAddress;

- (NSString *)repeat:(NSUInteger)times;

- (BOOL)isEmpty;

@end
