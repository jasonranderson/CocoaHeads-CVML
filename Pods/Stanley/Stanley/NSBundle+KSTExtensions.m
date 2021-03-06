//
//  NSBundle+KSTExtensions.m
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

#import "NSBundle+KSTExtensions.h"

#import <dlfcn.h>

static NSString *const kKSTBundleIdentifierKey = @"CFBundleIdentifier";
static NSString *const kKSTBundleDisplayNameKey = @"CFBundleDisplayName";
static NSString *const kKSTBundleExecutableKey = @"CFBundleExecutable";
static NSString *const kKSTBundleShortVersionStringKey = @"CFBundleShortVersionString";
static NSString *const kKSTBundleVersionKey = @"CFBundleVersion";

@implementation NSBundle (KSTExtensions)

// implementation translated from Swift from https://bou.io/NSBundle.current.html
+ (NSBundle *)KST_currentBundle {
    static NSCache *kCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kCache = [[NSCache alloc] init];
        
        kCache.name = @"com.kosoku.stanley.current-bundle.cache";
    });
    
    NSNumber *caller = NSThread.callStackReturnAddresses[1];
    NSBundle *retval = [kCache objectForKey:caller];
    
    if (retval == nil) {
        Dl_info info = {
            .dli_fname = "",
            .dli_fbase = NULL,
            .dli_sname = "",
            .dli_saddr = NULL
        };
        
        if (dladdr(caller.pointerValue, &info) == 0) {
            return nil;
        }
        
        NSString *bundlePath = [NSString stringWithCString:info.dli_fname encoding:NSUTF8StringEncoding];
        
        if (bundlePath == nil) {
            return nil;
        }
        
        for (NSBundle *bundle in [NSBundle.allBundles arrayByAddingObjectsFromArray:NSBundle.allFrameworks]) {
            NSString *path = bundle.executablePath.stringByResolvingSymlinksInPath;
            
            if ([path isEqualToString:bundlePath]) {
                retval = bundle;
                
                [kCache setObject:retval forKey:caller];
                
                break;
            }
        }
    }
    
    return retval;
}

- (NSString *)KST_bundleIdentifier; {
    return self.infoDictionary[kKSTBundleIdentifierKey];
}
- (NSString *)KST_bundleDisplayName; {
    return self.infoDictionary[kKSTBundleDisplayNameKey];
}
- (NSString *)KST_bundleExecutable; {
    return self.infoDictionary[kKSTBundleExecutableKey];
}
- (NSString *)KST_bundleShortVersionString; {
    return self.infoDictionary[kKSTBundleShortVersionStringKey];
}
- (NSString *)KST_bundleVersion; {
    return self.infoDictionary[kKSTBundleVersionKey];
}

@end
