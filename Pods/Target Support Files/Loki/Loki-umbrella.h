#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIImage+KLOExtensions.h"
#import "UIImage+KLOPDFExtensions.h"
#import "KLODefines.h"
#import "Loki.h"

FOUNDATION_EXPORT double LokiVersionNumber;
FOUNDATION_EXPORT const unsigned char LokiVersionString[];

