//
//  CHStudent.m
//  NSKeyedArchiver_Demo
//
//  Created by 王斌 on 15/9/17.
//  Copyright (c) 2015年 Changhong electric Co., Ltd. All rights reserved.
//

#import "CHStudent.h"

@implementation CHStudent


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeInteger:self.score forKey:@"score"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    _name = [aDecoder decodeObjectForKey:@"name"];
    _age = [aDecoder decodeIntegerForKey:@"age"];
    _score = [aDecoder decodeIntegerForKey:@"score"];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    
    CHStudent *newStudent=[[self class] allocWithZone:zone];
    newStudent.name = _name;
    newStudent.age = _age;
    newStudent.score = _score;
    return  newStudent;
}

- (id)initWithName:(NSString *)name age:(NSInteger )age score:(NSInteger )score{
    
    if (self = [super init]) {
        self.name = name;
        self.age = age;
        self.score = score;
    }
    
    return self;
    
}



@end
