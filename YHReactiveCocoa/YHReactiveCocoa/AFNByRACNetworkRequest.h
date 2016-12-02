//
//  AFNByRACNetworkRequest.h
//  YHReactiveCocoa
//
//  Created by 我叫MT on 16/12/2.
//  Copyright © 2016年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ResultBlock) (NSString *str);
typedef NS_ENUM(NSInteger, HTTPMethod) {
    Get = 0,
    Post,
    Put,
    Delete
};
@interface AFNByRACNetworkRequest : NSObject
@property(nonatomic, copy)ResultBlock reqBlock;
+(RACSignal *)HTTPRequestWithHTTPMethod:(HTTPMethod)method URLByString:(NSString *)url Params:(NSDictionary *)params;
@end
