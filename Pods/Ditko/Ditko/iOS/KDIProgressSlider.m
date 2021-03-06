//
//  KDIProgressSlider.m
//  Ditko
//
//  Created by William Towe on 3/10/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KDIProgressSlider.h"

@interface KDIProgressSlider ()

- (void)_KDIProgressSliderInit;

+ (UIColor *)_defaultMaximumTrackFillColor;
+ (UIColor *)_defaultProgressFillColor;
@end

@implementation KDIProgressSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self _KDIProgressSliderInit];
    
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super initWithCoder:aDecoder]))
        return nil;
    
    [self _KDIProgressSliderInit];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.isTracking) {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    
    [self.maximumTrackFillColor setFill];
    UIRectFill(trackRect);
    
    if (self.progressRanges.count > 0) {
        CGRect trackRect = [self trackRectForBounds:self.bounds];
        CGFloat availableWidth = CGRectGetWidth(trackRect);
        
        [self.progressFillColor setFill];
        
        [self.progressRanges enumerateObjectsUsingBlock:^(NSArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat startX = CGRectGetMinX(trackRect) + floorf(availableWidth * obj.firstObject.floatValue);
            CGFloat width = startX + floorf(availableWidth * obj.lastObject.floatValue);
            
            UIRectFill(CGRectMake(startX, CGRectGetMinY(trackRect), width, CGRectGetHeight(trackRect)));
        }];
    }
    
    CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value];
    
    [self.minimumTrackFillColor setFill];
    UIRectFill(CGRectMake(CGRectGetMinX(trackRect), CGRectGetMinY(trackRect), CGRectGetMidX(thumbRect), CGRectGetHeight(trackRect)));
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL retval = [super continueTrackingWithTouch:touch withEvent:event];
    
    if (retval) {
        [self setNeedsDisplay];
    }
    
    return retval;
}

@dynamic progress;
- (float)progress {
    return self.progressRanges.lastObject.lastObject.floatValue;
}
- (void)setProgress:(float)progress {
    [self setProgressRanges:@[@[@0.0,@(progress)]]];
}

- (void)setProgressRanges:(NSArray<NSArray<NSNumber *> *> *)progressRanges {
    _progressRanges = [progressRanges copy];
    
    [self setNeedsDisplay];
}

@synthesize minimumTrackFillColor=_minimumTrackFillColor;
- (UIColor *)minimumTrackFillColor {
    return _minimumTrackFillColor ?: self.tintColor;
}
- (void)setMinimumTrackFillColor:(UIColor *)minimumTrackFillColor {
    _minimumTrackFillColor = minimumTrackFillColor;
    
    [self setNeedsDisplay];
}
- (void)setMaximumTrackFillColor:(UIColor *)maximumTrackFillColor {
    _maximumTrackFillColor = maximumTrackFillColor ?: [self.class _defaultMaximumTrackFillColor];
    
    [self setNeedsDisplay];
}
- (void)setProgressFillColor:(UIColor *)progressFillColor {
    _progressFillColor = progressFillColor ?: [self.class _defaultProgressFillColor];
    
    [self setNeedsDisplay];
}

- (void)_KDIProgressSliderInit; {
    _progressFillColor = [self.class _defaultProgressFillColor];
    _maximumTrackFillColor = [self.class _defaultMaximumTrackFillColor];
    
    [self setMinimumTrackTintColor:[UIColor clearColor]];
    [self setMaximumTrackTintColor:[UIColor clearColor]];
}

+ (UIColor *)_defaultMaximumTrackFillColor; {
    return [UIColor lightGrayColor];
}
+ (UIColor *)_defaultProgressFillColor; {
    return [UIColor darkGrayColor];
}

@end
