//
//  HelloWorldLayer.m
//  HelloWorld
//
//  Created by Lee Jaewhan on 11. 7. 31..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

- (void)dealloc
{
    [super dealloc];
}

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    [scene addChild: layer];
    
    return scene;
}

- (id)init
{
    if ( (self=[super init]) ) {
        
        // create and initialize a Label
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

        // ask director the the window size
        CGSize size = [[CCDirector sharedDirector] winSize];
    
        // position the label on the center of the screen
        label.position =  ccp( size.width /2 , size.height/2 );
        
        // add the label as a child to this Layer
        [self addChild: label];
        
    }
    return self;
}


@end
