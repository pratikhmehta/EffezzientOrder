//
//  WebConnector.m
//  SQLExample
//

#import "WebServiceConnector.h"
#import "WebServiceResponse.h"
#import "WebServiceDataAdaptor.h"

#define DEFAULT_TIMEOUT 30.0f

@implementation WebServiceConnector
@synthesize responseArray,responseError,responseDict,responseCode,URLRequest, strRequestParams;


- (BOOL)checkNetConnection
{
    return [Global checkForConnection];
}

-(void)init:(NSString *) WebService
                withParameters:(NSDictionary *) ParamsDictionary
                withObject:(id)object
                withSelector:(SEL)selector
                forServiceType:(NSString *)serviceType/* serviceType: {GET, POST, JSON} */
                showDisplayMsg:(NSString *)message
{
    WebServiceResponse *server = [WebServiceResponse sharedMediaServer];
    ShowNetworkIndicator(YES);
    responseCode = 100;
    responseError = [[NSString alloc]init];
    responseArray = [[NSArray alloc]init];
    
    NSMutableDictionary *mutableParamsDictionary = [ParamsDictionary mutableCopy];
    [mutableParamsDictionary setValue:[ShareInfo sharedManagerInfo].userTimeZone forKey:MM_UserTimeZone];
    
    ParamsDictionary = [NSDictionary dictionaryWithDictionary:mutableParamsDictionary];
    
    if([serviceType isEqualToString:@"GET"])
    {
        URLRequest = [self getMutableRequestFromGetWS:WebService withParams:ParamsDictionary];
    }
    else if([serviceType isEqualToString:@"POST"])
    {
        URLRequest = [self getMutableRequestForPostWS:WebService withObjects:ParamsDictionary isJsonBody:NO];
    }
    else if([serviceType isEqualToString:@"JSON"])
    {
        URLRequest = [self getMutableRequestForPostWS:WebService withObjects:ParamsDictionary isJsonBody:YES];
    }
    
    if (![self checkNetConnection])
    {
        responseCode = 104;
        self.responseError = @"The internet connection was lost.";
        //        [SVProgressHUD showErrorWithStatus:@"The network connection was lost." withViewController:[Function topMostController]];
        [object performSelectorOnMainThread:selector withObject:self waitUntilDone:NO];
        return;
    }
    
    if ([message isValid])
    {
        [SVProgressHUD showWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
    }
    
#if SETHJIBANO_VERSION
    NSString *token = [DefaultsValues getStringValueFromUserDefaults_ForKey:MM_Token];
    if(token){
        [URLRequest setValue:token forHTTPHeaderField:MM_Token];
    }
#endif
    
    [server initWithWebRequests:URLRequest inBlock:^(NSError *error, id objects, NSString *responseString)
     {
         if (error)
         {
             responseCode = 101;
             self.responseError = error.localizedDescription;
         }
         else
         {
             if ([responseString isEqualToString:@"Fail"])
             {
                 responseCode = 102;
                 self.responseError = @"Response Issue From Server";
             }
             else if ([responseString isEqualToString:@"Not Available"])
             {
                 responseCode = 103;
                 self.responseError = @"No Data Available";
                 ShowNetworkIndicator(NO);
             }
             else if ([responseString isEqualToString:@"Null"])
             {
                 responseCode = 104;
                 self.responseError = @"Response Null";
             }
             else
             {
                 responseCode = 100;
                 responseDict = (NSDictionary *) objects;
                 responseArray = [[WebServiceDataAdaptor alloc]autoParse:responseDict forServiceName:WebService];
                 requestDict = ParamsDictionary;
                 
                 ShowNetworkIndicator(NO);
             }
         }
         if ([message isValid])
         {
             [SVProgressHUD dismiss];
         }
         [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
     }
     ];
}

-(void)callServiceUrl:(NSString *)WebService withParameters:(NSDictionary *)ParamsDictionary withObject:(id)object withSelector:(SEL)selector forServiceType:(NSString *)serviceType showDisplayMsg:(NSString *)message
{
    // used in swift
    [self init:WebService withParameters:ParamsDictionary withObject:object withSelector:selector forServiceType:serviceType showDisplayMsg:message];
}

#pragma mark - generate URL Methods
///*** this method can be used when there is cake php webservice ***/
//-(NSString *) getNetURLFromService:(NSString *) WebService withParams: (NSArray *) ParamsArray
//{
//    NSString *Query = WebService;
//    if(ParamsArray == nil)
//        return nil;
//
//    for(int i = 0;i<[ParamsArray count];i++)
//    {
//        NSString *appendString = [NSString stringWithFormat:@"/%@",[ParamsArray objectAtIndex:i]];
//        Query = [Query stringByAppendingString:appendString];
//    }
//    return Query;
//}

/*** this method can be used when parameters are to be sent as query string ***/
-(NSMutableURLRequest *) getMutableRequestFromGetWS:(NSString *)WebService withParams: (NSDictionary *) ParamsDictionary
{
    //   TraceWS(WebService,ParamsDictionary,@"GET")
    NSString *Query;
    
    if(ParamsDictionary == nil)
    {
        Query = WebService;
    }
    else
    {
        int i = 0;
        Query = WebService;
        for(id key in ParamsDictionary)
        {
            NSString *appendString = @"";
            if(i != ParamsDictionary.count - 1)
                appendString = [appendString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[ParamsDictionary objectForKey:key]] ];
            else
                appendString = [appendString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[ParamsDictionary objectForKey:key]]];
            Query = [Query stringByAppendingString:appendString];
            i++;
        }
    }
    //    Query = [Query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    Query = [Query stringByAddingPercentEncodingWithAllowedCharacters:
             [NSCharacterSet URLHostAllowedCharacterSet]];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:Query]
                                    cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                    timeoutInterval:DEFAULT_TIMEOUT];
    
    //    NSLog(@"request : %@", [request URL]);
    //
    //    NSLog(@"strRequest : %@", [[request.URL absoluteString] stringByRemovingPercentEncoding]);
    
    return request;
}

