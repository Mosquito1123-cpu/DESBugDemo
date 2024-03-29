//
//  DES.m
//  DESBugDemo
//
//  Created by Mosquito1123 on 07/12/2019.
//  Copyright © 2019 GreenLand. All rights reserved.
//

#import "DES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation DES : NSObject

//加密
+(NSString *) encryptUseDES2:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    
    size_t bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    unsigned char* buffer = (unsigned char *)malloc(bufferPtrSize);;
    memset(buffer, 0, bufferPtrSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          NULL,
                                          textBytes, dataLength,
                                          buffer, bufferPtrSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[data base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return ciphertext;
}
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSData* cipherData = [[NSData alloc] initWithBase64EncodedString:cipherText options:0];
    
    NSUInteger dataLength = [cipherText length];
    size_t bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    unsigned char* buffer = (unsigned char *)malloc(bufferPtrSize);;
    memset(buffer, 0, bufferPtrSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          NULL,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          bufferPtrSize,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    free(buffer);
    return plainText;
    
}

@end
