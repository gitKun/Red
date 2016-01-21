//
//  SelectVoucherCell.m
//  红包使用的逻辑
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 CaiFu. All rights reserved.
//

#import "SelectVoucherCell.h"

@interface SelectVoucherCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *denominationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markSelectedImgView;
@property (weak, nonatomic) IBOutlet UILabel *voucherNumLabel;

@end

@implementation SelectVoucherCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)showDataFromModel:(Model *)model {
    self.denominationLabel.text = [NSString stringWithFormat:@"%d",model.denomination];
    self.markSelectedImgView.hidden = !model.isSelected;
    self.voucherNumLabel.text = model.num;
    self.limitAmountLabel.text = [NSString stringWithFormat:@"%.2f",model.limitAmount];
    self.limitDaysLabel.text = [NSString stringWithFormat:@"%d",model.limitDays];
    NSString *status = @"可以和其他代金卷同时使用";
    if (!model.exclusive) {
        status = @"不可和其他代金卷同时使用!";
    }
    self.statusLabel.text = status;
    NSString *imageName = @"voucher_enable_bg.png";
    if (!model.canSelected) {
        imageName = @"voucher_disable_bg.png";
    }
    self.bgImageView.image = [UIImage imageNamed:imageName];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
