//
//  NSString+JSON.m
//  HLBuilder
//
//  Created by  HomerLynn on 2018/11/3.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

- (NSDictionary *)JSON {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
