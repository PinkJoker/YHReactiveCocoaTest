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
    self.iconImageView.backgroundColor = [UIColor greenColor];
    self.userNameLabel = [[UILabel alloc]init];
    self.userNameLabel.backgroundColor = [UIColor yellowColor];
    self.commentLabel = [[UILabel alloc]init];
    self.commentLabel.backgroundColor = [UIColor cyanColor];
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.backgroundColor = [UIColor magentaColor];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthRatioToView(self.contentView,0.1375)
    .heightEqualToWidth();
    self.iconImageView.sd_cornerRadiusFromWidthRatio = @0.5;

    self.userNameLabel.sd_layout
    .leftSpaceToView(self.iconImageView,10)
    .centerYEqualToView(self.iconImageView)
    .heightIs(20);
    [self.userNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.commentLabel.sd_layout
    .topSpaceToView(self.userNameLabel,20)
    .leftEqualToView(self.userNameLabel)
    .rightSpaceToView(self.contentView,20)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .centerYEqualToView(self.userNameLabel)
    .rightSpaceToView(self.contentView,10)
    .leftSpaceToView(self.userNameLabel,10)
    .heightIs(20);
    
    [self sd_addSubviews:@[self.iconImageView,self.userNameLabel,self.commentLabel,self.timeLabel]];
    
    
}

-(void)setModal:(fourModal *)modal
{
    _modal = modal;
    NSLog(@"%@",modal);
//    [self.iconImageView.image ]
    self.userNameLabel.text = _modal.fromusernickname;
    self.commentLabel.text = _modal.commentcontent;
    self.timeLabel.text = _modal.creationdate;
    NSLog(@"%@",self.userNameLabel.text);
    NSLog(@"%@",self.timeLabel.text );
    NSLog(@"%@",self.commentLabel.text);
    
    [self setupAutoHeightWithBottomView:self.commentLabel bottomMargin:20];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
