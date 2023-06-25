//
//  MapsManager.m
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import "MapsManager.h"

@implementation MapsManager {
    NSXMLParser *parser;
    NSMutableDictionary *region;
    NSMutableString *currentValue;
}

- (void)fetchMaps {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"regions" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.maps = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:@"region"]) {
        region = [[NSMutableDictionary alloc] initWithDictionary:attributeDict];
        currentValue = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"parsing %@", region);
    if ([elementName isEqualToString:@"region"] && region != NULL) {
        [self.maps addObject:region];
    }
    region = nil;
    currentValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"Totally maps %lu", (unsigned long)self.maps.count);
}

@end
