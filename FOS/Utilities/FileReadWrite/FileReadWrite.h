//
//  FileReadWrite.h
//  Gimik
//

#import <Foundation/Foundation.h>

@interface FileReadWrite : NSObject{
    
}
/**
	This method will write the data to the file.
	@param fileName where the data to be written.
	@param data Which is to written in the file.    
 */
+(void)writeFile:(NSString *)fileName data:(id)data;
/**
	It will read the data from the file.
	@param fileName from where the data to be read.
	@returns the data which is read,
 */
+(NSMutableArray *)readFile:(NSString *)fileName;

@end
