//
//  RemindBadgeView.h
//  webpractice
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemindBadgeView;
@protocol RemindBadgeViewDelegate <NSObject>

-(void)removeRemindBadgeView:(RemindBadgeView *)remindBadgeView;

@end
@interface RemindBadgeView : UIImageView
@property (nonatomic) CGFloat maxDistance;
@property (nonatomic,weak)id <RemindBadgeViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame maxDistance:(CGFloat)maxDistance;
@end
