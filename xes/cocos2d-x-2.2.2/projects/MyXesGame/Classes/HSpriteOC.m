//
//  HSpriteOC.c
//  OcGame
//
//  Created by 米宪成 on 14-3-3.
//
//

#include <stdio.h>
#import "HSpriteOC.h"

@implementation HSpriteOC

+(void) testLog{
    str = @"Himi->string is: ";
    NSLog(@"HSprite: testLog");
}
+(NSString*) outMes{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid = (NSString *)CFUUIDCreateString (kCFAllocatorDefault,uuidRef);
    NSLog(@"outMes%@",uuid);
    return uuid;
}
+(void) testLogWithStr:(NSString*)_str{
    str = [NSString stringWithFormat:@"%@%@",str,_str];
    NSLog(@"%@",str);
}
+(void) hMessageBox:(NSString*)pszMsg title:(NSString*)pszTitle{
    
    UIAlertView * messageBox = [[UIAlertView alloc] initWithTitle: pszTitle
                                                          message: pszMsg
                                                         delegate: nil
                                                cancelButtonTitle: @"OK"
                                                otherButtonTitles: nil];
    [messageBox autorelease];
    [messageBox show];
}
@end