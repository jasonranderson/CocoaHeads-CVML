//
//  KSTGeometryFunctions.m
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright (c) 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSTGeometryFunctions.h"

CGSize KSTCGSizeIntegral(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

CGRect KSTCGRectCenterInRect(CGRect rect_to_center, CGRect in_rect) {
    return CGRectMake(floor(CGRectGetMinX(in_rect) + (CGRectGetWidth(in_rect) * 0.5) - (CGRectGetWidth(rect_to_center) * 0.5)),
                      floor(CGRectGetMinY(in_rect) + (CGRectGetHeight(in_rect) * 0.5) - (CGRectGetHeight(rect_to_center) * 0.5)),
                      CGRectGetWidth(rect_to_center),
                      CGRectGetHeight(rect_to_center));
}
CGRect KSTCGRectCenterInRectHorizontally(CGRect rect_to_center, CGRect in_rect) {
    CGRect new_rect = KSTCGRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.y = rect_to_center.origin.y;
    
    return new_rect;
}
CGRect KSTCGRectCenterInRectVertically(CGRect rect_to_center, CGRect in_rect) {
    CGRect new_rect = KSTCGRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.x = rect_to_center.origin.x;
    
    return new_rect;
}

#if (TARGET_OS_OSX)
NSSize KSTNSSizeIntegral(NSSize size) {
    return NSMakeSize(ceil(size.width), ceil(size.height));
}

NSRect KSTNSRectCenterInRect(NSRect rect_to_center, NSRect in_rect) {
    return NSMakeRect(floor(NSMinX(in_rect) + (NSWidth(in_rect) * 0.5) - (NSWidth(rect_to_center) * 0.5)),
                      floor(NSMinY(in_rect) + (NSHeight(in_rect) * 0.5) - (NSHeight(rect_to_center) * 0.5)),
                      NSWidth(rect_to_center),
                      NSHeight(rect_to_center));
}
NSRect KSTNSRectCenterInRectHorizontally(NSRect rect_to_center, NSRect in_rect) {
    NSRect new_rect = KSTNSRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.y = rect_to_center.origin.y;
    
    return new_rect;
}
NSRect KSTNSRectCenterInRectVertically(NSRect rect_to_center, NSRect in_rect) {
    NSRect new_rect = KSTNSRectCenterInRect(rect_to_center, in_rect);
    
    new_rect.origin.x = rect_to_center.origin.x;
    
    return new_rect;
}
#endif
