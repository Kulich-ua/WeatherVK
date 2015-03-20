//
//  WTHLocation.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#import <Foundation/Foundation.h>


extern const struct WTHLocationAttributes {
    __unsafe_unretained NSString *locationId;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *isSeleceted;
} WTHLocationAttributes;


@interface WTHLocation : NSObject

@property (strong, nonatomic) NSString *locationId;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL isSeleceted;


+ (instancetype)locationWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionary;

@end
