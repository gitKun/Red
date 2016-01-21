//
//  SelectVouchersViewController.m
//  红包使用的逻辑
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "SelectVouchersViewController.h"


@interface SelectVouchersViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _currentSelectedAmount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectVouchersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self resetRightBarButton];
    _orderDays = 100;
    [self calculateSelectAmount];
}
- (void)calculateSelectAmount {
    _currentSelectedAmount = 0;
    for (Model *model in _dataArr) {
        if (model.isSelected) {
            _currentSelectedAmount += model.limitAmount;
        }
    }
    [self resetDataSouceStatus];
}
- (void)resetDataSouceStatus {
    Model *selectedModel = nil;
    for (Model *modle in _dataArr) {
        if (modle.isSelected) {
            selectedModel = modle;
        }
    }
    if (selectedModel && selectedModel.exclusive == NO) {
        for (Model *model in _dataArr) {
            if (model == selectedModel) {
                model.canSelected = YES;
            }else {
                model.canSelected = NO;
            }
        }
        return;
    }
    for (Model *model in _dataArr) {
        if (_amount-_currentSelectedAmount>=model.limitAmount && _orderDays>=model.limitDays) {
            if (selectedModel && model.exclusive != YES) {
                model.canSelected = NO;
            }else {
                model.canSelected = YES;
            }
        }else {
            if (model.isSelected) {
                model.canSelected = YES;
            }else {
                model.canSelected = NO;
            }
        }
    }
}

- (void)resetRightBarButton {
    self.title = @"选择红包";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 55, 40);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:214/255.0 green:10/255.0 blue:56/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[item];
}
- (void)rightBarButtonClick:(UIButton *)button {
    if (self.mDelegate) {
        [self.mDelegate selectVouchersVC:self clickAtRightBarButton:button];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



#pragma mark ==== 代理协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectVoucherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectVoucherCellID"];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectVoucherCell *selectCell = (SelectVoucherCell *)cell;
    //遵循 优化 tableView 的滑动和性能等原则 在此方法中进行数据的填充 (个人愚见)
    [selectCell showDataFromModel:_dataArr[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Model *model = _dataArr[indexPath.row];
    if (!model.canSelected && !model.isSelected) {
        return;
    }
    [self clickCellAtIndexPath:indexPath];
}
- (void)clickCellAtIndexPath:(NSIndexPath *)indexPath {
    Model *model = _dataArr[indexPath.row];
    model.isSelected = !model.isSelected;
    [self calculateSelectAmount];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
