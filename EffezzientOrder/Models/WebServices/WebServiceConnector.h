//
//  WebConnector.h
//  SQLExample
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface WebServiceConnector : NSObject
{
    NSArray *responseArray;
    NSDictionary *responseDict;
    NSString *responseError;
    NSMutableURLRequest *URLRequest;
    NSInteger responseCode;
    NSDictionary *requestDict;

}
@property (nonatomic,retain) NSDictionary *responseDict;
@property (nonatomic,retain)    NSArray *responseArray;
@property (nonatomic,retain)    NSString *responseError;
@property (nonatomic,retain) NSMutableURLRequest *URLRequest;
@property (nonatomic) NSInteger responseCode;
@property (nonatomic,retain) NSDictionary *requestDict;

@property (nonatomic, retain) NSString *strRequestParams;

-(void)init:(NSString *) WebService
                        withParameters:(NSDictionary *) ParamsDictionary
                            withObject:(id)object
                          withSelector:(SEL)selector
                        forServiceType:(NSString *)serviceType
                        showDisplayMsg:(NSString *)message;
// used in swift
-(void) callServiceUrl :(NSString *) WebService
         withParameters:(NSDictionary *) ParamsDictionary
             withObject:(id)object
           withSelector:(SEL)selector
         forServiceType:(NSString *)serviceType
         showDisplayMsg:(NSString *)message;

-(void) init:(NSString *)WebService withPOSTParam:(NSMutableDictionary *)ParamsDictionary withObject:(id)object withSelector:(SEL)selector showDisplayMsg:(NSString *)message showLoader :(BOOL)showLoader;

- (BOOL)checkNetConnection;

//-(NSString *) getNetURLFromService:(NSString *) WebService withParams: (NSArray *) ParamsArray;

-(NSMutableURLRequest *) getMutableRequestFromGetWS:(NSString *)WebService withParams: (NSDictionary *) ParamsDictionary;

- (NSMutableURLRequest *)getMutableRequestForPostWS:(NSString *)url withObjects:(NSDictionary *)dict isJsonBody:(bool)JSONBody;

-(NSMutableURLRequest *)getMutableRequestForPostMultipartWS:(NSString *)url withObjects:(NSDictionary *)dict;

@end
