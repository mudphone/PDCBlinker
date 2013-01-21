//
//  PDCCurves.m
//  designschoolcheats
//
//  Created by koba on 1/6/13.
//  Copyright (c) 2013 Pas de Chocolat, LLC. All rights reserved.
//
//  All credit goes to Jeff LaMarche, for providing these calculations via his blog post:
//  http://iphonedevelopment.blogspot.com/2010/12/more-animation-curves-than-you-can.html
//  http://iphonedevelopment.blogspot.com/search?q=curves
//
//  Example Usage: Growing a radius
//  Input: percentComplete - The percentage complete of curve (usually timing) from 0.0f to 1.0f.
//         minR - Minimum radius value (some float like 2.0f)
//         maxR - Maximum radius value (some float line 10.0f)
//  CGFloat radius = [PDCCurves sinusoidalEaseInOutAtPercentComplete:percentComplete start:minR end:maxR];
//
//    As t increases, calculate a new percentComplete value and pass it in.  minR and maxR will probably
//    remain constant.  The Curves function will return a radius value adjusted for the easing.
//

#import "PDCCurves.h"

@interface PDCCurves ()
+ (CGFloat)clamp:(CGFloat)t;
@end

@implementation PDCCurves

+ (CGFloat)clamp:(CGFloat)t
{
    t = MIN(1.0f, t);
    t = MAX(0.0f, t);
    return t;
}

+ (CGFloat)cubicEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end
{
    t = [self clamp:t];
    
    t *= 2.;
    if (t < 1.) return end/2 * t * t * t + start - 1.f;
    t -= 2;
    return end/2*(t * t * t + 2) + start - 1.f;
}

+ (CGFloat)quarticEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end
{
    t = [self clamp:t];
    
    t *= 2.f;
    if (t < 1.f)
        return end/2.f * t * t * t * t + start - 1.f;
    t -= 2.f;
    return -end/2.f * (t * t * t * t - 2.f) + start - 1.f;
}

+ (CGFloat)quadraticEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end
{
    t = [self clamp:t];
    
    t *= 2.f;
    if (t < 1.f) return end/2.f * t * t + start - 1.f;
    t--;
    return -end/2.f * (t*(t-2) - 1) + start - 1.f;
}

+ (CGFloat)sinusoidalEaseInOutAtPercentComplete:(CGFloat)t start:(CGFloat)start end:(CGFloat)end
{
    t = [self clamp:t];
    
    return -end/2.f * (cosf(M_PI*t) - 1.f) + start - 1.f;
}

//
// Reference!
//
//GLfloat LinearInterpolation(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return t * end + (1.f - t) * start;
//}
//#pragma mark -
//#pragma mark Quadratic
//GLfloat QuadraticEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return   -end * t * (t - 2.f) -1.f;
//}
//GLfloat QuadraticEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * t * t + start - 1.f;
//}
//GLfloat QuadraticEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t *= 2.f;
//    if (t < 1.f) return end/2.f * t * t + start - 1.f;
//    t--;
//    return -end/2.f * (t*(t-2) - 1) + start - 1.f;
//}
//#pragma mark -
//#pragma mark Cubic
//GLfloat CubicEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t--;
//    return end*(t * t * t + 1.f) + start - 1.f;
//}
//GLfloat CubicEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * t * t * t+ start - 1.f;
//}
//GLfloat CubicEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t *= 2.;
//    if (t < 1.) return end/2 * t * t * t + start - 1.f;
//    t -= 2;
//    return end/2*(t * t * t + 2) + start - 1.f;
//}
//#pragma mark -
//#pragma mark Quintic
//GLfloat QuarticEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t--;
//    return -end * (t * t * t * t - 1) + start - 1.f;
//}
//GLfloat QuarticEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * t * t * t * t + start;
//}
//GLfloat QuarticEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t *= 2.f;
//    if (t < 1.f)
//        return end/2.f * t * t * t * t + start - 1.f;
//    t -= 2.f;
//    return -end/2.f * (t * t * t * t - 2.f) + start - 1.f;
//}
//#pragma mark -
//#pragma mark Quintic
//GLfloat QuinticEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t--;
//    return end * (t * t * t * t * t + 1) + start - 1.f;
//}
//GLfloat QuinticEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * t * t * t * t * t + start - 1.f;
//}
//GLfloat QuinticEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t *= 2.f;
//    if (t < 1.f)
//        return end/2 * t * t * t * t * t + start - 1.f;
//    t -= 2;
//    return end/2 * ( t * t * t * t * t + 2) + start - 1.f;
//}
//#pragma mark -
//#pragma mark Sinusoidal
//GLfloat SinusoidalEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * sinf(t * (M_PI/2)) + start - 1.f;
//}
//GLfloat SinusoidalEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return -end * cosf(t * (M_PI/2)) + end + start - 1.f;
//}
//GLfloat SinusoidalEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return -end/2.f * (cosf(M_PI*t) - 1.f) + start - 1.f;
//}
//#pragma mark -
//#pragma mark Exponential
//GLfloat ExponentialEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * (-powf(2.f, -10.f * t) + 1.f ) + start - 1.f;
//}
//GLfloat ExponentialEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return end * powf(2.f, 10.f * (t - 1.f) ) + start - 1.f;
//}
//GLfloat ExponentialEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t *= 2.f;
//    if (t < 1.f)
//        return end/2.f * powf(2.f, 10.f * (t - 1.f) ) + start - 1.f;
//    t--;
//    return end/2.f * ( -powf(2.f, -10.f * t) + 2.f ) + start - 1.f;
//}
//#pragma mark -
//#pragma mark Circular
//GLfloat CircularEaseOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t--;
//    return end * sqrtf(1.f - t * t) + start - 1.f;
//}
//GLfloat CircularEaseIn(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    return -end * (sqrtf(1.f - t * t) - 1.f) + start - 1.f;
//}
//GLfloat CircularEaseInOut(GLclampf t, GLfloat start, GLfloat end)
//{
//    BoundsCheck(t, start, end);
//    t *= 2.f;
//    if (t < 1.f)
//        return -end/2.f * (sqrtf(1.f - t * t) - 1.f) + start - 1.f;
//    t -= 2.f;
//    return end/2.f * (sqrtf(1.f - t * t) + 1.f) + start - 1.f;
//}


@end
