//
//  Header.h
//  HolaBuild
//
//  Created by  HomerLynn on 2018/11/1.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#ifndef Header_h
#define Header_h

typedef NS_ENUM(NSUInteger, HLBuildType) {
    HLBuildTypeDebug = 0,
    HLBuildTypeRelease
};

// 项目路径
#define HL_PROJECT_PATH @"~/Desktop/hola/zst-ios"
// ipa输出路径
#define HL_ARCHIVE_PATH @"~/Desktop/Project"
// 工作空间
#define HL_WORKSPACE_NAME @"JSM"
// 项目名称
#ifdef DEV
    #define HL_BUILD_TARGET_NAME @"Development"
#elif DIS
    #define HL_BUILD_TARGET_NAME @"Distribution"
#else
    #define HL_BUILD_TARGET_NAME @"DistributionHTTPS"
#endif

#endif /* Header_h */
