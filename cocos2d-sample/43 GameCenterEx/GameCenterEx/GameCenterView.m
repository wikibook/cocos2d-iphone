//
//  GameCenterView.m
//  GameCenterEx
//
//  Created by Lee Jaewhan on 11. 9. 10..
//  Copyright 2011년 Gikimi-SW. All rights reserved.
//

#import "GameCenterView.h"
#import "GameCenterUtil.h"

@implementation GameCenterView

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([GameCenterUtil isGameCenterAPIAvailable])
        {
            // 게임센터가 가능한 단말이면 게임센터 접속
            [GameCenterUtil authenticateLocalPlayer];
        } else {
            NSLog(@"이 디바이스는 안됩니다.");
        }
    }
    return self;
}

- (void)showLeaderboard
{
    self.view.hidden = NO;

    GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init] autorelease];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;

        [self presentModalViewController:leaderboardController animated:NO];
        
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated:NO];

    self.view.hidden = YES;
}

- (void)showAchievement
{
    self.view.hidden = NO;
    
    GKAchievementViewController *achiveController = [[[GKAchievementViewController alloc] init] autorelease];
    
    if (achiveController != nil) {
        
        achiveController.achievementDelegate = self;
        
        [self presentModalViewController:achiveController animated:NO];
        
    }
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [self dismissModalViewControllerAnimated:NO];
    
    self.view.hidden = YES;    
}


@end
