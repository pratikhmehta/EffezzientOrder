//
//  WebServiceParser
//

/*
 * Queued server to manage concurrency and priority of NSURLRequests.
 */

#import <Foundation/Foundation.h>

#import "WebServiceDataAdaptor.h"

typedef void (^ResponseBlock)     (NSError *error, id objects, NSString *responseString);
typedef void (^ResponseWithRequestBlock)     (NSError *error, id objects, NSString *responseString, NSMutableDictionary *requestParams);

@interface WebServiceResponse : NSObject
{
    Reachability *reachability;
}

@property (strong) NSOperationQueue *operationQueue;

+ (id)sharedMediaServer;

- (void)initWithWebRequests:(NSMutableURLRequest *)URLRequest inBlock:(ResponseBlock)resBlock;
- (void)initWithWebRequests:(NSMutableURLRequest *)URLRequest requestParams:(NSMutableDictionary *)ParamsDictionary inBlock:(ResponseWithRequestBlock)resBlock;

@end
