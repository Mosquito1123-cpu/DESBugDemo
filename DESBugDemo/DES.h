//
//  DES.h
//  DESBugDemo
//
//  Created by Mosquito1123 on 07/12/2019.
//  Copyright © 2019 GreenLand. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DES : NSObject

+(NSString *)encryptUseDES2:(NSString *)plainText key:(NSString *)key;
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
