//
//  MDRadialProgressView.m
//  MDRadialProgress
//
//  Created by Marco Dinacci on 25/03/2013.
//  Copyright (c) 2013 Marco Dinacci. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MDRadialProgressView.h"

#define ProgressFont 10.0
#define ProgressFontStyle @"Bodoni 72 Oldstyle"

@implementation MDRadialProgressView

+ (instancetype)mdRadialProgressViewCreate{
    MDRadialProgressView *mdRadiaProView = [[MDRadialProgressView alloc] init];
    
    //设置默认模式
    mdRadiaProView.progressTotal = 10;
    //mdRadiaProView.progressCurrent = 3; //显示加载进度
    mdRadiaProView.completedColor = [UIColor greenColor];
    mdRadiaProView.thickness = 70;
    mdRadiaProView.sliceDividerHidden = NO;
    mdRadiaProView.sliceDividerColor = [UIColor blackColor];
    mdRadiaProView.sliceDividerThickness = 8;
    //mdRadiaProView.progressValue = 0.39; //百分比进度
    mdRadiaProView.progressValueColor = [UIColor redColor];
    mdRadiaProView.backgroundColor = [UIColor whiteColor];
    
    return mdRadiaProView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [self internalInit];
}

- (void)internalInit
{
    // Default values
    self.backgroundColor = [UIColor whiteColor];
    self.completedColor = [UIColor greenColor];
    self.incompletedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    self.sliceDividerColor = [UIColor whiteColor];
    self.progressValueColor = [UIColor blueColor];
    self.thickness = 10;
    self.sliceDividerHidden = NO;//默认模块化开启,不开启时百分比不对
    self.progressTotal = 100;//默认100份 无间隙,
    self.sliceDividerThickness = 0;
    
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
}

- (void)drawSlices:(NSUInteger)slicesCount
         completed:(NSUInteger)slicesCompleted
            radius:(CGFloat)circleRadius
            center:(CGPoint)center
         inContext:(CGContextRef)context
{
	if (!self.sliceDividerHidden) {
		
		// Draw one arc at a time.
		
		float sliceValue = 1.0f/slicesCount;
		for (int i = 0; i < slicesCount; i++) {
			CGFloat startValue = sliceValue * i;
			CGFloat startAngle = startValue * 2 * M_PI - M_PI_2;
			CGFloat endValue = sliceValue * (i + 1);
			CGFloat endAngle = endValue * 2 * M_PI - M_PI_2;
			
			CGContextBeginPath(context);
			CGContextMoveToPoint(context, center.x, center.y);
			CGContextAddArc(context, center.x, center.y, circleRadius, startAngle, endAngle, 0);

			CGColorRef color = self.incompletedColor.CGColor;
			if (slicesCompleted - 1 >= i) {
#warning 写个判断,如果progressCurrent为0时,加载的为未完成的颜色
                if (self.progressCurrent == 0) {
                    color = self.incompletedColor.CGColor;
                }else if (self.progressCurrent > 0){
                    color = self.completedColor.CGColor;
                }
				//color = self.completedColor.CGColor;//原来写法
			}
			CGContextSetFillColorWithColor(context, color);
			CGContextFillPath(context);
		}
	} else {
		
		// Draw the arcs grouped instead of individually to avoid
		// artifacts between one slice and another.
		
		// Completed slices
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, center.x, center.y);
		CGFloat startAngle = - M_PI_2;
		CGFloat sliceAngle = (2 * M_PI) / self.progressTotal;
		CGFloat endAngle = sliceAngle * (self.progressCurrent -1);
		CGContextAddArc(context, center.x, center.y, circleRadius, startAngle, endAngle, 0);
		CGColorRef color = self.completedColor.CGColor;
		CGContextSetFillColorWithColor(context, color);
		CGContextFillPath(context);
		
		// Incompleted slices
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, center.x, center.y);
		startAngle = endAngle;
		endAngle = - M_PI_2;
		CGContextAddArc(context, center.x, center.y, circleRadius, startAngle, endAngle, 0);
		color = self.incompletedColor.CGColor;
		CGContextSetFillColorWithColor(context, color);
		CGContextFillPath(context);
	}
}

- (void)drawRect:(CGRect)rect
{
    if (self.progressTotal <= 0) {
        return;
    }
    
    // Draw the slices.
    
	CGSize viewSize = self.bounds.size;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2;
    [self drawSlices:self.progressTotal
		   completed:self.progressCurrent
			  radius:radius
			  center:center
		   inContext:contextRef];
    
	// Draw the slice separators.
	
    int outerDiameter = viewSize.width;
    float outerRadius = outerDiameter / 2;
    int innerDiameter = outerDiameter - self.thickness;
    float innerRadius = innerDiameter / 2;
    
    if (! self.sliceDividerHidden) {
        int sliceCount = (int)self.progressTotal;
        float sliceAngle = (2 * M_PI) / sliceCount;
        CGContextSetLineWidth(contextRef, self.sliceDividerThickness);
        CGContextSetStrokeColorWithColor(contextRef, self.sliceDividerColor.CGColor);
        for (int i = 0; i < sliceCount; i++) {
            double startAngle = sliceAngle * i - M_PI_2;
			double endAngle = sliceAngle * (i + 1) - M_PI_2;

			CGContextBeginPath(contextRef);
			CGContextMoveToPoint(contextRef, center.x, center.y);
			
			// Draw the outer arc
			CGContextAddArc(contextRef, center.x, center.y, outerRadius, startAngle, endAngle, 0);
			// Draw the inner arc. The separator line is drawn automatically when moving from
			// the point where the outer arc ended to the point where the inner arc starts.
			CGContextAddArc(contextRef, center.x, center.y, innerRadius, endAngle, startAngle, 1);
			
			CGContextSetStrokeColorWithColor(contextRef, self.sliceDividerColor.CGColor);
			CGContextStrokePath(contextRef);
        }
    }
    
    // Draw the inner circle to fake a hole in the middle.
    
    CGContextSetLineWidth(contextRef, self.thickness);

    CGContextSetFillColorWithColor(contextRef, self.backgroundColor.CGColor);
    CGRect circlePoint = CGRectMake(center.x - innerRadius, center.y - innerRadius,
                                    innerDiameter, innerDiameter);
    CGContextFillEllipseInRect(contextRef, circlePoint);
    
    //绘制百分比进度
    
    NSString *proStr = [NSString stringWithFormat:@"%.02f%%",self.progressValue];
    //当不为0的时候绘制
    if (self.progressValue != 0 ) {
        //绘制
        [proStr drawInRect:CGRectMake(rect.size.width/2 -10, rect.size.height/2-5, ProgressFont*3, ProgressFont*2) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:ProgressFontStyle size:ProgressFont],NSForegroundColorAttributeName:self.progressValueColor}];
        CGContextFillPath(contextRef);
    }
    
    
}


@end
