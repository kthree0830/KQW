//
//  ViewController.m
//  webpractice
//
//  Created by 夏季 on 16/1/4.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "ViewController.h"
#import "YYWebImage.h"
#import "YYText.h"
#import "UIView+YYAdd.h"
#import "NSBundle+YYAdd.h"
#import "NSString+YYAdd.h"
#import "YYGestureRecognizer.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (nonatomic, strong) YYLabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self create];
  }

-(void)create
{
   
    
    NSInteger testLength;
    NSInteger tempLength;
    NSString * s = @"<http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png>";
    s=[s substringWithRange:NSMakeRange(1, s.length-2)];
    NSString * test = @"<http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png>haha<http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png>haha";
    NSArray * arr = @[@"<http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png>",@"<http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png>"];
    testLength = test.length;
    tempLength = tempLength;
    _label = [[YYLabel alloc]init];
    _label.backgroundColor = [UIColor redColor];
    _label.numberOfLines = 0;
    _label.userInteractionEnabled = YES;
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
//    _label.size = CGSizeMake(kScreenWidth,kScreenHeight-64);
    _label.size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
//    _label.center = CGPointMake(self.view.width / 2, self.view.height / 2+32);
    NSMutableAttributedString * text = [NSMutableAttributedString new];
    UIFont * font = [UIFont systemFontOfSize:16];
    NSInteger j = 0;
    for (NSString * str in arr) {
        NSRange range = [test rangeOfString:str];
        if (range.location>0) {
            NSString * title = [test substringToIndex:range.location];
            [text appendAttributedString:[[NSAttributedString alloc]initWithString:title attributes:nil]];
            [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n" attributes:nil]];
        }
        UIImageView * imageV = [[UIImageView alloc]init];
        imageV.frame = CGRectMake(0, 0, 150, 150);
        imageV.backgroundColor = [UIColor whiteColor];
        imageV.userInteractionEnabled=YES;
        imageV.tag = j;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired = 1;
        [imageV addGestureRecognizer:tap];
        __block UIActivityIndicatorView *ac;
        __weak UIImageView * imV = imageV;
        NSURL * url = [NSURL URLWithString:[test substringWithRange:NSMakeRange(range.location+1, range.length-2)]];
        [[SDWebImageManager sharedManager]downloadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (!ac) {
                ac = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
                ac.backgroundColor = [UIColor redColor];
                ac.hidesWhenStopped = YES;
                [imV addSubview:ac];
                [imV bringSubviewToFront:ac];
            }
            [ac startAnimating];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [ac stopAnimating];
            [ac removeFromSuperview];
            imV.image = image;
        }];
        NSMutableAttributedString * urlImg = [NSMutableAttributedString yy_attachmentStringWithContent:imageV contentMode:UIViewContentModeTop attachmentSize:imageV.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString: urlImg];
        [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n" attributes:nil]];
        test  = [test substringFromIndex:range.location+range.length];
        NSLog(@"%@",test);
        j++;
    }
    if (test.length>0) {
        [text appendAttributedString:[[NSAttributedString alloc]initWithString:test attributes:nil]];
    }
    NSLog(@"%lu",(unsigned long)test.length);
    
   #if 0
    NSString * title = @"第一段文字";
    //文本拼接
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:title attributes:nil]];
    
    
//    //换行
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    
    NSString * twoTitle = @"第二段文字";
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:twoTitle attributes:nil]];
    UIImageView * imageU = [[UIImageView alloc]init];
    imageU.backgroundColor = [UIColor whiteColor];
    imageU.size = CGSizeMake(kScreenHeight/2, kScreenHeight/2);
//    imageU.center = CGPointMake(self.view.width / 2, self.view.height / 2+32);
       [imageU sd_setImageWithURL:[NSURL URLWithString:@"http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png"] placeholderImage:nil];
    __block UIProgressView * pv;
    __block UIActivityIndicatorView *ac;
    __weak YYLabel * label = _label;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:@"http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (!ac) {
            ac = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
            ac.backgroundColor = [UIColor redColor];
            ac.hidesWhenStopped = YES;
//ac.activityIndicatorViewStyle=UIActivityIndicatorViewStyl ray;
            [label addSubview:ac];
            [label bringSubviewToFront:ac];
        }
        [ac startAnimating];
//        if (!pv) {
//            pv = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
//            
//            [_label  addSubview:pv];
//        }
//       
//        pv.progress = (float)receivedSize/(float)expectedSize;

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [ac stopAnimating];
        [ac removeFromSuperview];
//        [pv removeFromSuperview];
    }];

