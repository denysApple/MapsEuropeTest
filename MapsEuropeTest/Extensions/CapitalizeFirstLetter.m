//
//  CapitalizeFirstLetter.m
//  MapsEuropeTest
//
//  Created by Denys on 28.06.2023.
//

#import <Foundation/Foundation.h>

@implementation NSString (CapitalizeFirstLetter)

- (NSString *)stringByCapitalizingFirstLetter {
    if ([self length] == 0) {
        return self;
    }
    
    NSString *firstLetter = [[self substringToIndex:1] capitalizedString];
    NSString *remainingString = [self substringFromIndex:1];
    
    return [firstLetter stringByAppendingString:remainingString];
}

@end
