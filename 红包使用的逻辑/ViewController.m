//
//  ViewController.m
//  红包使用的逻辑
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "ViewController.h"
#import "SelectVouchersViewController.h"

@interface ViewController ()<SelectVouchersVCDelegata>

@property (weak, nonatomic) IBOutlet UILabel *voucherAmount;
@property (weak, nonatomic) IBOutlet UILabel *realPayAmount;
@property (nonatomic, strong) NSMutableArray *vouchersArr;
@property (nonatomic, assign) CGFloat buyAmount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vouchersArr = [NSMutableArray array];
    [self creatData];
}
/** @brief  读取数据 */
- (void)creatData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in dataArr) {
        Model *model = [[Model alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.vouchersArr addObject:model];
    }
}

- (IBAction)buyAmountChanged:(UITextField *)sender {
    CGFloat currentAmount = [sender.text floatValue];
    self.buyAmount = currentAmount;
    CGFloat voucherAmount = 0.0;
    for (Model *model in _vouchersArr) {
        model.isSelected = NO;
    }
    self.voucherAmount.text = [NSString stringWithFormat:@"%.2f",voucherAmount];
    self.realPayAmount.text = [NSString stringWithFormat:@"%.2f元",_buyAmount-voucherAmount];
}

- (IBAction)toSelectVoucher:(id)sender {
    [self hiddenKeyBoard];
    if (self.buyAmount>=1000.0) {
        [self performSegueWithIdentifier:@"toSelectVouchers" sender:self];
    }
    
}
#pragma SelectVouchersVCDelegate 
- (void)selectVouchersVC:(SelectVouchersViewController *)svc clickAtRightBarButton:(UIButton *)button {
    //这里变更 数据
    CGFloat voucherAmount = 0.0;
    for (Model *model in _vouchersArr) {
        if (model.isSelected) {
            voucherAmount += model.denomination;
            NSLog(@"%@",model.num);
        }
    }
    self.voucherAmount.text = [NSString stringWithFormat:@"%.2f",voucherAmount];
    self.realPayAmount.text = [NSString stringWithFormat:@"%.2f元",_buyAmount-voucherAmount];
}
#pragma mark === 帮助类的方法
- (void)hiddenKeyBoard {
    [[self findFirstResponderInView:self.view] resignFirstResponder];
}
- (UIView *)findFirstResponderInView:(UIView *)topView {
    if ([topView isFirstResponder]) {
        return topView;
    }
    for (UIView* subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        UIView *firstResponderCheck = [self findFirstResponderInView:subView];
        if (nil != firstResponderCheck) {
            return firstResponderCheck;
        }
    }
    return nil;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSelectVouchers"]) {
        SelectVouchersViewController *svc = [segue destinationViewController];
        svc.dataArr = _vouchersArr;
        svc.amount = self.buyAmount;
        svc.mDelegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
