//
//  Colors.m
//  MapsEuropeTest
//
//  Created by Denys on 24.06.2023.
//

#import <Foundation/Foundation.h>
#import "UIColors.h"

@implementation UIColors

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)mainColor {
    return [self colorWithHexString:@"FF8800"];
}

+ (UIColor *)backgroundColor {
    return [self colorWithHexString:@"CBC7D1"];
}

@end
