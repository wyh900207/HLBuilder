//
//  HLBuildUtils.m
//  HolaBuild
//
//  Created by  HomerLynn on 2018/11/1.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#import "HLBuildUtils.h"
#import "Header.h"
#import "HLPathUtil.h"

@implementation HLBuildUtils

+ (void)archiveWith:(HLBuildType)buildType {
    HLPathUtil *pathUtils = [HLPathUtil new];

    // 删除项目之前build的文件夹
    [pathUtils deleteXcodeBuildFolders];
    //切到项目目录
    NSString *cd = [NSString stringWithFormat:@"cd %@", HL_PROJECT_PATH];
    // Build type
    NSString *type = buildType == HLBuildTypeDebug ? @"Debug" : @"Release";
    
    // 1.清理工程
    NSString *clean = [NSString stringWithFormat:@"/usr/bin/xcodebuild -workspace %@.xcworkspace -scheme %@  clean", HL_WORKSPACE_NAME, HL_BUILD_TARGET_NAME];
    // 2.编译项目
    NSString *build = [NSString stringWithFormat:@"/usr/bin/xcodebuild -workspace %@.xcworkspace -scheme %@ -sdk iphoneos -configuration %@ build", HL_WORKSPACE_NAME, HL_BUILD_TARGET_NAME, type];
    
    // 执行`build`脚本
    NSString *buildShell = [NSString stringWithFormat:@"%@\n %@\n %@\n", cd, clean, build];
    system([buildShell cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // 3.输出包
    NSString *run = [NSString stringWithFormat:@"/usr/bin/xcrun -sdk iphoneos PackageApplication -v %@", [pathUtils archivePathWith:type]];
    

    
    // 4.上传到蒲公英
//    NSString *upload = [NSString stringWithFormat:@"curl -F file=@%@ -F uKey=%@ -F _api_key=%@ https://qiniu-storage.pgyer.com/apiv1/app/upload",[NSString stringWithFormat:@"%@/%@.ipa",XB_IPAPath,XB_ProjectName],XB_PgyerUserKey,XB_PgyerAPIKey];
    
    // 执行`xrun`脚本
    NSString *shell = [NSString stringWithFormat:@"%@\n", run];
    system([shell cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
