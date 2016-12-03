//
//  fourTableViewCell.m
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import "fourTableViewCell.h"
#import "fourModal.h"
@implementation fourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.iconImageView = [[UIImageView alloc]init];
   // self.iconImageView.backgroundColor = [UIColor greenColor];
    self.userNameLabel = [[UILabel alloc]init];
  //  self.userNameLabel.backgroundColor = [UIColor yellowColor];
    self.commentLabel = [[UILabel alloc]init];
   // self.commentLabel.backgroundColor = [UIColor cyanColor];
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
   // self.timeLabel.backgroundColor = [UIColor magentaColor];
      [self.contentView sd_addSubviews:@[self.iconImageView,self.userNameLabel,self.commentLabel,self.timeLabel]];
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthRatioToView(self.contentView,0.1375)
    .heightEqualToWidth();
    self.iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.timeLabel.sd_layout
    .centerYEqualToView(self.iconImageView)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.userNameLabel,10)
    .heightIs(20);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];

    self.userNameLabel.sd_layout
    .leftSpaceToView(self.iconImageView,10)
    .centerYEqualToView(self.iconImageView)
    .rightSpaceToView(self.timeLabel,10)
    .heightIs(20);
    
    self.commentLabel.sd_layout
    .topSpaceToView(self.userNameLabel,20)
    .leftEqualToView(self.userNameLabel)
    .rightSpaceToView(self.contentView,20);
    
}

-(void)setModal:(fourModal *)modal
{
    _modal = modal;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:modal.icon]];
    self.userNameLabel.text = _modal.fromusernickname;
    self.commentLabel.text = _modal.commentcontent;
    self.timeLabel.text = _modal.creationdate;
    self.commentLabel.sd_layout
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.commentLabel bottomMargin:20];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
