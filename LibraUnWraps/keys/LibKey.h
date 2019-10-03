//
//  LibKey.h
//  LibraUnWraps
//
//  Created by simp on 2019/10/2.
//  Copyright © 2019年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LibKey : NSObject

@property (nonatomic, assign) uint64 index;

@property (nonatomic, strong) NSData * keyData;

- (instancetype)initWithData:(NSData *)keyData index:(uint64)index;

- (NSData *)getPub;

@end

NS_ASSUME_NONNULL_END
