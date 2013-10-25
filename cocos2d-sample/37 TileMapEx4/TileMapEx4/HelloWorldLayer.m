//
//  HelloWorldLayer.m
//  TileMapEx4
//
//  Created by Lee Jaewhan on 11. 9. 5..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"


@implementation HelloWorldLayer
@synthesize dragon = _dragon;
@synthesize tmap = _tmap;
@synthesize background = _background;
@synthesize items = _items;
@synthesize metainfo = _metainfo;

- (void)dealloc
{
    [_dragon release];
    [_tmap release];
    [_background release];
    [_items release];
    [_metainfo release];
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
        self.tmap = [CCTMXTiledMap tiledMapWithTMXFile:@"TestDesert.tmx"];
        self.background = [self.tmap layerNamed:@"Background"];
        self.items      = [self.tmap layerNamed:@"Items"];
        self.metainfo   = [self.tmap layerNamed:@"MetaInfo"];
        self.metainfo.visible = NO;

        // 타일맵으로 배경 구성하기
        [self addChild:self.tmap z:-1 tag:100];
        
        // 타일맵에서 Obejcts라고 지정한 오브젝트 레이어의 객체들 가져오기
        CCTMXObjectGroup *objects = [self.tmap objectGroupNamed:@"Objects"];
        
        // 오브젝트 레이어어에서 SpawnPoint라고 지정한 속성값 읽어 오기
        NSMutableDictionary *spawnPoint = [objects objectNamed:@"SpawnPoint"];
        
        int x = [[spawnPoint valueForKey:@"x"] intValue];
        int y = [[spawnPoint valueForKey:@"y"] intValue];
        
        // SpawnPoint의 위치로 생성할 드래곤의 위치 지정하기
        dragonPosition = ccp(x, y);
        
        // 드래곤을 만든다.
        [self createDragon];
        
        // 드래곤의 위치에 따라 배경의 위치를 이동한다.
        [self setViewpointCenter:self.dragon.position];
    }
    return self;
}


- (void)setViewpointCenter:(CGPoint)position
{
    // 파라미터로 들어오는 위치에 맞춰 화면을 움직인다.
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    
    x = MIN(x, (self.tmap.mapSize.width * self.tmap.tileSize.width) - winSize.width / 2);
    
    y = MIN(y, (self.tmap.mapSize.height * self.tmap.tileSize.height) - winSize.height/2);
    
    CGPoint actualPosition = ccp(x, y);
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    
    self.position = viewPoint;
}

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
    self.dragon.scale = 0.4;
    
    // 드래곤의 실제 이미지를 보면 상단에 공백 부분이 있어
    // 위의 스케일이 0.5에 기본 앵커포인트면 눈에 보이는 것보다
    // 실제로 Tile 하나 위에 위치하게 된다.
    // 그래서 사이즈 및 앵커포인트를 조정해 준 것이다.
    
    self.dragon.anchorPoint = ccp(0.5, 0.2);
    
    [self addChild:self.dragon];
    
}

- (void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                     priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)setPlayerPosition:(CGPoint)position
{
    // 추가된 부분 시작 ----------------------------------------
    
    // 탭된 위치 구하기
    CGPoint tileCoord = [self tileCoordForPosition:position];
    
    // 현재 위치의 Tile GID 구하기
    int tileGid = [self.metainfo tileGIDAt:tileCoord];

    if (tileGid) {
        
        // 타일맵에서 GID에 해당하는 부분의 속성 읽어 오기
        NSDictionary *properties = [self.tmap propertiesForGID:tileGid];

        if (properties) {
            
            NSString *wall = [properties valueForKey:@"Wall"];
            if (wall && [wall compare:@"YES"] == NSOrderedSame) {
                return;
            }
            
            // 추가된 부분 시작2 ----------------------------------------
            NSString *item1 = [properties valueForKey:@"Items1"];
            if (item1 && [item1 compare:@"YES"] == NSOrderedSame) {
                
                [self.metainfo removeTileAt:tileCoord];
                [self.items removeTileAt:tileCoord];
                
                // 먹은 수만큼 점수를 올려주는 코딩이 추가적으로 필요하다.
                NSLog(@"아이템 획득!!! 이 메시지가 여러번 출력되는지 확인");
            }
            // 추가된 부분 끝2 ----------------------------------------
        }
    }

    // 추가된 부분 끝 ----------------------------------------

    
    // 파라미터로 들어온 위치에 드래곤 위치 조정하기
    self.dragon.position = position;
}

// 현재 탭으로 선택된 타일의 위치를 가져온다..
- (CGPoint)tileCoordForPosition:(CGPoint)position
{
    int x = position.x / self.tmap.tileSize.width;
    int y = ((self.tmap.mapSize.height * self.tmap.tileSize.height) - position.y) / self.tmap.tileSize.height;
    return ccp(x, y);
}


- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    CGPoint playerPos = self.dragon.position;
    CGPoint diff = ccpSub(touchLocation, playerPos);
    
    if (abs(diff.x) > abs(diff.y)) {
        if (diff.x > 0) {
            playerPos.x += self.tmap.tileSize.width;
            
            // 드래곤의 방향을 바꾸어준다.
            self.dragon.flipX = YES;
        } else {
            playerPos.x -= self.tmap.tileSize.width;
            
            // 드래곤의 방향을 바꾸어준다.
            self.dragon.flipX = NO;
        }
    } else {
        if (diff.y > 0) {
            playerPos.y += self.tmap.tileSize.height;
        } else {
            playerPos.y -= self.tmap.tileSize.height;
        }
    }
    
    if (playerPos.x <= (self.tmap.mapSize.width * self.tmap.tileSize.width) &&
        playerPos.y <= (self.tmap.mapSize.height * self.tmap.tileSize.height) &&
        playerPos.y >= 0 &&
        playerPos.x >= 0 )
    {
        // 드래곤의 새로운 위치 지정
        [self setPlayerPosition:playerPos];
    }
    
    // 드래곤의 위치에 맞춰 화면 위치 조정
    [self setViewpointCenter:self.dragon.position];
}

@end

