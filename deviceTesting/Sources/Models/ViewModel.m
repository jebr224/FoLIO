//
//  ViewModel.m
//  deviceTesting
//
//  Created by John B on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewModel.h"



#define ROTATION_SENSITIVITY .2 /*the larger the number the more sensitive the rotation will be */
#define ZOOM_SENSITIVITY 6.0  /*the lager the number the less sensitive the zoom will be*/
@interface ViewModel()
@property(nonatomic)CGPoint centerScreen;
@end
@implementation ViewModel

//@synthesize CoolView = _CoolView;
@synthesize posX = _posX;
@synthesize posY = _posY;
@synthesize posZ = _posZ;
@synthesize rotation = _rotation;
@synthesize zoom = _zoom;
@synthesize centerScreen = _centerScreen;



-(ViewModel* ) init
{
    self = [super init]; //super = NSobject
    if(self) 
    {
        
        _posX = 0;
        _posY = 0;
        _posZ = _zoom = .5;
        
        _rotation.x = 180;
        _rotation.y = 0;
        _rotation.z = 0;
        
        _centerScreen.y = (_posX + 780)/2;
        _centerScreen.x = (_posY + 1021)/2;
        
         NSLog(@"ViewModel is init");
        return self;
    }
    assert(YES);
    NSLog(@"ViewModel may have error");
    return self;
}

-(void)rotateModelByX:(CGFloat)degreesX 
                  ByY:(CGFloat)degreesY
                  ByZ:(CGFloat)degreesZ
{
    _rotation.x += degreesX;
    _rotation.y += degreesY;
    _rotation.z += degreesZ;
    
     //OBJ rotation restrictions
    if (_rotation.x > 270)
        _rotation.x = 270;
    else if (_rotation.x < 90)
        _rotation.x = 90;
    
    if (_rotation.y > 90)
        _rotation.y =90;
    else if (_rotation.y < -90)
        _rotation.y = -90;
    
    return;
    
}

-(void)zoomAmountBy:(float) scale
         aboutPoint:(CGPoint) toutch
{
    _zoom = ((scale + (float)(ZOOM_SENSITIVITY) -1.0 ))/ ((float)(ZOOM_SENSITIVITY)) * _zoom;
        
    
    CGFloat move = (_zoom)/120000;
    /*
    _centerScreen.x =(toutch.x +  _centerScreen.x)/2;
    _centerScreen.y =(toutch.y +  _centerScreen.y)/2;
    NSLog(@"s screen x = %f", _centerScreen.x);
    
    [self moveByX:(_centerScreen.x * move)
              ByY:(_centerScreen.y* move)
              ByZ:(0)];     
    

    */
    [self moveByX:((-toutch.x + _centerScreen.x) * move)
              ByY:((toutch.y - _centerScreen.y)* move)
              ByZ:(0)];
    
    
    
    //Zoom restrictions
    if (_zoom < .3)
        _zoom = .3;
    else if (_zoom > 2)
        _zoom =2;
    
    _posZ = _zoom;

}

-(void)moveByX:(CGFloat)x
           ByY:(CGFloat)y
           ByZ:(CGFloat)z
{
    _posX += x;
    _posY += y;
    _posZ += z;

    return;
}




@end





























