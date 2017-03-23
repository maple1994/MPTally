//
//  MPBillDetailView.m
//  MPTally
//
//  Created by Maple on 2017/3/23.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillDetailBodyView.h"

@interface MPBillDetailBodyView ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;

@end

@implementation MPBillDetailBodyView

- (void)setBill:(MPBillModel *)bill
{
  _bill = bill;
  _accountNameLabel.text = bill.account.accountName;
  _timeLabel.text = bill.dateStr;
  _bookNameLabel.text = bill.book.bookName;
}

@end
