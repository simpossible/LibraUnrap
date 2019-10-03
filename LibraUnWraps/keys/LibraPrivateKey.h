//
//  LibraPrivateKey.h
//  LibraUnWraps
//
//  Created by simp on 2019/10/3.
//  Copyright © 2019年 simp. All rights reserved.
//

#import "LibKey.h"

NS_ASSUME_NONNULL_BEGIN

@interface LibraPrivateKey : LibKey

/**获取公钥*/
- (LibKey*)getPub;

@end

NS_ASSUME_NONNULL_END
