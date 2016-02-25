//
//  badgeView.m
//  webpractice
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "badgeView.h"
@interface badgeView()
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIView *smallBadgeView;//和self一样的图
@property (weak, nonatomic) UIView *attachView;

@end
@implementation badgeView
//初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
//        self.image = [UIImage imageNamed:@"yellow_bubble.png"];
        self.backgroundColor = [UIColor redColor];
//            NSLog(@"%@",[UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow_bubble.png"]]);
        UIImage * image = [UIImage imageNamed:@"yellow_bubble 2.png"];
//        self.layer.contents = (__bridge id _Nullable)(image.CGImage);
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow_bubble 2.png"]];
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.clipsToBounds = YES;
        [self setUp];
    }
    return self;
}
-(instancetype)init
{
    if(self = [super init]){
       
    }
    return self;
}
#pragma mark -
#pragma mark - UI
-(void)setUp
{
//    self.smallBadgeView.bounds = CGRectMake(0, 0, 30, 30);
//    self.smallBadgeView.center = self.center;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:panGes];

}
#pragma mark - 
#pragma mark - Layout
-(void)layoutSubviews
{
    [super layoutSubviews];
//    CGRect newFrame = self.frame;
    
}
- (UIView *)smallBadgeView{
    if (!_smallBadgeView) {
        _smallBadgeView = [[UIView alloc] initWithFrame:self.frame];
//        _smallBadgeView.layer.cornerRadius = 5;
//        _smallBadgeView.clipsToBounds = YES;
        [self.superview insertSubview:_smallBadgeView belowSubview:self];
    }
    return _smallBadgeView;
}
/**
 *  重置,将smallBadgeView,shapeLayer 从父view中移除,以免内存泄露
 */
- (void)reset{
    [self.smallBadgeView removeFromSuperview];
    self.smallBadgeView = nil;
    
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = nil;
}
/**
 *  计算两点之间距离
 *
 *  @param pointA A点
 *  @param pointB B点
 *
 *  @code
 *  CGFloat distance = [self pointToPoitnDistanceWithPoint:aPoint potintB:bPoint]
 *  @endcode
 *
 *  @return 两点之间距离
 */
- (CGFloat)pointToPoitnDistanceWithPoint:(CGPoint)pointA potintB:(CGPoint)pointB
{
    CGFloat offestX = pointA.x - pointB.x;
    CGFloat offestY = pointA.y - pointB.y;
    CGFloat dist = sqrtf(offestX * offestX + offestY * offestY);
    
    return dist;
}
/**
  *  绘制贝塞尔曲线路径
  *
  *  @param bigCirCleView   被拖动的View
  *  @param smallCirCleView 留在原地的view
  *
  *  @return UIBezierPath 的实例
  */
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleView:(UIView *)smallCirCleView
{
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.width / 2;
    
    CGPoint smallCenter = smallCirCleView.center;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleView.bounds.size.width / 2;
    
    // 获取圆心距离
    CGFloat d = [self pointToPoitnDistanceWithPoint:self.smallBadgeView.center potintB:self.center];
    CGFloat sinθ = 0.0f;
    CGFloat cosθ = 0.0f;
    if (d == 0) {
        sinθ = 0;
        cosθ = 1;
    }else{
        sinθ = (x2 - x1) / d;
        cosθ = (y2 - y1) / d;
    }
    
    // 坐标系基于父控件
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // A
    [path moveToPoint:pointA];
    // AB
    [path addLineToPoint:pointB];
    // 绘制BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    // CD
    [path addLineToPoint:pointD];
    // 绘制DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}
-(void)handleTap:(UITapGestureRecognizer*)tap
{
    [self reset];
//    [UIView animateWithDuration:.3 animations:^{
//        self.alpha = 0.0f;
//    }completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.alpha = 0.0f;
        CGPoint point = self.center;
        point.x += 10;
        self.center = point;
        self.center = self.smallBadgeView.center;

    } completion:^(BOOL finished) {
        self.alpha = 0.0;
        [self removeFromSuperview];

    }];
   
    if ([self.delegate respondsToSelector:@selector(removeBadgeView)]) {
        [self.delegate removeBadgeView];
    }

}
/**
 *  处理拖动手势
 *
 *  @param pan
 */
- (void)handlePan:(UIPanGestureRecognizer *)pan{
    CGPoint panPoint = [pan translationInView:self];
    
    CGPoint changeCenter = self.center;
    changeCenter.x += panPoint.x;
    changeCenter.y += panPoint.y;
    self.center = changeCenter;
    [pan setTranslation:CGPointZero inView:self];
    
    //俩个圆的中心点之间的距离
    CGFloat dist = [self pointToPoitnDistanceWithPoint:self.center potintB:self.smallBadgeView.center];
    
    if (dist < self.maxDistance) {
        
        CGFloat cornerRadius = self.layer.cornerRadius;
        CGFloat samllCrecleRadius = cornerRadius - dist / 20;
        self.smallBadgeView.bounds = CGRectMake(0, 0, samllCrecleRadius, samllCrecleRadius);
        self.smallBadgeView.layer.cornerRadius = self.smallBadgeView.bounds.size.width / 2;
        
        if (self.smallBadgeView.hidden == NO && dist > 0) {
            //画不规则矩形
            self.shapeLayer.path = [self pathWithBigCirCleView:self smallCirCleView:_smallBadgeView].CGPath;
        }
    } else {
        
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
        self.smallBadgeView.hidden = YES;
        
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (dist > self.maxDistance) {
            [self reset];
            [UIView animateWithDuration:.3 animations:^{
                self.alpha = 0.0f;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            
            if ([self.delegate respondsToSelector:@selector(removeBadgeView)]) {
                [self.delegate removeBadgeView];
            }
        } else {
            
            [self.shapeLayer removeFromSuperlayer];
            self.shapeLayer = nil;
            
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.center = self.smallBadgeView.center;
            } completion:^(BOOL finished) {
                self.smallBadgeView.hidden = NO;
            }];
        }
    }
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    const CGFloat marginToDrawInside = [self marginToDrawInside];
    const CGFloat marginToDrawInside = 10;
    const CGRect rectToDraw = CGRectInset(rect, marginToDrawInside, marginToDrawInside);
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(100, 100)];
//     绘制背景色,背景阴影 
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, borderPath.CGPath);
        
        CGContextSetFillColorWithColor(ctx,[UIColor redColor].CGColor);
        CGContextSetShadowWithColor(ctx, CGSizeZero, 10, [UIColor redColor].CGColor);
        
        CGContextDrawPath(ctx, kCGPathFill);
    }
    
    CGContextRestoreGState(ctx);
    /* 绘制边框 */
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, borderPath.CGPath);
        
        CGContextSetLineWidth(ctx, 20);
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
        
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    CGContextRestoreGState(ctx);

}
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:_shapeLayer below:self.layer];
    }
    return _shapeLayer;
}
@end
