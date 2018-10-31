//
//  Stanley.h
//  Stanley
//
//  Created by William Towe on 3/7/17.
//  Copyright © 2018 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Foundation/Foundation.h>

//! Project version number for Stanley.
FOUNDATION_EXPORT double StanleyVersionNumber;

//! Project version string for Stanley.
FOUNDATION_EXPORT const unsigned char StanleyVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Stanley/PublicHeader.h>

// defines
#import <Stanley/KSTDefines.h>

// macros
#import <Stanley/KSTScopeMacros.h>
#import <Stanley/KSTEnvironmentMacros.h>
#import <Stanley/KSTLoggingMacros.h>
#import <Stanley/KSTMacros.h>

// functions
#import <Stanley/KSTFunctions.h>
#import <Stanley/KSTGeometryFunctions.h>

// protocols
#import <Stanley/KSTDeepCopying.h>
#import <Stanley/KSTDeepMutableCopying.h>

// categories
#import <Stanley/NSBundle+KSTExtensions.h>
#import <Stanley/NSFileManager+KSTExtensions.h>
#import <Stanley/NSData+KSTExtensions.h>
#import <Stanley/NSString+KSTExtensions.h>
#import <Stanley/NSHTTPURLResponse+KSTExtensions.h>
#import <Stanley/NSURLRequest+KSTExtensions.h>
#import <Stanley/NSArray+KSTExtensions.h>
#import <Stanley/NSMutableArray+KSTExtensions.h>
#import <Stanley/NSObject+KSTExtensions.h>
#import <Stanley/NSError+KSTExtensions.h>
#import <Stanley/NSURL+KSTExtensions.h>
#import <Stanley/NSDate+KSTExtensions.h>
#import <Stanley/NSCharacterSet+KSTExtensions.h>
#import <Stanley/NSDictionary+KSTExtensions.h>

// classes
#import <Stanley/KSTSnakeCaseToLlamaCaseValueTransformer.h>
#import <Stanley/KSTFileWatcher.h>
#import <Stanley/KSTPhoneNumberFormatter.h>
#import <Stanley/KSTTimer.h>
#if (TARGET_OS_OSX || TARGET_OS_IOS || TARGET_OS_TV)
#import <Stanley/KSTReachabilityManager.h>
#endif
#if (TARGET_OS_OSX)
#import <Stanley/KSTDirectoryWatcher.h>
#endif