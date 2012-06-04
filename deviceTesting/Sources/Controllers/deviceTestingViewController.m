/*
 *	deviceTestingViewController.m
 *	deviceTesting
 *	
 *	Created by John B on 5/22/12.
 *	Copyright 2012 __MyCompanyName__. All rights reserved.
 */

#import "deviceTestingViewController.h"
#import "ViewModel.h"

@interface deviceTestingViewController()


@property (nonatomic, strong) ViewModel *model;

//@property (nonatomic) int zoom;
//@property (nonatomic) float posX;
//@property (nonatomic) float posY;
//@property (nonatomic) float posZ;

@property (nonatomic) float userZrotations; 
@property (nonatomic) CGPoint rotationPoint;
@property (nonatomic) CGPoint holder;

@property(nonatomic) BOOL InUVMode;

@property (nonatomic, strong)  NGLTexture *UVtexture;
@property (nonatomic, strong) NGLMaterial *UVmaterial;

@property (nonatomic, strong)  NGLTexture *NoramlTexture;
@property (nonatomic, strong) NGLMaterial *NoramalMaterial;


@property (nonatomic, strong) NGLShaders *myShader;
@property (nonatomic, strong) NGLShadersMulti * myMultShader;
@property (nonatomic, strong) NSString *vertex;


@property (retain, nonatomic) IBOutlet NGLView *CoolView;


@property ( nonatomic,strong) NSString *fileString;

@end


#pragma mark -
#pragma mark Constants
#pragma mark -
//**********************************************************************************************************
//
//	Constants
//
//**********************************************************************************************************

#pragma mark -
#pragma mark Private Interface
#pragma mark -
//**********************************************************************************************************
//
//	Private Interface
//
//**********************************************************************************************************

#pragma mark -
#pragma mark Public Interface
#pragma mark -
//**********************************************************************************************************
//
//	Public Interface
//
//**********************************************************************************************************

@implementation deviceTestingViewController

//@synthesize zoom = _zoom;
@synthesize CoolView = _CoolView;
//@synthesize posX = _posX;
//@synthesize posY = _posY;
//@synthesize posZ = _posZ;

@synthesize model = _model;

@synthesize userZrotations = _userZrotations;
@synthesize rotationPoint= _roationPoint;
@synthesize holder = _holder;
@synthesize vertex = _vertex;

@synthesize InUVMode = _InUVMode;

@synthesize UVtexture = _UVtexture;
@synthesize UVmaterial = _UVmaterial;

@synthesize NoramlTexture = _NoramlTexture;
@synthesize NoramalMaterial = _NoramalMaterial;


@synthesize myShader = _myShader;
@synthesize myMultShader = _myMultShader;

@synthesize fileString =_fileString;

#pragma mark -
#pragma mark Properties
//**************************************************
//	Properties
//**************************************************

#pragma mark -
#pragma mark Constructors
//**************************************************
//	Constructors
//**************************************************

#pragma mark -
#pragma mark Private Methods
//**************************************************
//	Private Methods
//**************************************************

#pragma mark -
#pragma mark Self Public Methods
//**************************************************
//	Self Public Methods
//**************************************************

- (void) drawView
{
    _mesh.z = [_model posZ]; // _posZ;
    _mesh.x = [ _model posX];
    _mesh.y = [_model posY];
    
   

    
    _mesh.rotateZ = _model.rotation.z;  
    _mesh.rotateY = _model.rotation.y;  
    _mesh.rotateX = _model.rotation.x; 
    
    
  // NSLog(@"--%f", [[self model] posZ]);
  // NSLog(@"rot x = %f, rot y = %f, rot z =%f", [_mesh rotateX],[_mesh rotateY],[_mesh rotateZ]);

[_camera drawCamera];
}




- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer 
{
   //NSLog(@"Pinch scale: %f", recognizer.scale);
   //NSLog(@"X cord  = %f Y cord Y =%f", 
     //[recognizer locationInView:(self.view)].x, 
     //[recognizer locationInView:(self.view)].y );

    
    [_model zoomAmountBy:(recognizer.scale)
              aboutPoint:[recognizer locationInView:(self.view)]];
    
   // [[self model] setPosZ:(((recognizer.scale + (float)(ZOOM_SENSITIVITY) -1.0 ))/ ((float)(ZOOM_SENSITIVITY))* ( [[self model] posZ]))]; 
    
    
    recognizer.scale =1;
}


