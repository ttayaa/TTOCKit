//
//  NSDate+MacFormatter.h
//  ttayaa

#import <Foundation/Foundation.h>

@interface NSDate (tt_Formatter)

+(NSDateFormatter *)tt_formatter;
+(NSDateFormatter *)tt_formatterWithoutTime;
+(NSDateFormatter *)tt_formatterWithoutDate;

-(NSString *)tt_formatWithUTCTimeZone;
-(NSString *)tt_formatWithLocalTimeZone;
-(NSString *)tt_formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)tt_formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)tt_formatWithUTCTimeZoneWithoutTime;
-(NSString *)tt_formatWithLocalTimeZoneWithoutTime;
-(NSString *)tt_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)tt_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)tt_formatWithUTCWithoutDate;
-(NSString *)tt_formatWithLocalTimeWithoutDate;
-(NSString *)tt_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)tt_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)tt_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)tt_dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)tt_dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)tt_dateWithFormat:(NSString *)format;
@end
