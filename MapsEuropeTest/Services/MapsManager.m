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

// MARK: NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.regions = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    NSLog(@"Parsing: %@", attributeDict);
//    if ([elementName isEqualToString:@"region"] && ![attributeDict[@"type"] isEqualToString:@"continent"]) {
    if ([elementName isEqualToString:@"region"]) {
        Region *region = [[Region alloc] initWithAttributes:attributeDict];
        if (self.currentRegion) {
            [self.currentRegion addSubregion:region];
        } else {
            [self.regions addObject:region];
        }
        
        if (![attributeDict[@"type"] isEqualToString:@"continent"]) {
            self.currentRegion = region;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentValue appendString:string];
}

//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    if ([elementName isEqualToString:@"region"]) {
//        self.currentRegion = nil;  // Reset current region
//    }
//}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"Finished parsing XML, found %lu regions.", (unsigned long)self.regions.count);
}

@end
