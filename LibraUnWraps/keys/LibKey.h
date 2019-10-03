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

@property (nonatomic, strong) NSData * keyData;

- (instancetype)initWithData:(NSData *)keyData;

-(NSString *)HexString;

- (LibKey*)getPub;

@end

NS_ASSUME_NONNULL_END
