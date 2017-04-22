//
//  MF_Base64Additions.h
//  Base64 -- RFC 4648 compatible implementation
//  see http://www.ietf.org/rfc/rfc4648.txt for more details
//
//  Designed to be compiled with Automatic Reference Counting
//
//  Created by Dave Poirier on 2012-06-14.
//  Public Domain
//  Hosted at https://github.com/ekscrypto/Base64
//

#import <Foundation/Foundation.h>

@interface NSString (tt_Base64Addition)
+(NSString *)tt_stringFromBase64String:(NSString *)base64String;
+(NSString *)tt_stringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
-(NSString *)tt_base64String;
-(NSString *)tt_base64UrlEncodedString;
@end

@interface NSData (tt_Base64Addition)
+(NSData *)tt_dataWithBase64String:(NSString *)base64String;
+(NSData *)tt_dataWithBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
-(NSString *)tt_base64String;
-(NSString *)tt_base64UrlEncodedString;
@end

@interface TTBase64Codec : NSObject
+(NSData *)tt_dataFromBase64String:(NSString *)base64String;
+(NSString *)tt_base64StringFromData:(NSData *)data;
+(NSString *)tt_base64UrlEncodedStringFromBase64String:(NSString *)base64String;
+(NSString *)tt_base64StringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
@end
