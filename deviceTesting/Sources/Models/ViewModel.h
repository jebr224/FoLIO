//
//  ViewModel.h
//  deviceTesting
//
//  Created by John B on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

struct angle {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};
typedef struct angle angle;

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

-(void)rotateModelByX:(CGFloat)degreesX 
                  ByY:(CGFloat)degreesY
                  ByZ:(CGFloat)degreesZ;

-(void)zoomAmountBy:(float) scale
         aboutPoint:(CGPoint) center;

-(void)moveByX:(CGFloat)x
           ByY:(CGFloat)y
           ByZ:(CGFloat)z;

//@property (nonatomic) int zoom;
@property (nonatomic) float posX;
@property (nonatomic) float posY;
@property (nonatomic) float posZ;
@property (nonatomic) angle rotation;
@property (nonatomic) float zoom;

@end
