//
//  SceneDelegate.m
//  3DTouchDemo
//
//  Created by hxbank on 2023/12/4.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
        
    [self initShortcutItems];
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.frame = UIScreen.mainScreen.bounds;
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}

- (void)initShortcutItems {
    if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        // 创建3DTouch的ShortcutItems由两种方式（注意：最多展示4个子item）
        // 1.静态配置，直接在info.plist中配置UIApplicaitonShortcutItems
        // 2.动态创建，代码编写
        UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"type1" localizedTitle:@"标签1" localizedSubtitle:@"111" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:@{
            @"sex": @"男"
        }];
        
        UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3DTouch_zero"];
        UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"type2" localizedTitle:@"标签2" localizedSubtitle:@"222" icon:icon2 userInfo:@{
            @"age": @"28"
        }];
        
        UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3DTouch_account"];
        UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"type3" localizedTitle:@"标签3" localizedSubtitle:@"333" icon:icon3 userInfo:nil];
        
        UIApplication.sharedApplication.shortcutItems = @[item1, item2, item3];
    }
}

- (void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqualToString:@"type0"]) {
        NSLog(@"%@", shortcutItem.userInfo);
    }
    if ([shortcutItem.type isEqualToString:@"type3"]) {
        NSLog(@"%@", shortcutItem.userInfo);
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
