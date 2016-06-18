//
//  ServerRequest.m
//  bòlètlandy
//
//  Created by nikenson midi on 6/12/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

#import "ServerRequest.h"

@implementation ServerRequest

-(NSDictionary *)getDataFromGet:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
//    NSError *error = [[NSError alloc] init]; - not allowed to create an instance of nserror because it is redundant
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *ResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSDictionary *json;

    if([responseCode statusCode] != 200){

        json = @{@"URL": url, @"Error": [NSNumber numberWithLongLong:[responseCode statusCode]]};
    }else{
       json = [NSJSONSerialization JSONObjectWithData:ResponseData options:kNilOptions error:&error];
        
    }
    return json;
    
    
}

-(NSDictionary *)getDataFromPost:(NSString *)url dataString:(NSString *)post{
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
       [request setHTTPBody:postData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:url]];
 
    
//Return the response
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *ResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSDictionary *json;

    if([responseCode statusCode] != 200){
        
        json = @{@"URL": url, @"Error": [NSNumber numberWithLongLong:[responseCode statusCode]]};
    }else{
        json = [NSJSONSerialization JSONObjectWithData:ResponseData options:kNilOptions error:&error];
        
    }
    return json;


}



@end