//
//  PFileManagerSpec.m
//  Present
//
//  Created by Justin Makaila on 3/17/14.
//  Copyright 2014 Present, Inc. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "PFileManager.h"

SPEC_BEGIN(PFileManagerSpec)

describe(@"PFileManager", ^{
    __block NSString *testFileName = @"testFile";
    __block NSString *testDirName = @"testDir";
    
    it (@"can return a path to a file in a specified directory", ^{
        NSString *filePath = [PFileManager pathToFile:testFileName inSearchPathDirectory:NSDocumentDirectory];
        [[filePath should] beNonNil];
    });
    
    it (@"can create a file", ^{
        BOOL createdFile = [PFileManager createFile:testFileName withData:[NSData data] inSearchPathDirectory:NSDocumentDirectory];
        [[theValue(createdFile) should] beYes];
        
        BOOL fileExists = [PFileManager file:testFileName existsInSearchPathDirectory:NSDocumentDirectory];
        [[theValue(fileExists) should] beYes];
    });
    
    it (@"can enumerate over the files in a directory", ^{
        [PFileManager enumerateFilesInDirectory:[PFileManager pathToFile:@"" inSearchPathDirectory:NSLibraryDirectory]];
    });
    
    context(@"when a file is already created", ^{
        NSString *testPath = [PFileManager pathToFile:testFileName inSearchPathDirectory:NSDocumentDirectory];
        beforeEach(^{
            [PFileManager createFileAtPath:testPath withData:[NSData data]];
        });
        
        afterEach(^{
            if ([PFileManager fileExistsAtPath:testPath]) {
                [PFileManager deleteFileAtPath:testPath];
            }
        });
        
        it (@"can tell if a file exists", ^{
            BOOL fileExists = [PFileManager file:testFileName existsInSearchPathDirectory:NSDocumentDirectory];
            [[theValue(fileExists) should] beYes];
        });
        
        it (@"can delete a file", ^{
            BOOL deletedFile = [PFileManager deleteFile:testFileName inSearchPathDirectory:NSDocumentDirectory];
            [[theValue(deletedFile) should] beYes];
        });
    });
    
    it (@"can create a directory", ^{
        NSString *path = [PFileManager pathToFile:testDirName inSearchPathDirectory:NSDocumentDirectory];
        if ([PFileManager fileExistsAtPath:path]) {
            [PFileManager deleteFileAtPath:path];
        }
        
        [[theValue([PFileManager createDirectoryInDocuments:testDirName]) should] beYes];
    });
    
    it (@"can empty a directory", ^{
        [PFileManager createDirectoryInDocuments:testDirName];
        
        NSString *directoryToEnumerate = [PFileManager pathToFile:testDirName inSearchPathDirectory:NSDocumentDirectory];
        for (NSInteger i = 0; i < 100; i++) {
            NSString *fileName = [NSString stringWithFormat:@"newFile_%i", i];
            NSString *newPath = [directoryToEnumerate stringByAppendingPathComponent:fileName];
            [PFileManager createFileAtPath:newPath withData:[NSData data]];
        }
        
        [PFileManager emptyDocumentsDirectory];
    });
});

SPEC_END

