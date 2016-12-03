//
//  fourTableViewCell.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class fourModal;
@interface fourTableViewCell : UITableViewCell
@property(nonatomic, strong)UIImageView *iconImageView;
@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *commentLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UIButton *unfoldButton;
@property(nonatomic, strong)fourModal *modal;
@end
