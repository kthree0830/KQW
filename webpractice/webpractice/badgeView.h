//
//  badgeView.h
//  webpractice
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol badgeViewDelegate <NSObject>

-(void)removeBadgeView;

@end
@interface badgeView : UIImageView
@property (nonatomic) CGFloat maxDistance;
@property (nonatomic,weak)id <badgeViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame maxDistance:(CGFloat)maxDistance;
@end
