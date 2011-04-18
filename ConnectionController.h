//
//  ConnectionController.h
//  Broken
//
//  Created by Mujtaba Hussain on 15/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IBAForms/IBAFormViewController.h>

@interface ConnectionController : IBAFormViewController {
	BOOL shouldAutoRotate_;
	UITableViewStyle tableViewStyle_;
}

@property (nonatomic, assign) BOOL shouldAutoRotate;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end
