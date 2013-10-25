//
//  GameCenterUtil.m
//  GameCenterEx
//
//  Created by Lee Jaewhan on 11. 9. 9..
//  Copyright 2011년 Gikimi-SW. All rights reserved.
//

#import "GameCenterUtil.h"

@implementation GameCenterUtil

// 게임센터가 사용가능한지 알아보는 메서드. 게임센터는 iOS 4.1 이후부터 지원된다.
+ (BOOL)isGameCenterAPIAvailable
{
    // Check for presence of GKLocalPlayer class.
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    
    // The device must be running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (localPlayerClassAvailable && osVersionSupported);
}

// 게임센터에 접속 및 인증받는 메서드
+ (void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            // Perform additional tasks for the authenticated player.
            NSLog(@"Alias:%@",localPlayer.alias);
            NSLog(@"Player ID:%@",localPlayer.playerID);
        }
    }];
}



// 게임센터서버에 점수 보내는 메서드
+ (void)reportScore:(int64_t)score
{
    // category가 게임센터에서 설정한 Leaderboard ID
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:LeaderboardID] autorelease];
    scoreReporter.value = score;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            // handle the reporting error
        }
    }];
}

// 게임센터 서버로 목표달성도를 보낸다. 첫번째가 목표ID, 두번째가 달성도. 100%면 목표달성임
+ (void)reportAchievementIdentifier:(NSString*)identifier percentComplete:(float) percent
{
    NSLog(@"--겜센터 : sendAchievementWithIdentifier %@ , %f",identifier,percent);

    GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
    if (achievement)
    {
        achievement.percentComplete = percent;
        [achievement reportAchievementWithCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 // Retain the achievement object and try again later (not shown).
             }
         }];
    }
}

// 목표달성도를 리셋하는 메서드
+ (void)resetAchievements
{
    // Clear all progress saved on Game Center
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
     {
         if (error != nil) {
             // handle errors
         }
     }];
}


@end
