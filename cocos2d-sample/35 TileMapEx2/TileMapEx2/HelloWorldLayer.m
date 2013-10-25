//
//  HelloWorldLayer.m
//  TileMapEx2
//
//  Created by Lee Jaewhan on 11. 9. 4..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"


@implementation HelloWorldLayer
@synthesize dragon = _dragon;

- (void)dealloc
{
    [_dragon release];
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
        
        // 터치 활성화
        self.isTouchEnabled = YES;
        
        // 화면 사이즈 구하기
        winSize = [[CCDirector sharedDirector] winSize];

        // 타일맵 읽어 오기
        tmap = [CCTMXTiledMap tiledMapWithTMXFile:@"TestDesert.tmx"];
        [self addChild:tmap z:-1 tag:100];
    
        
        // 타일맵에서 Obejcts라고 지정한 오브젝트 레이어의 객체들 가져오기
        CCTMXObjectGroup *objects = [tmap objectGroupNamed:@"Objects"];
        
        // 오브젝트 레이어어에서 SpawnPoint라고 지정한 속성값 읽어 오기
        NSMutableDictionary *spawnPoint = [objects objectNamed:@"SpawnPoint"];
        
        int x = [[spawnPoint valueForKey:@"x"] intValue];
        int y = [[spawnPoint valueForKey:@"y"] intValue];
        
        // SpawnPoint의 위치로 생성할 드래곤의 위치 지정하기
        dragonPosition = ccp(x, y);
        
        // 드래곤을 만든다.
        [self createDragon];

//        [self setViewpointCenter:self.dragon.position];
    }
    return self;
}


//- (void)setViewpointCenter:(CGPoint)position
//{
//    
//    int x = MAX(position.x, winSize.width / 2);
//    int y = MAX(position.y, winSize.height / 2);
//    
//    x = MIN(x, (tmap.mapSize.width * tmap.tileSize.width) - winSize.width / 2);
//    
//    y = MIN(y, (tmap.mapSize.height * tmap.tileSize.height) - winSize.height/2);
//    
//    CGPoint actualPosition = ccp(x, y);
//    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
//    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
//    
//    self.position = viewPoint;
//}

- (void)createDragon
{
    
    // 움직이는 드래곤 넣기 시작
    CCSprite *sprite = [CCSprite spriteWithFile:@"dragon_animation.png"];
    
    CCAnimation *animation = [[CCAnimation alloc] init];
    
    [animation setDelay:0.1];
    
    // 제일 첫번째 프레임으로 주인공 sprite를 만듭니다.
    self.dragon = [CCSprite spriteWithTexture:sprite.texture rect:CGRectMake(0, 0, 130, 140)];
    
    for(int i=0;i<6;i++){
        // 첫째 줄에 4개의 프레임이 있고, 5번째 부터는 두 번째 줄에 있으므로,
        // 5번째(idx==4)부터는 y 좌표의 값을 증가시켜야 한다.
        NSUInteger index    = i % 4;
        NSUInteger rowIndex = i / 4;
        
        [animation addFrameWithTexture:sprite.texture rect:CGRectMake(index*130, rowIndex*140, 130, 140)];
    }
    
    self.dragon.position = dragonPosition;
    
    CCAnimate *animate=[CCAnimate actionWithAnimation:animation];
    animate=[CCRepeatForever actionWithAction:animate];
    [self.dragon runAction:animate];
    
    // 드래곤의 방향을 바꾸어준다.
    self.dragon.flipX = YES;

    // 드래곤의 사이즈를 줄여준다. 맵에 비해 너무 크다.
    self.dragon.scale = 0.5;

    [self addChild:self.dragon];
    
}

@end
