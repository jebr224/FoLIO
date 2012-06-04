 /*
 *	main.m
 *	deviceTesting
 *	
 *	Created by John B on 5/22/12.
 *	Copyright 2012 __MyCompanyName__. All rights reserved.
 */

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"deviceTestingAppDelegate");
	[pool release];
	return retVal;
}
