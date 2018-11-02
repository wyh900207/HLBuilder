//
//  HLPathUtil.h
//  HolaBuild
//
//  Created by  HomerLynn on 2018/11/1.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

@interface HLPathUtil : NSObject

// 打包路径
- (NSString *)archivePathWith:(NSString *)buildType;
// 删除Xcode编译目录下的文件
- (void)deleteXcodeBuildFolders;

@end
