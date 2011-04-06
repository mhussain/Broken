//
//  Build.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Build : NSObject 
{
  NSString *name_;
  NSString *url_;
  UIColor *currentState_;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) UIColor *currentState;

+ (id)buildFromDictionary:(NSDictionary *)dictionary;
//- (UIColor *)color;

@end
