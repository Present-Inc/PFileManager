//
//  PFileManager.m
//  Present
//
//  Created by Justin Makaila on 3/17/14.
//  Copyright (c) 2014 Present, Inc. All rights reserved.
//

#import "PFileManager.h"

@implementation PFileManager

+ (NSString*)pathToSearchPathDirectory:(NSSearchPathDirectory)directory {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}

+ (NSString*)pathToFile:(NSString *)file inSearchPathDirectory:(NSSearchPathDirectory)directory {
    return [self pathToFile:file inDirectory:[self pathToSearchPathDirectory:directory]];
}

+ (NSString*)pathToFile:(NSString*)fileName inDirectory:(NSString*)directoryPath {
    return [directoryPath stringByAppendingPathComponent:fileName];
}

+ (BOOL)fileExistsAtPath:(NSString*)path {
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    return fileExists;
}

+ (BOOL)file:(NSString *)fileName existsInSearchPathDirectory:(NSSearchPathDirectory)directory {
    return [self fileExistsAtPath:[self pathToFile:fileName inSearchPathDirectory:directory]];
}

#pragma mark Creation

+ (BOOL)createFileAtPath:(NSString *)filePath withData:(NSData *)data {
    if (![self fileExistsAtPath:filePath]) {
        return [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    }
    
    return NO;
}

+ (BOOL)createFile:(NSString*)fileName withData:(NSData*)data inDirectory:(NSString*)directoryPath {
    NSString *newFilePath = [self pathToFile:fileName inDirectory:directoryPath];
    return [self createFileAtPath:newFilePath withData:data];
}

+ (BOOL)createFile:(NSString*)fileName withData:(NSData*)data inSearchPathDirectory:(NSSearchPathDirectory)directory {
    return [self createFile:fileName withData:data inDirectory:[self pathToSearchPathDirectory:directory]];
}

#pragma mark Deletion

+ (BOOL)deleteFileAtPath:(NSString *)filePath {
    NSError *error = nil;
    if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
        NSLog(@"ERROR!\n An error occurred while removing the file at \"%@\":\n %@", filePath, error);
        return NO;
    }else {
        return YES;
    }
}

+ (BOOL)deleteFileAtURL:(NSURL *)fileURL {
    return [self deleteFileAtPath:fileURL.path];
}

+ (BOOL)deleteFile:(NSString *)fileName inSearchPathDirectory:(NSSearchPathDirectory)directory {
    return [self deleteFileAtPath:[self pathToFile:fileName inSearchPathDirectory:directory]];
}


#pragma mark - Directory Management

#pragma mark Creation

+ (BOOL)createDirectoryInDocuments:(NSString *)directoryName {
    return [self createDirectory:directoryName inDirectory:NSDocumentDirectory];
}

+ (BOOL)createDirectoryInLibrary:(NSString *)directoryName {
    return [self createDirectory:directoryName inDirectory:NSLibraryDirectory];
}

+ (BOOL)createDirectoryInCaches:(NSString *)directoryName {
    return [self createDirectory:directoryName inDirectory:NSCachesDirectory];
}

#pragma mark Destruction

+ (void)emptyDocumentsDirectory {
    [self emptyDirectory:NSDocumentDirectory];
}

+ (void)emptyLibraryDirectory {
    [self emptyDirectory:NSLibraryDirectory];
}

+ (void)emptyCachesDirectory {
    [self emptyDirectory:NSCachesDirectory];
}

#pragma mark List

+ (void)enumerateFilesInDirectory:(NSString*)path {
    [self enumerateFilesInDirectory:path withBlock:^(NSString *filePath) {
        NSLog(@"File path: %@", filePath);
    }];
}

+ (void)enumerateFilesInDirectory:(NSString*)directoryPath withBlock:(void(^)(NSString *))block {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:directoryPath];
    for (NSString *filePath in directoryEnumerator) {
        block(filePath);
    }
}

#pragma mark - Utilities

+ (BOOL)createDirectory:(NSString*)directoryName inDirectory:(NSSearchPathDirectory)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullPath = [self pathToFile:directoryName inSearchPathDirectory:directory];
    
    if (![fileManager fileExistsAtPath:fullPath]) {
        return [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return NO;
}

+ (void)emptyDirectory:(NSSearchPathDirectory)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directoryPath = [self pathToSearchPathDirectory:directory];
    NSEnumerator *enumerator = [[fileManager contentsOfDirectoryAtPath:directoryPath error:nil] objectEnumerator];
    
    NSString *fileName;
    while (fileName = [enumerator nextObject]) {
        NSLog(@"Deleting file name: %@", fileName);
        [fileManager removeItemAtPath:[directoryPath stringByAppendingPathComponent:fileName] error:nil];
    }
}

+ (BOOL)saveObject:(id)object toLocation:(NSString *)location inSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *archivePath = [PFileManager pathToFile:location inSearchPathDirectory:directory];
    
    if ([PFileManager fileExistsAtPath:archivePath]) {
        [PFileManager deleteFileAtPath:archivePath];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    return [PFileManager createFileAtPath:archivePath withData:data];
}

+ (id)loadObjectFromLocation:(NSString *)location inSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *archivePath = [PFileManager pathToFile:location inSearchPathDirectory:directory];
    
    if ([PFileManager fileExistsAtPath:archivePath]) {
        NSData *sessionData = [NSData dataWithContentsOfFile:archivePath];
        return [NSKeyedUnarchiver unarchiveObjectWithData:sessionData];
    }else {
        return nil;
    }
}

@end
