//
//  SceneDelegate.m
//  Youtube
//
//  Created by New on 2020/6/25.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "SceneDelegate.h"
#import "FindPageTableViewController.h"
#import "DateCollectionViewController.h"
#import "AddGuests/GuestTableViewController.h"
#import "FrontPage/BeforeClick/FrontPageViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *mainscene = (UIWindowScene *)scene;
    _window = [[UIWindow alloc] initWithFrame:mainscene.coordinateSpace.bounds];
    _window.windowScene = mainscene;
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    //设置section内的cell的间距
    layout.minimumInteritemSpacing = 0;
    //设置section内部的行间距
    layout.minimumLineSpacing = 5;
    //设置section之间的距离
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    //设置header的size
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 80);
    DateCollectionViewController *controller = DateCollectionViewController.new;
    FindPageTableViewController *findpageviewcontroller = [[FindPageTableViewController alloc] init];
    GuestTableViewController *addguestviewcontroller = [[GuestTableViewController alloc] init];
    FrontPageViewController *frontpagevc = FrontPageViewController.new;
    
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:frontpagevc];
    [_window makeKeyAndVisible];
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
