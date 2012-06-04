/*
 *	deviceTestingAppDelegate.h
 *	deviceTesting
 *	
 *	Created by John B on 5/22/12.
 *	Copyright 2012 __MyCompanyName__. All rights reserved.
 */

#import <UIKit/UIKit.h>

#import "deviceTestingViewController.h"

@interface deviceTestingAppDelegate : UIResponder <UIApplicationDelegate>
{
	UIWindow *_window;
	deviceTestingViewController *_viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) deviceTestingViewController *viewController;

@end

