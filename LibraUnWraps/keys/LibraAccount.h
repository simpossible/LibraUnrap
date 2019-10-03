//
//  LibraAccounts.h
//  LibraUnWraps
//
//  Created by simp on 2019/10/3.
//  Copyright © 2019年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibKey.h"



NS_ASSUME_NONNULL_BEGIN

@interface LibraAccount : NSObject

@property (nonatomic, strong, readonly) LibKey * pubKey;

@property (nonatomic, strong, readonly) LibKey * accountKey;

+ (instancetype)accountFromMaterData:(NSData *)materData andIndex:(int64_t)index;


- (void)gen;
@end

NS_ASSUME_NONNULL_END
