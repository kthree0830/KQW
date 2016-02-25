//
//  AppDelegate.m
//  webpractice
//
//  Created by 夏季 on 16/1/4.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "newViewController.h"
#import "newnewViewController.h"
#import "oneViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController * rootVC = [[ViewController alloc]init];
    newViewController * new = [[newViewController alloc]init];
    newnewViewController * newnew = [[newnewViewController alloc]init];
    oneViewController * one = [[oneViewController alloc]init];
    
    UITabBarController * bvc = [[UITabBarController alloc]init];
    
    UINavigationController * n = [[UINavigationController alloc]initWithRootViewController:new];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:rootVC];
    UINavigationController * nn = [[UINavigationController alloc]initWithRootViewController:newnew];
    UINavigationController * onen = [[UINavigationController alloc]initWithRootViewController:one];
    
    bvc.viewControllers = @[navc,n,one];
    bvc.tabBar.tintColor = [UIColor redColor];
    bvc.tabBar.backgroundColor = [UIColor
                                  greenColor];
    UITabBarItem * item1 = [[UITabBarItem alloc]initWithTitle:@"haha" image:[UIImage imageNamed:@"icon_hot@2x.png"] selectedImage:nil];
    UITabBarItem * item2 = [[UITabBarItem alloc]initWithTitle:@"haha" image:nil selectedImage:nil];
    UITabBarItem * item3 = [[UITabBarItem alloc]initWithTitle:@"yes" image:nil selectedImage:nil];
    
    bvc.tabBar.barTintColor = [UIColor yellowColor];
    navc.tabBarItem = item1;
    n.tabBarItem = item2;
    nn.tabBarItem = item3;
    self.window.rootViewController = bvc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
