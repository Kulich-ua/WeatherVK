//
//  WTHMacroDefinitions.h
//  WeatherVK
//
//  Created by Volodymyr Kolibaba on 11/8/14.
//  Copyright (c) 2014 Volodymyr Kolibaba. All rights reserved.
//

#ifndef WeatherVK_WTHMacroDefinitions_h
#define WeatherVK_WTHMacroDefinitions_h


#define TR(key) \
[[NSBundle mainBundle] localizedStringForKey : (key)value : (@"NO_TRANSLATION")table : nil]

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
+ (id)sharedInstance { \
static dispatch_once_t pred; \
static classname *sharedObject = nil; \
if (sharedObject) { return sharedObject; } \
dispatch_once(&pred, ^{ \
sharedObject = [classname alloc]; \
sharedObject = [sharedObject init]; \
}); \
return sharedObject; \
}


#endif