- (void)twoFingersRotate:(UIRotationGestureRecognizer *)recognizer 
{
// Convert the radian value to show the degree of rotation
NSLog(@"Rotation in degrees since last change: %f , X cord  = %f Y cord Y = %f", 
      [recognizer rotation]*(180 / M_PI), [recognizer locationInView:(self.view)].x, [recognizer locationInView:(self.view)].y );
_userZrotations -= [recognizer rotation] * (180 / M_PI);
recognizer.rotation = 0;
}


-(void)pan:(UIPanGestureRecognizer *) recognizer
{
    if (recognizer.state ==UIGestureRecognizerStateBegan) 
    {
        _holder = [recognizer locationInView:_CoolView];
        NSLog(@"yeah");
    }
    else{
    CGPoint temp = [recognizer locationInView:_CoolView];
    NSLog(@"in pan");

    
    
   // [_model rotateModelByX:(temp.x - _holder.x) * .2
   //                 ByY:-(temp.y - _holder.y) * .2
   //                 ByZ:0];
    
        
        [_model rotateModelByX:(temp.y - _holder.y) * .2
                           ByY:(temp.x - _holder.x) * .2
                           ByZ:0];
    /* //DEA object rotation
    _roationPoint.y -= (temp.x - _holder.x) * .2;
    _roationPoint.x -= (temp.y - _holder.y) * .2;
     */
     
    /* //DEA rotation restrictions
    if (_roationPoint.x > -0)
        _roationPoint.x =-0;
    else if (_roationPoint.x < -180)
        _roationPoint.x = -180;
    
    if (_roationPoint.y > 90)
        _roationPoint.y =90;
    else if (_roationPoint.y < -90)
        _roationPoint.y = -90;
    */
    
    _holder = temp;
    }
}


- (void)oneFingerTwoTaps:(UIGestureRecognizer *) recognizer
{
NSLog(@"Action: One finger, two taps");

    
    if(_InUVMode)
    {
        _mesh.material =  _UVmaterial;
        
        _InUVMode = FALSE;
    }
    else 
    {
        _mesh.material = _NoramalMaterial;
        _InUVMode = TRUE;
    }
    
    [_mesh compileCoreMesh];
    
    
    
}

- (void)twoFingersTwoTaps 
{
NSLog(@"Action: Two fingers, two taps");
   
    NSLog( @"Mesh structures Count%u", _mesh.structuresCount);
    NSLog(@"Index Count %u", _mesh.indicesCount);
    NSLog(@"Mesh Elements count %i",[[_mesh meshElements] count]);
  
    
    
    NGLMeshElements * mainElements = [_mesh meshElements];
    
    unsigned int *prt = [_mesh indices];
    for( int i =0; i < [_mesh indicesCount]; i++)
    {
        NSLog(@"index = %u", *prt);
        prt++;
    }
    
        
        
    NGLElement * myElement = [mainElements elementWithComponent:NGLComponentVertex];
    NSLog(@"START = %i",(*myElement).start);
    
    NSLog(@"LENGTH= %i", myElement->length);
    
    
    /*
    while ( myElement =  ([mainElements nextIterator]) ) //Sorry, I took this from the Examples for nextIterator
    {
        NSLog(@"hello %u", myElement->component);
    }
    */
       
    
   // for(int i =0 ; i < [[_mesh meshElements] count] ; i++)
   // {
   //     NSLog(@"the lenght of the vext = %i", myElement->start);
     //   myElement++;
    //}

 } 


#pragma mark -
#pragma mark Override Public Methods
//**************************************************
//	Override Public Methods
//**************************************************

