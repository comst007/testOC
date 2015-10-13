//
//  LZVedioParser.m
//  LZNetworkPro02-dataParser
//
//  Created by comst on 15/10/14.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZVedioParser.h"
#import "LZVedioItem.h"
@interface LZVedioParser ()
@property (nonatomic, copy) NSMutableArray *arrayOfVedio;
@property (nonatomic, strong) NSMutableString *currentValue;
@property (nonatomic, strong) LZVedioItem *currentItem;
@end

@implementation LZVedioParser

- (NSArray *)parserVedioXML:(NSData *)XMLData{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:XMLData];
    parser.delegate = self;
    if ([parser parse]) {
        return self.arrayOfVedio;
    }else{
        return nil;
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    if ([parser parserError] == nil) {
        self.currentValue = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    [_currentValue setString:@""];
    
    if ([elementName isEqualToString:@"video"]) {
        
        self.currentItem = [[LZVedioItem alloc] init];
        self.currentItem.vedioID = attributeDict[@"videoId"];
        [self.arrayOfVedio addObject:self.currentItem];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    [self.currentValue appendString:string];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"name"]) {
        self.currentItem.name = self.currentValue;
    }
    if ([elementName isEqualToString:@"length"]) {
        self.currentItem.length = @([self.currentValue intValue]);
    }
    if ([elementName isEqualToString:@"videoURL"]) {
        self.currentItem.vedioURL = self.currentValue;
    }
    if ([elementName isEqualToString:@"imageURL"]) {
        self.currentItem.imageURL = self.currentValue;
    }
    if ([elementName isEqualToString:@"desc"]) {
        self.currentItem.desc = self.currentValue;
    }
    if ([elementName isEqualToString:@"teacher"]) {
        self.currentItem.teacher = self.currentValue;
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}

- (NSMutableArray *)arrayOfVedio{
    if (!_arrayOfVedio) {
        _arrayOfVedio = [NSMutableArray array];
    }
    return _arrayOfVedio;
}
@end
