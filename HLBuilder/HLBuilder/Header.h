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

// ----------------- 打包相关配置 -----------------

// 项目路径
#define HL_PROJECT_PATH @"~/Desktop/jsm-ios"
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

// ----------------- fir.im 相关配置 -----------------


#ifdef DEV
    #define HL_API_TOKEN @"fabcc9f2ead3822c36b31c790e997b60"                    // fir.im api_token
#elif DIS
    #define HL_API_TOKEN @"d1489bd781405a3e4e36e42035b61fe5"                    // fir.im api_token
#else
    #define HL_API_TOKEN @"c8576dfb16b47dd9a1a26a9acf80e207"                    // fir.im api_token
#endif



#endif /* Header_h */
