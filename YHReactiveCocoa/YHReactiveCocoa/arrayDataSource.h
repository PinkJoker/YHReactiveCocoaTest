//
//  arrayDataSource.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^configureCellBlock)(id item,id array);

@interface arrayDataSource : NSObject<UITableViewDataSource>

- (id)initWithCellBlock:(configureCellBlock )block withArray:(NSArray *)items withCellIdentifier:(NSString *)cellIdenfier;

- (id)numberOfItemswithIndex:(NSIndexPath *)indexPath;

@end
