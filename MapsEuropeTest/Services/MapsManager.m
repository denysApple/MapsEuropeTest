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
    if ([elementName isEqualToString:@"region"]) {
        Region *new = [[Region alloc] initWithAttributes:attributeDict];
        [_lastRegion addSubregion:new];
        [new mergeWithParent:_lastRegion];
        new.parentRegion = _lastRegion;
        _lastRegion = new;
        if (new.parentRegion == NULL) {
            [self.regions addObject:new];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"region"]) {
        _lastRegion = _lastRegion.parentRegion;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"Finished parsing XML, found %lu regions.", (unsigned long)self.regions.count);
}

@end
