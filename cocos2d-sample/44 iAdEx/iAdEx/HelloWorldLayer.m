//
//  HelloWorldLayer.m
//  iAdEx
//
//  Created by Lee Jaewhan on 11. 9. 18..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"


@implementation HelloWorldLayer

@synthesize iadScene;

- (void)dealloc
{
    [iadScene release];
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
    
    
        
        iadScene = [[iAdView alloc]init];
		[self addChild:iadScene z:100 tag:100];

    }
    return self;
}

@end