- (void) viewDidLoad
{
    
    
    // Must call super to agree with the UIKit rules.
    [ super viewDidLoad];

    // Setting the loading process parameters. To take advantage of the NGL Binary feature,
    // remove the line "kNGLMeshOriginalYes, kNGLMeshKeyOriginal,". Your mesh will be loaded 950% faster.
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                          kNGLMeshOriginalYes, kNGLMeshKeyOriginal,
                          kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                          @"0.3", kNGLMeshKeyNormalize,
                          nil];

   //_mesh = [[NGLMesh alloc] initWithFile:@"done.dae" settings:settings delegate:nil];
  
    
    
    //Create the Main MESH
    _mesh = [[NGLMesh alloc] initWithFile:@"chad001re3d_textured.obj" 
                                 settings:settings delegate:nil];
    
    //Create the MODEL
    _model = [[ViewModel alloc] init]; //call the over riden methode
    
    
    //create the UV image
    _UVtexture = [[NGLTexture alloc] init2DWithFile:@"FakeUV.png"];
    _UVmaterial = [[ NGLMaterial alloc] init ];
    _UVmaterial.diffuseMap = _UVtexture;
    
    //Create the noram image
    _NoramlTexture = [[NGLTexture alloc] init2DWithFile:@"medium.png"];
    _NoramalMaterial = [[ NGLMaterial alloc] init ];
    _NoramalMaterial.diffuseMap = _NoramlTexture;
    
    _mesh.material = _NoramalMaterial;
    _InUVMode = FALSE; 
    

    
    _myShader = [[ NGLShaders alloc] initWithFilesVertex :   @"chad001re3d_textured.obj.mtl" //((_mesh.shaders) vertex)
                                              andFragment: @"FakeUV.png"];
    
    
        
    _camera = [[NGLCamera alloc] initWithMeshes:_mesh, nil];
    [_camera autoAdjustAspectRatio:YES animated:YES];
     

    

    _mesh.rotationSpace  = NGLRotationSpaceWorld; 
            //  _mesh.rotationSpace = NGLRotationSpaceLocal;
            //  _mesh.rotateRelativeToX:1.0 toY: 1.0 toZ: 1.0];
    
    
  //  _mesh.z  = .5;
    _roationPoint.x = 180;
    _roationPoint.y = 0 ;// 360;
    _userZrotations = 0;
  
    
    self.CoolView.autoresizesSubviews = NO;
    self.view.autoresizesSubviews = NO;
    [[self view] setClipsToBounds:YES];
    [[self CoolView] setClipsToBounds:YES];
    [_CoolView setAutoresizingMask :UIViewAutoresizingNone];
    [[self view] setAutoresizingMask:UIViewAutoresizingNone];
    
    [[self view ] setContentMode:UIViewContentModeCenter];
    [_CoolView setContentMode:UIViewContentModeCenter];
    
    //[[self view] sizeToFit];
    
    //  [[self CoolView] setContentMode:UIViewContentModeCenter];
    //[_CoolView setContentMode:UIViewContentModeCenter];



   
    
    
    
    //ADDING GESTURES
    
    //Pinch
    UIPinchGestureRecognizer *twoFingerPinch =  [[[UIPinchGestureRecognizer alloc] 
                                              initWithTarget:self action:@selector(twoFingerPinch:)] autorelease];
    [[self view] addGestureRecognizer:twoFingerPinch];

    //Rotate
    UIRotationGestureRecognizer *twoFingersRotate = 
    [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersRotate:)] autorelease];
    [[self view] addGestureRecognizer:twoFingersRotate];

    //Pan
    UIPanGestureRecognizer *pan = 
    [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)] autorelease];
    [pan setMaximumNumberOfTouches:1];
    [[self view] addGestureRecognizer:pan];

    //One finger Two taps
    UITapGestureRecognizer *oneFingerTwoTaps = 
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps:)] autorelease];
    [oneFingerTwoTaps setNumberOfTapsRequired:2];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    [[self view] addGestureRecognizer:oneFingerTwoTaps];

    //Two fingers two taps
    UITapGestureRecognizer *twoFingersTwoTaps = 
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersTwoTaps)] autorelease];
    [twoFingersTwoTaps setNumberOfTapsRequired:2];
    [twoFingersTwoTaps setNumberOfTouchesRequired:2];
    [[self view] addGestureRecognizer:twoFingersTwoTaps];


    // Starts the debug monitor.
   [[NGLDebug debugMonitor] startWithView:(NGLView *)self.view];
}



- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{

    self.CoolView.autoresizesSubviews = NO;
    self.view.autoresizesSubviews = NO;
    [[self view] setClipsToBounds:YES];
    [[self CoolView] setClipsToBounds:YES];
    [_CoolView setAutoresizingMask :UIViewAutoresizingNone];
    [[self view] setAutoresizingMask:UIViewAutoresizingNone];
    
    // self.view.autoresizesSubviews = NO;
    //[[self view] sizeToFit];
     //  return (UIInterfaceOrientationLandscapeLeft == toInterfaceOrientation);
    return YES;
}

- (void) dealloc
{
    [_mesh release];
    [_camera release];

    [_CoolView release];
    [super dealloc];
}

- (void)viewDidUnload 
{
    [self setCoolView:nil];
    [super viewDidUnload];
}
@end
