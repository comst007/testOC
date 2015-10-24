//
//  LZStudent.m
//  LZStudentNote
//
//  Created by comst on 15/10/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZStudent.h"


@interface LZStudent ()

@end

@implementation LZStudent

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        NSArray *propertList = [self propertyList];
        for (NSString *name in propertList) {
            [self performSelector:NSSelectorFromString([self setterName:name]) withObject:[aDecoder decodeObjectForKey:name]];
        }
    }
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    NSArray *propertyList = [self propertyList];
    
    for (NSString *name in propertyList) {
        [aCoder encodeObject:[self performSelector:NSSelectorFromString(name)] forKey:name];
    }
}


- (NSArray *)propertyList{
    
        NSMutableArray *arrayM = [NSMutableArray array];
        
        
        unsigned int count = 0;
        objc_property_t *arr = class_copyPropertyList([self class], &count);
        for (NSInteger i = 0; i < count; i ++) {
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(arr[i])];//
            [arrayM addObject:propertyName];
        }
    return arrayM;
   
}

- (NSArray *)list{
    
    return [self propertyList];
}

- (NSString *)setterName:(NSString *)propertName{
    
    NSMutableString *fistalphaUpper = [NSMutableString stringWithString:[propertName substringToIndex:1].uppercaseString];
    
    
    
    return [NSString stringWithFormat:@"set%@%@:", fistalphaUpper, [propertName substringFromIndex:1]];
}


- (void)test{
    
    NSArray *list = [self propertyList];
    
    for (NSString *name in list) {
        NSLog(@"setterName: %@", [self setterName:name]);
    }
    
    
}

- (BOOL)isEqual:(LZStudent *)student{
    
    if ([self.name isEqual:student.name] && self.phone == student.phone) {
        
        return YES;
        
    }
    
    return NO;
}

@end
