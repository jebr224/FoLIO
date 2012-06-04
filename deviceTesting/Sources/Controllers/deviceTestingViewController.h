/*
 *	deviceTestingViewController.h
 *	deviceTesting
 *	
 *	Created by John B on 5/22/12.
 *	Copyright 2012 __MyCompanyName__. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface deviceTestingViewController : UIViewController <NGLViewDelegate>
{
@private
	NGLMesh *_mesh;
	NGLCamera *_camera;
}
-(void)pinch:(UIPinchGestureRecognizer* )zoom ;
@end
