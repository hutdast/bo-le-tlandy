//
//  ServerRequest.h
//  bòlètlandy
//
//  Created by nikenson midi on 6/12/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerRequest : NSObject

 - (NSDictionary *) getDataFromGet:(NSString *)url;
- (NSDictionary *) getDataFromPost:(NSString *)url dataString:(NSString *)post;

@end