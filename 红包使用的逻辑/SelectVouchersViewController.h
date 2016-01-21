//
//  SelectVouchersViewController.h
//  红包使用的逻辑
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectVoucherCell.h"

@class SelectVouchersViewController;

@protocol SelectVouchersVCDelegata <NSObject>

- (void)selectVouchersVC:(SelectVouchersViewController *)svc clickAtRightBarButton:(UIButton *)button;

@end

@interface SelectVouchersViewController : UIViewController

@property (nonatomic, weak) id<SelectVouchersVCDelegata>mDelegate;

@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, assign) int orderDays;
@property (nonatomic, strong) NSArray *dataArr;

@end
