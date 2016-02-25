//
//  oneViewController.m
//  webpractice
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "oneViewController.h"
#import "badgeView.h"
#import "XMBadgeView.h"
@interface oneViewController ()<badgeViewDelegate>

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    badgeView * badge = [[badgeView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    badge.delegate = self;
    badge.maxDistance = 200;
    [self.view addSubview:badge];
    
    XMBadgeView * b = [[XMBadgeView alloc]initWithParentView:self.view alignment:XMBadgeViewAlignmentCenter];
    b.maxDistance = 300;
    b.badgeText = @"yes";
    b.panable = YES;
//    b.badgeTextShadowSize = CGSizeMake(20, 20);
//    b.badgeShadowColor = [UIColor blackColor];
//    b.badgeShadowSize = CGSizeMake(10, 10);
//    b.badgeTextShadowColor = [UIColor greenColor];
//    b.badgeStrokeWidth = 2;
//    b.badgeStrokeColor = [UIColor blueColor];
    [self.view addSubview:b];
    [super viewWillAppear:animated];
}
-(void)removeBadgeView
{
    NSLog(@"haha");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
