//
//  MapsManager.h
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import <Foundation/Foundation.h>
#import "Region.h"

@interface MapsManager : NSObject<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *maps;
//@property (nonatomic, strong) NSMutableArray<Region *> *regions;
- (void)fetchMaps;

@end
