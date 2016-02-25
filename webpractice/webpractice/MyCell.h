//
//  MyCell.h
//  webpractice
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "MGSwipeTableCell.h"
@protocol MyCellDelegate <NSObject>

-(void)youxi;

@end

@interface MyCell : UITableViewCell
@property(nonatomic,weak)id<MyCellDelegate>adelegate;
@end
