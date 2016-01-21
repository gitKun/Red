//
//  Model.h
//  红包使用的逻辑
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

/** 代金卷的编号 */
@property (nonatomic, copy) NSString *num;
/** 代金卷金额 */
@property (nonatomic, assign) int denomination;
/** 最小使用限额 */
@property (nonatomic, assign) float limitAmount;
/** 最小使用天数 */
@property (nonatomic, assign) int limitDays;
/** 是否可以和其他代金卷同时使用 */
@property (nonatomic, assign) BOOL exclusive;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL canSelected;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
