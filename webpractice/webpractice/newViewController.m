//
//  newViewController.m
//  webpractice
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "newViewController.h"
#import "UIImageView+WebCache.h"
#import "AddressBook.h"
@interface newViewController ()

@end

@implementation newViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * arr =[AddressBook addressBooks];
    NSLog(@"%@",arr);
    for (AddressBookObj * obj in arr) {
        NSLog(@"recordID = %d, compositeName = %@, pbone = %@, phoneInfo = %@",obj.recordID,obj.compositeName,obj.pbone,obj.phoneInfo);
    }
    
}
- (UIImage*)resizeImage:(UIImage*)image withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGFloat widthRatio = newSize.width/image.size.width;
    CGFloat heightRatio = newSize.height/image.size.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    NSLog(@"本地更改%@",NSStringFromCGSize(newSize));
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGSize)resize:(CGSize )imageSize withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGFloat widthRatio = newSize.width/imageSize.width;
    CGFloat heightRatio = newSize.height/imageSize.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(imageSize.width*heightRatio,imageSize.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(imageSize.width*widthRatio,imageSize.height*widthRatio);
    }
    
    return newSize;
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
