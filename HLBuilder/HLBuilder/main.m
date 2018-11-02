//
//  main.m
//  HLBuilder
//
//  Created by  HomerLynn on 2018/11/2.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLBuildUtils.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
#ifdef DEBUG
        [HLBuildUtils archiveWith:HLBuildTypeDebug];
#else
        [HLBuildUtils archiveWith:HLBuildTypeRelease];
#endif
    }
    return 0;
}
