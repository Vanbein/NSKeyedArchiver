//
//  CHStudent.h
//  NSKeyedArchiver_归档
//
//  Created by 王斌 on 15/9/17.
//  Copyright (c) 2015年 Changhong electric Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHStudent : NSObject<NSCoding, NSCopying>

@property(nonatomic, strong)NSString *name;

@property(nonatomic, assign)NSInteger age;

@property(nonatomic, assign)NSInteger score;


@end
