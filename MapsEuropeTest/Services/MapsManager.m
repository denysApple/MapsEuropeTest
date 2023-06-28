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
//    NSLog(@"Parsingwith: qName %@", qName);
    if ([elementName isEqualToString:@"region"]) {
        Region *region = [[Region alloc] initWithAttributes:attributeDict];
        if (self.currentRegion) {
            [self.currentRegion addSubregion:region];
        } else {
            if (![self.regions containsObject:region]) {
                [self.regions addObject:region];
            }
        }
        
        if (![attributeDict[@"type"] isEqualToString:@"continent"] || region.polyExtract.length == 0) {
//            NSLog(@"new_currentRegion %@", region.source);
            self.currentRegion = region;
        } else {
//            NSLog(@"not_currentRegion %@", region.source);
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (self.currentRegion == [self.regions lastObject]) {
        self.currentRegion = nil;
    } else {
        for (Region *region in self.regions) {
            if ([region.subregions containsObject:self.currentRegion]) {
                self.currentRegion = region;
                break;
            } else {
                for (Region *subregion in region.subregions) {
                    if ([subregion.subregions containsObject:self.currentRegion]) {
                        self.currentRegion = subregion;
                        break;
                    }
                }
            }
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"Finished parsing XML, found %lu regions.", (unsigned long)self.regions.count);
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Region *region, NSDictionary *bindings) {
        return region.subregions.count > 0;
    }];
    NSArray<Region *> *filteredArr = [self.regions filteredArrayUsingPredicate:predicate];
    self.filteredRegions = [filteredArr mutableCopy];
}

@end