- (NSMutableURLRequest *)getMutableRequestForPostWS:(NSString *)url withObjects:(id)dict isJsonBody:(bool)JSONBody
{
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:urlString]
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:DEFAULT_TIMEOUT];
    NSData *objData;
    if (JSONBody)
    {
            objData = [self dictionaryToJSONData:dict];
            NSDictionary *headers = @{ @"content-type": @"application/json",
                                       @"accept": @"application/json" };
            
            [request setAllHTTPHeaderFields:headers];
            [request setHTTPBody:objData];
    }
    else
    {
//        TraceWS(url,dict,@"POST")
        objData = [self dictionaryToPostData:dict];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:objData];
    }
    
    /***************************************************************************/
    NSLog(@"\n\nURL\t: %@\nPARAMS\t: %@\n\n ", url, [NSString getStringFromData:objData]);
    /***************************************************************************/
    
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
//    NSLog(@"Request body %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    
    return request;
}



-(void) init:(NSString *)WebService withPOSTParam:(NSMutableDictionary *)ParamsDictionary withObject:(id)object withSelector:(SEL)selector showDisplayMsg:(NSString *)message showLoader :(BOOL)showLoader
{
    //    NSLog(@"%@ %@",ParamsDictionary,WebService);
    
    WebServiceResponse *server = [WebServiceResponse sharedMediaServer];
    ShowNetworkIndicator(YES);
    responseCode = 100;
    responseError = [[NSString alloc]init];
    responseArray = [[NSArray alloc]init];
    
    [ParamsDictionary setValue:[ShareInfo sharedManagerInfo].userTimeZone forKey:MM_UserTimeZone];
    
    URLRequest = [self getMutableRequestForPostMultipartWS:WebService withObjects:ParamsDictionary];
    
    if (![self checkNetConnection])
    {
        responseCode = 104;
        self.responseError = @"The network connection was lost.";
        [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
        return;
    }
    
    if(showLoader)
        [SVProgressHUD showWithStatus:message maskType:SVProgressHUDMaskTypeBlack];
    
    [server initWithWebRequests:URLRequest inBlock:^(NSError *error, id objects, NSString *responseString)
     {
         if (error)
         {
             responseCode = 101;
             self.responseError = error.localizedDescription;
             
         }
         else
         {
             NSString *status;
             if([[objects valueForKey:kStatusCode] isKindOfClass:[NSNumber class]])
                 status = [[objects valueForKey:kStatusCode] stringValue];
             else
                 status= [objects valueForKey:kStatusCode];
             
             
             if ([responseString isEqualToString:@"Fail"])
             {
                 responseCode = 102;
                 self.responseError = @"Response Issue From Server";
             }
             else if ([responseString isEqualToString:@"Not Available"])
             {
                 responseCode = 103;
                 self.responseError = @"No Data Available";
                 ShowNetworkIndicator(NO);
             }
             else if ([status isEqualToString:[NSString stringWithFormat:@"%d", kStatusCodeFalse]])
             {
                 responseCode = 104;
                 self.responseError = [[objects valueForKey:kErrorData] valueForKey:kErrorMessage];
                 ShowNetworkIndicator(NO);
             }
             else
             {
                 
                 responseCode = 100;
                 responseDict = (NSDictionary *) objects;
                 responseArray = [[WebServiceDataAdaptor alloc]autoParse:responseDict forServiceName:WebService];
                 requestDict = ParamsDictionary;
                 ShowNetworkIndicator(NO);
                 
             }
             
         }
         
         [SVProgressHUD dismiss];
         [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
         
     }];
    
    
}

// Multi part form data
-(NSMutableURLRequest *)getMutableRequestForPostMultipartWS:(NSString *)url withObjects:(NSDictionary *)dict{
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    //NSString* FileParamConstant =@"eventapp_media[]";
    NSString* FileParamConstant =@"file";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:url];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:DEFAULT_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    for(id key in dict)
    {
        if (![key isEqualToString:@"Files"] && ![key isEqualToString:@"Images"] && ![key isEqualToString:@"Documents"] && ![key isEqualToString:@"UploadedDocuments"])
        {
            [_params setObject:[NSString stringWithFormat:@"%@",[dict valueForKey:key]] forKey:key];
        }
    }
    
    for (NSString *param in _params)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [dict objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    NSMutableArray *arrMedia = [dict objectForKey:@"Images"];
    if(arrMedia.count>0)
    {
        for (int i = 0; i < arrMedia.count; i++)
        {
            id obj = [arrMedia objectAtIndex:i];
            
            UIImage *img = (UIImage *)obj;
            NSData *imageData = UIImageJPEGRepresentation(img,1.0);
            NSString *strImageName = [NSString stringWithFormat:@"%@.jpg", TimeStamp];
            NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,strImageName];
            
            if(imageData)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    ////////////Added By Me/////////////////
    
    NSMutableArray *arrDocuments = [dict objectForKey:@"Files"];
    if(arrDocuments.count>0)
    {
        for (int i = 0; i < arrDocuments.count; i++)
        {
            
            id obj = [arrDocuments objectAtIndex:i];
            
            NSString *strFileName = [NSString stringWithFormat:@"%@", TimeStamp];
            NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,strFileName];
            
            if(obj)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:obj];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    //    NSMutableDictionary *dictDocument = [dict objectForKey:@"Documents"];
    //    if(dictDocument.count>0)
    //    {
    //        for (id key in dictDocument)
    //        {
    //
    //            id obj = [dictDocument valueForKey:key];
    //
    //            NSString *strFileName = [NSString stringWithFormat:@"%@", key];
    //            NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,strFileName];
    //
    //            if(obj)
    //            {
    //                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    //                [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //                [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //                [body appendData:obj];
    //                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    //            }
    //        }
    //    }
    
    NSMutableDictionary *dictDocument = [dict objectForKey:@"Documents"];
    if(dictDocument.count>0)
    {
        //        NSString *strFileName = [NSString stringWithFormat:@"%@", key];
        NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", FileParamConstant];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        for (id key in dictDocument)
        {
            id obj = [dictDocument valueForKey:key];
            
            if(obj)
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:obj];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    //FOR GENERAL DOCUMENT UPLOAD
    NSDictionary *uploadDocs = dict[@"UploadedDocuments"];
    if([uploadDocs count] > 0){
        
        for(NSString *fileName in uploadDocs){
            
            NSLog(@"APPEND : %@", fileName);
            
            NSData *fileData = uploadDocs[fileName];
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"files\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:fileData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        
    }
    //pass MediaType file
    /*
     NSMutableArray *arrMedia = [dict objectForKey:@"Media"];
     if(arrMedia.count>0)
     {
     for (int i = 0; i < arrMedia.count; i++)
     {
     
     id obj = [arrMedia objectAtIndex:i];
     
     //            UIImage *img = (UIImage *)obj;
     //            NSData *imageData = UIImageJPEGRepresentation(img,1.0);
     NSString *strFileName = [NSDate stringFromDate:[NSDate date]];
     NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.mp3\"\r\n", FileParamConstant,strFileName];
     
     if(obj)
     {
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Type: audio/caf\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:obj];
     [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
     }
     }
     }
     */
    // Add below code while passing audio file in params dictionary
    /*
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     
     NSString *url = [NSString stringWithFormat:@"%@/record.mp3", documentsDirectory];
     
     // get the audio data from main bundle directly into NSData object
     NSData *audioData;
     audioData = [[NSData alloc] initWithContentsOfFile:url];
     // add it to body
     [postBody appendData:audioData];
     [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     */
    
    ////////////Added By Me/////////////////
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    
    NSString *strBody = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    NSLog(@"%@", strBody);
    
    // set URL
    [request setURL:requestURL];
    return request;
    
}

// Multi part form data
//-(NSMutableURLRequest *)getMutableRequestForPostMultipartWS:(NSString *)url withObjects:(NSDictionary *)dict{
//
//    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
//    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
//
//    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
//    //NSString* FileParamConstant =@"eventapp_media[]";
//    NSString* FileParamConstant =@"identity_doc";
//
//    // the server url to which the image (or the media) is uploaded. Use your server url here
//    NSURL* requestURL = [NSURL URLWithString:url];
//
//    // create request
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    [request setHTTPShouldHandleCookies:NO];
//    [request setTimeoutInterval:DEFAULT_TIMEOUT];
//    [request setHTTPMethod:@"POST"];
//
//    // set Content-Type in HTTP header
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
//    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
//
//    // post body
//    NSMutableData *body = [NSMutableData data];
//
//    // add params (all params are strings)
//    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
//    for(id key in dict)
//    {
//        // Use here the key contaning media data.
//        if (![key isEqualToString:@"Files"])
//        {
//            NSData *objData = [self dictionaryToJSONData:[dict valueForKey:key]];
//            //NSString *strData = [[NSString alloc] initWithData:objData encoding:NSUTF8StringEncoding];
//            [_params setObject:objData forKey:key];
//
//            NSMutableDictionary *mutableHeaders = [NSMutableDictionary dictionary];
//            [mutableHeaders setValue:[NSString stringWithFormat:@"form-data; name=\"%@\"", key] forKey:@"Content-Disposition"];
//            [request setAllHTTPHeaderFields:mutableHeaders];
//        }
//    }
//
//    for (NSString *param in _params)
//    {
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
////        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[_params objectForKey:param]];
////        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//
//// Fetch your document or images list using your key. My request uses "DocumentList" containing name of files and @"Files" containig array of files.
//    NSMutableArray *arrMedia = [dict objectForKey:@"Files"];
//    if(arrMedia.count>0)
//    {
//        for (int i = 0; i < arrMedia.count; i++)
//        {
//
//            id obj = [arrMedia objectAtIndex:i];
//
//            UIImage *img = (UIImage *)obj;
//            NSData *imageData = UIImageJPEGRepresentation(img,1.0);
//            NSString *strImageName = @"image.jpeg";
//            NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", FileParamConstant,strImageName];
//
//            if(imageData)
//            {
//                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
//                [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
//                [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//                [body appendData:imageData];
//                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
//            }
//        }
//    }
//
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
//
//    // setting the body of the post to the reqeust
//    [request setHTTPBody:body];
//
//    NSString *strBody = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
//
//    // set the content-length
//    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
//
//    NSLog(@"%@", [request allHTTPHeaderFields]);
//    NSLog(@"%@", strBody);
//
//    // set URL
//    [request setURL:requestURL];
//    return request;
//
//}


#pragma mark - helper methods

-(NSData *)dictionaryToJSONData:(NSDictionary *)dict
{
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:NSJSONWritingPrettyPrinted error:&jsonError];
    if (jsonError!=nil)
    {
        return nil;
    }
    return jsonData;
}

-(NSData *) dictionaryToPostData:(NSDictionary *) ParamsDictionary
{
    int i = 0;
    NSString *postDataString = @"";
    for(id key in ParamsDictionary)
    {
        if(i != ParamsDictionary.count - 1)
            postDataString = [postDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[ParamsDictionary objectForKey:key]]];
        else
            postDataString = [postDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[ParamsDictionary objectForKey:key]]];
        i++;
    }
    strRequestParams = postDataString;
    return [postDataString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