//    [imageU yy_setImageWithURL:[NSURL URLWithString:@"http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png"] placeholder:nil options:YYWebImageOptionShowNetworkActivity progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        if (!ac) {
//            ac = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
//            ac.backgroundColor = [UIColor redColor];
//            ac.hidesWhenStopped = YES;
////            ac.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
//            [label addSubview:ac];
//            [label bringSubviewToFront:ac];
//        }
//        [ac startAnimating];
////        if (!pv) {
////            pv = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 100, 100, 20)];
////            pv.backgroundColor = [UIColor redColor];
////            pv.progressViewStyle= UIProgressViewStyleBar;
////            [_label  addSubview:pv];
////        }
////        
////        pv.progress = (float)receivedSize/(float)expectedSize;
//
//    } transform:nil completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
////        [pv removeFromSuperview];
////        [ac stopAnimating];
////        [ac removeFromSuperview];
//    }];
//   imageU.yy_imageURL = [NSURL URLWithString:@"http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png"];
    imageU.userInteractionEnabled = YES;
////    [self.view addSubview:imageU];
    NSMutableAttributedString * urlImg = [NSMutableAttributedString yy_attachmentStringWithContent:imageU contentMode:UIViewContentModeTop attachmentSize:imageU.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: urlImg];
//
    //    //换行
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
//
    NSString * secTitle = @"第三段文字";
    //文本拼接
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:secTitle attributes:nil]];
//
    //    //换行
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
//
    NSString * thirdTitle = @"第四段文字";
    //文本拼接
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:thirdTitle attributes:nil]];
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n" attributes:nil]];
   
    UIImageView * image1 = [[UIImageView alloc]init];
    image1.size = CGSizeMake(100, 100);
    __block UIActivityIndicatorView * a ;
    __weak UIImageView *img = image1;
    [image1 sd_setImageWithURL:[NSURL URLWithString:@"http://www.gnetcloud.com/IMG_FOLDER/user/6610724670b84e98b234023d0e5b5d6b.png"] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (!a) {
            a=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            a.backgroundColor = [UIColor greenColor];
            [img addSubview:a];
        }
        [a startAnimating];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [a stopAnimating];
        [a removeFromSuperview];
    }];
    
    [text appendAttributedString:[NSMutableAttributedString yy_attachmentStringWithContent:image1 contentMode:UIViewContentModeBottom attachmentSize:image1.size alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentBottom]];
#endif
        //***************************************************
    text.yy_font = font;//设字体(在文本无内容时设置无效)
    //创建label
    
    _label.attributedText = text;
    [_label sizeToFit];
    NSLog(@"%f",_label.frame.size.height);
    self.view.userInteractionEnabled = YES;
    [self.view addSubview:_label];
    
    UIScrollView * scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.size.height)];
    
    
    UIImage * i = [UIImage imageNamed:@"N70~SP_8DEAV2)T21C~A{]X.png"];
    UIImageView * view = [[UIImageView    alloc]init];
    view.backgroundColor = [UIColor greenColor];
    view.frame = CGRectMake(0, 338, 100, 100);
//    view.image = [self resizeImage:i withWidth:100 withHeight:100];
//    view.frame = CGRectMake(0, 64, 100, view.image.size.height);
    
    
    
    
//    UIImage *srcimg = [UIImage imageNamed:@"5C9B0E11-7FD1-42F0-A3D1-F98290D67B93.png"];
//    UIImageView *imgview = [[UIImageView alloc] init];
//    imgview.frame = CGRectMake(10, 150, 150, 150);
//    CGRect rect =  CGRectMake(0, 0, 150, 150);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
//    CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], rect);
//    imgview.image = [UIImage imageWithCGImage:cgimg];
//    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
//    [self.view addSubview:imgview];
    if (i.size.width<100||i.size.height<100) {
        if (i.size.width<=i.size.height) {
            view.image = [self croppIngimageByImageName:i toRect:CGRectMake(0, 0, i.size.width, 100)];
        }else
         view.image = [self croppIngimageByImageName:i toRect:CGRectMake(0, 0, 100, i.size.height)];
    }else
        view.image = [self resizeImage:i withWidth:150 withHeight:150];
    view.contentMode = UIViewContentModeLeft;
    view.frame = CGRectMake(0, 300, 150, 150);
//   view.frame = CGRectMake(0, 338, view.image.size.width, view.image.size.height);
    [scrol addSubview:view];
    scrol.contentSize = view.image.size;
    
//    [self.view addSubview:scrol];
    
   


}
//
- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
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
    
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(void)tapImage:(UITapGestureRecognizer*)tap
{
    NSLog(@"%d",tap.view.tag);
    NSLog(@"%@",tap.view);
}
@end
