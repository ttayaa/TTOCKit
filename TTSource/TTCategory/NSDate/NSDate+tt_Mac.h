//
//  NSDate+Mac.h
//

#import <Foundation/Foundation.h>

@interface NSDate (tt_Mac)


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)tt_day;
- (NSUInteger)tt_month;
- (NSUInteger)tt_year;
- (NSUInteger)tt_hour;
- (NSUInteger)tt_minute;
- (NSUInteger)tt_second;
+ (NSUInteger)tt_day:(NSDate *)date;
+ (NSUInteger)tt_month:(NSDate *)date;
+ (NSUInteger)tt_year:(NSDate *)date;
+ (NSUInteger)tt_hour:(NSDate *)date;
+ (NSUInteger)tt_minute:(NSDate *)date;
+ (NSUInteger)tt_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)tt_daysInYear;
+ (NSUInteger)tt_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)tt_isLeapYear;
+ (BOOL)tt_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)tt_weekOfYear;
+ (NSUInteger)tt_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)tt_formatYMD;
+ (NSString *)tt_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)tt_weeksOfMonth;
+ (NSUInteger)tt_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)tt_begindayOfMonth;
+ (NSDate *)tt_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)tt_lastdayOfMonth;
+ (NSDate *)tt_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)tt_dateAfterDay:(NSUInteger)day;
+ (NSDate *)tt_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)tt_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)tt_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)tt_offsetYears:(int)numYears;
+ (NSDate *)tt_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)tt_offsetMonths:(int)numMonths;
+ (NSDate *)tt_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)tt_offsetDays:(int)numDays;
+ (NSDate *)tt_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)tt_offsetHours:(int)hours;
+ (NSDate *)tt_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)tt_daysAgo;
+ (NSUInteger)tt_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)tt_weekday;
+ (NSInteger)tt_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)tt_dayFromWeekday;
+ (NSString *)tt_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)tt_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)tt_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)tt_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)tt_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串 format源字符串格式
 */
+ (NSString *)tt_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)tt_stringWithFormat:(NSString *)format;
+ (NSDate *)tt_dateWithString:(NSString *)string format:(NSString *)format;
/**
 *  本地英文的格式
 *
 *  @param string
 *  @param format  eg @"MM/d/yyyy h:mm:ss aa"
 *
 *  @return NSDate
 */
+ (NSDate *)tt_dateWithLocaleEN_USString:(NSString *)string format:(NSString *)format;
/**
 *  Use DateFormatter to transform dateString to specified date string.
 *
 *  @param dateString                Date string. (eg. 2015-06-26 08:08:08)
 *  @param inputDateStringFormatter  Input date string formatter. (eg. yyyy-MM-dd HH:mm:ss)
 *  @param outputDateStringFormatter Output date string formatter. (eg. yy/MM/dd)
 *
 *  @return Specified date string.
 */
+ (NSString *)tt_dateFormatterWithInputDateString:(NSString *)dateString
                      inputDateStringFormatter:(NSString *)inputDateStringFormatter
                     outputDateStringFormatter:(NSString *)outputDateStringFormatter;



/**
 * 获取指定月份的天数
 */
- (NSUInteger)tt_daysInMonth:(NSUInteger)month;
+ (NSUInteger)tt_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)tt_daysInMonth;
+ (NSUInteger)tt_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)tt_timeInfo;
+ (NSString *)tt_timeInfoWithDate:(NSDate *)date;
+ (NSString *)tt_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)tt_ymdFormat;
- (NSString *)tt_hmsFormat;
- (NSString *)tt_ymdHmsFormat;
+ (NSString *)tt_ymdFormat;
+ (NSString *)tt_hmsFormat;
+ (NSString *)tt_ymdHmsFormat;

/**
 *  返回时间戳
 *
 *  @return
 */
+(NSString *)tt_timeToTimeStamps;

/**
 *  获取系统当前时间返回指定格式
 *
 *  @param format 时间格式
 *
 *  @return 时间格式字符串
 */
+(NSString *)tt_getNewTimeFormat:(NSString *)format;

/**
 * 判断时间早晚
 */
+(int)tt_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
@end
