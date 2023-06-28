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
        Region *region = [[Region alloc] initWithAttributes:attributeDict];
        if (self.parentRegion) {
            int lengthSuff = (unsigned int)region.downloadSuffix.length;
            int lengthPre = (unsigned int)region.downloadPrefix.length;
            
            if (lengthPre == 0) {
                if (self.parentRegion.downloadPrefix.length > 0) {
                    region.downloadPrefix = self.parentRegion.downloadPrefix;
                } else if (self.parentRegion.innerDownloadPrefix.length > 0) {
                    region.downloadPrefix = self.parentRegion.innerDownloadPrefix;
                }
            }
            
            if (lengthSuff == 0) {
                if (self.parentRegion.downloadSuffix.length > 0) {
                    region.downloadSuffix = self.parentRegion.downloadSuffix;
                } else if (self.parentRegion.innerDownloadSuffix.length > 0) {
                    region.downloadSuffix = self.parentRegion.innerDownloadSuffix;
                }
            }
            
            [self.parentRegion addSubregion:region];
        } else {
            if (![self.regions containsObject:region]) {
                [self.regions addObject:region];
            }
        }
        
        if (![attributeDict[@"type"] isEqualToString:@"continent"] || region.polyExtract.length == 0) {
            self.parentRegion = region;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (self.parentRegion == [self.regions lastObject]) {
        self.parentRegion = nil;
    } else {
        for (Region *region in self.regions) {
            if ([region.subregions containsObject:self.parentRegion]) {
                self.parentRegion = region;
                break;
            } else {
                for (Region *subregion in region.subregions) {
                    if ([subregion.subregions containsObject:self.parentRegion]) {
                        self.parentRegion = subregion;
                        break;
                    }
                }
            }
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"Finished parsing XML, found %lu regions.", (unsigned long)self.regions.count);
}

@end
