//
//  KDIBadgeView.h
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

#import <TargetConditionals.h>
#if (TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>
#import "UIFont+KDIDynamicTypeExtensions.h"
#else
#import <AppKit/AppKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 KDIBadgeView is a UIView or NSView subclass that represents a badge value, like those seen in the Mail application.
 */
#if (TARGET_OS_IPHONE)
@interface KDIBadgeView : UIView <KDIDynamicTypeObject>
#else
@interface KDIBadgeView : NSView
#endif

/**
 Set and get the highlighted state of the view.
 
 If `highlighted` is NO, `badgeForegroundColor` and `badgeBackgroundColor` are used to display the `badge` value. Otherwise, if `highlighted` is YES, `badgeHighlightedForegroundColor` and `badgeHighlightedBackgroundColor` are used to display the `badge` value.
 
 @warning *NOTE:* This property will get set automatically if the receiver is used within a `UITableViewCell`
 */
@property (assign,nonatomic,getter=isHighlighted) BOOL highlighted;

/**
 Set and get the badge value of the receiver.
 
 This value is displayed using `badgeForegroundColor` or `badgeHighlightedForegroundColor`, depending on the value of `highlighted`.
 */
@property (copy,nonatomic,nullable) NSString *badge;

/**
 Set and get the text color used to display `badge` value when `highlighted` is NO.
 
 The default is `[UIColor whiteColor]` or `[NSColor whiteColor]`.
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIColor *badgeForegroundColor UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSColor *badgeForegroundColor;
#endif
/**
 Set and get the background color used to display `badge` value when `highlighted` is NO.
 
 The default is `[UIColor blackColor]` or `[NSColor blackColor]`.
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIColor *badgeBackgroundColor UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSColor *badgeBackgroundColor;
#endif

/**
 Set and get the text color used to display `badge` value when `highlighted` is YES.
 
 The default is `[UIColor lightGrayColor]` or `[NSColor lightGrayColor]`.
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIColor *badgeHighlightedForegroundColor UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSColor *badgeHighlightedForegroundColor;
#endif
/**
 Set and get the background color used to display `badge` value when `highlighted` is YES.
 
 The default is `[UIColor whiteColor]` or `[NSColor whiteColor]`.
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIColor *badgeHighlightedBackgroundColor UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSColor *badgeHighlightedBackgroundColor;
#endif

/**
 Set and get the font used to display `badge` value.
 
 The default is `[UIFont boldSystemFontOfSize:17.0]` or `[NSFont boldSystemFontOfSize:17.0]`.
 */
#if (TARGET_OS_IPHONE)
@property (strong,nonatomic,null_resettable) UIFont *badgeFont UI_APPEARANCE_SELECTOR;
#else
@property (strong,nonatomic,null_resettable) NSFont *badgeFont;
#endif
/**
 Set and get the badge corner radius used to draw the rounded corners of the receiver.
 
 The default is 8.0.
 */
#if (TARGET_OS_IPHONE)
@property (assign,nonatomic) CGFloat badgeCornerRadius UI_APPEARANCE_SELECTOR;
#else
@property (assign,nonatomic) CGFloat badgeCornerRadius;
#endif
/**
 Set and get the edge insets used to layout the `badge` value text.
 
 The default is `UIEdgeInsetsMake(4.0, 8.0, 4.0, 8.0)` or `NSEdgeInsetsMake(4.0, 8.0, 4.0, 8.0)`.
 */
#if (TARGET_OS_IPHONE)
@property (assign,nonatomic) UIEdgeInsets badgeEdgeInsets UI_APPEARANCE_SELECTOR;
#else
@property (assign,nonatomic) NSEdgeInsets badgeEdgeInsets;
#endif

#if (!TARGET_OS_IPHONE)
/**
 Equivalent to `-[UIView sizeThatFits:]` for cross platform reasons.
 
 @param size The preferred size of the receiver
 @return A new size that fits the receiver's subviews
 */
- (NSSize)sizeThatFits:(NSSize)size;
#endif

@end

NS_ASSUME_NONNULL_END
