//
//  PFileManager.h
//  Present
//
//  Created by Justin Makaila on 3/17/14.
//  Copyright (c) 2014 Present, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFileManager : NSObject

#pragma mark - Files

+ (NSString*)pathToSearchPathDirectory:(NSSearchPathDirectory)directory;
+ (NSString*)pathToFile:(NSString *)file inSearchPathDirectory:(NSSearchPathDirectory)directory;
+ (NSString*)pathToFile:(NSString*)file inDirectory:(NSString*)directory;

+ (BOOL)fileExistsAtPath:(NSString*)filePath;
+ (BOOL)file:(NSString*)fileName existsInSearchPathDirectory:(NSSearchPathDirectory)directory;

+ (BOOL)createFileAtPath:(NSString*)filePath withData:(NSData*)data;
+ (BOOL)createFile:(NSString*)fileName withData:(NSData*)data inDirectory:(NSString*)directoryPath;
+ (BOOL)createFile:(NSString*)fileName withData:(NSData*)data inSearchPathDirectory:(NSSearchPathDirectory)directory;

+ (BOOL)deleteFileAtPath:(NSString*)filePath;
+ (BOOL)deleteFileAtURL:(NSURL*)fileURL;
+ (BOOL)deleteFile:(NSString*)fileName inSearchPathDirectory:(NSSearchPathDirectory)directory;

#pragma mark - Directories

+ (BOOL)createDirectoryInDocuments:(NSString*)directoryName;
+ (BOOL)createDirectoryInLibrary:(NSString*)directoryName;
+ (BOOL)createDirectoryInCaches:(NSString*)directoryName;

+ (void)emptyDocumentsDirectory;
+ (void)emptyLibraryDirectory;
+ (void)emptyCachesDirectory;

+ (void)enumerateFilesInDirectory:(NSString*)directoryPath;
+ (void)enumerateFilesInDirectory:(NSString *)directoryPath withBlock:(void(^)(NSString *))block;

#pragma mark - I/O

+ (BOOL)saveObject:(id)object toLocation:(NSString*)location inSearchPathDirectory:(NSSearchPathDirectory)directory;
+ (id)loadObjectFromLocation:(NSString*)location inSearchPathDirectory:(NSSearchPathDirectory)directory;

@end
