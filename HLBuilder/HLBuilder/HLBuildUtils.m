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
#import "MJExtension.h"
#import "NSString+JSON.h"
#import "HLFirParams.h"

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
    
    // 4.上传 fir.im
    //     - 进入.ipa存放目录
    //     - 上传
    NSString *outputPath = [NSString stringWithFormat:@"%@/fir-params.json", HL_ARCHIVE_PATH];
    NSString *fetchUploadParams = [NSString stringWithFormat:@"curl -o %@ -X \"POST\" \"http://api.fir.im/apps\" -H \"Content-Type: application/json\" -d \"{\\\"type\\\":\\\"ios\\\", \\\"bundle_id\\\":\\\"com.ynh.zst.ios\\\", \\\"api_token\\\":\\\"%@\\\"}\"", outputPath, HL_API_TOKEN];
    NSString *fechParamsString = [NSString stringWithFormat:@"%@\n", fetchUploadParams];
    int fetchParamsResponseStatus = system([fechParamsString cStringUsingEncoding:NSUTF8StringEncoding]);
    
    if (fetchParamsResponseStatus == 0) {
        //system([echo cStringUsingEncoding:NSUTF8StringEncoding]);
        NSData *data = [NSData dataWithContentsOfFile: outputPath];
        NSLog(@"NSData类方法读取的内容是：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSString *desk = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [NSString stringWithFormat:@"%@/Project/fir-params.json", desk];
        NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        HLFirParams *params = [HLFirParams mj_objectWithKeyValues:[string JSON]];
        
        NSLog(@"createFilePath：%@", params);
        
        // 上传
        NSString *cdProjectPath = [NSString stringWithFormat:@"cd %@", HL_ARCHIVE_PATH];
        NSString *uplod = [NSString stringWithFormat:@"curl -F \"key=%@\"                    \
                           -F \"token=%@\"                   \
                           -F \"file=@%@.ipa\"               \
                           -F \"x:name=由你花\"               \
                           -F \"x:version=1.0.0\"            \
                           -F \"x:build=1\"                  \
                           -F \"x:release_type=3\"           \
                           -F \"x:changelog=null\"           \
                           https://upload.qbox.me", params.cert.binary.key, params.cert.binary.token, HL_BUILD_TARGET_NAME];
        NSString *removeJsonFile = @"rm fir-params.json";
        
        // 执行`xrun`脚本
        //NSString *shell = [NSString stringWithFormat:@"%@\n %@\n %@\n", run, cdProjectPath, uplod];
        NSString *shell = [NSString stringWithFormat:@"%@\n %@\n %@\n", removeJsonFile, cdProjectPath, uplod];
        system([shell cStringUsingEncoding:NSUTF8StringEncoding]);
    } else {
        system([run cStringUsingEncoding:NSUTF8StringEncoding]);
    }
}

@end
