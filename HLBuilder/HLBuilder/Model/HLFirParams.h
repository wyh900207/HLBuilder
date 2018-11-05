//
//  HLFirParams.h
//  HLBuilder
//
//  Created by  HomerLynn on 2018/11/3.
//  Copyright © 2018  HomerLynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLFirCerParams, HLFirBinaryParams;

@interface HLFirParams : NSObject

//@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *app_user_id;
@property (nonatomic, copy) NSString *storage;
@property (nonatomic, copy) NSString *form_method;
@property (nonatomic, strong) HLFirCerParams *cert;

@end


@interface HLFirCerParams : NSObject

@property (nonatomic, strong) HLFirBinaryParams *icon;
@property (nonatomic, strong) HLFirBinaryParams *binary;

@end


@interface HLFirBinaryParams : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *upload_url;

@end
