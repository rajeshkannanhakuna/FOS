//
//  FileReadWrite.m
//  Gimik
//

#import "FileReadWrite.h"

@implementation FileReadWrite

#pragma mark - WRITE FILE

+(void)writeFile:(NSString *)fileName data:(id)data{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // the path to write file
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    appFile=[appFile stringByAppendingFormat:@"%@",@".plist"];
    if(data!=nil && [data count]!=0)
         [data writeToFile:appFile atomically:YES];
}

#pragma mark - READ FILE

+(NSMutableArray *)readFile:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    appFile=[appFile stringByAppendingFormat:@"%@",@".plist"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:appFile])
        {
             NSError *error= NULL;
             NSString *bundle = [[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"];
             [fileManager copyItemAtPath:bundle toPath:appFile error:&error];
         } 
    NSError *error= NULL;
    NSMutableArray *aryAppID=[NSMutableArray arrayWithContentsOfFile:appFile];
//    if([fileName isEqualToString:@"favoriteList"]){
//          if([aryFav count] == 0){
//               [dicFB setObject:[NSNumber numberWithBool:1] forKey:@"FacebookShare"];
//             }
//        }
    if (error == NULL){
         return aryAppID;
    }
    return nil;
}

@end
