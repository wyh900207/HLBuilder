//
//  HLPathUtil.m
//  HolaBuild
//
//  Created by  HomerLynn on 2018/11/1.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#import "HLPathUtil.h"

@implementation HLPathUtil

- (NSString *)archivePathWith:(NSString *)buildType {
    
    NSString *resultPath = @"";
    
    NSArray *folders = [self xcodeBuildResultSRC];
    // Build configuration
    
    for (NSString *path in folders) {
        if ([path hasPrefix:HL_WORKSPACE_NAME]) {
            resultPath = [[self xcodeBuildPath] stringByAppendingString:[NSString stringWithFormat:@"/%@/Build/Products/%@-iphoneos/%@.app -o %@/%@.ipa", path, buildType, HL_BUILD_TARGET_NAME, HL_ARCHIVE_PATH, HL_BUILD_TARGET_NAME]];
            return resultPath;
        }
    }
    return resultPath;
}

- (void)deleteXcodeBuildFolders {
    // XCdoe build 目录
    NSArray *xcodeBuildFiles = [self xcodeBuildResultSRC];
    
    for (NSString *path in xcodeBuildFiles) {
        if ([path hasPrefix:HL_WORKSPACE_NAME]) {
            NSString *resultPath = [[self xcodeBuildPath] stringByAppendingString:path];
            NSString *shell = [NSString stringWithFormat:@"rm -rf %@", resultPath];
            system([shell cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
}

// Xcode build 路径
- (NSString *)xcodeBuildPath {
    NSString *resultPath = @"";
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSArray *array = [bundlePath componentsSeparatedByString:@"DerivedData"];
    if (array.count != 0) {
        resultPath = [[array firstObject] stringByAppendingString:@"DerivedData"];
        [self cersPathWith:resultPath];
    }
    return resultPath;
}

// Xcode build 生成的所有文件
- (NSArray *)xcodeBuildResultSRC {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager contentsOfDirectoryAtPath:[self xcodeBuildPath] error:nil];
}

// 证书
- (void)cersPathWith:(NSString *)projectPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSAssert([fileManager fileExistsAtPath:projectPath], @"地址错误");
}

@end
