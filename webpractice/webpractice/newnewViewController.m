//
//  newnewViewController.m
//  webpractice
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "newnewViewController.h"
#import "MyCell.h"
@interface newnewViewController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,MyCellDelegate>

@end

@implementation newnewViewController
{
    UITableView * _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"cell";
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
//    cell.delegate = self;
    cell.adelegate = self;
//    cell.allowsButtonsWithDifferentWidth = YES;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
   
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction
//{
//    return YES;
//}
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    
//    expansionSettings.buttonIndex = 0;
    
    __weak newnewViewController * me = self;
    
    if (direction == MGSwipeDirectionLeftToRight) {
        
        expansionSettings.fillOnTrigger = YES;
        expansionSettings.threshold = 2;
        return @[[MGSwipeButton buttonWithTitle:@"test" backgroundColor:[UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0] padding:5 callback:^BOOL(MGSwipeTableCell *sender) {
            
            NSIndexPath * i = [_tableView indexPathForCell:sender];
            NSLog(@"good==%d",i.row);
            
            return YES;
        }]];
    }
    else {
        
        expansionSettings.fillOnTrigger = YES;
        expansionSettings.threshold = 1.1;
        
        CGFloat padding = 15;
        
        MGSwipeButton * trash = [MGSwipeButton buttonWithTitle:@"Trash" backgroundColor:[UIColor colorWithRed:1.0 green:59/255.0 blue:50/255.0 alpha:1.0] padding:padding+20 callback:^BOOL(MGSwipeTableCell *sender) {
            
           
            return NO; //don't autohide to improve delete animation
        }];
        MGSwipeButton * flag = [MGSwipeButton buttonWithTitle:@"Flag" backgroundColor:[UIColor colorWithRed:1.0 green:149/255.0 blue:0.05 alpha:1.0] padding:padding callback:^BOOL(MGSwipeTableCell *sender) {
            
           //needed to refresh cell contents while swipping
            return YES;
        }];
        MGSwipeButton * more = [MGSwipeButton buttonWithTitle:@"More" backgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:205/255.0 alpha:1.0] padding:padding-20 callback:^BOOL(MGSwipeTableCell *sender) {
            
            return NO; //avoid autohide swipe
        }];
        
        return @[trash, flag, more];
    }
    
    return nil;
    
}
-(void)youxi
{
    NSLog(@"hehe");
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
