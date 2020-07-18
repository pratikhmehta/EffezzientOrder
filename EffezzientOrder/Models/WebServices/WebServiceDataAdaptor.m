//
//  WebHelper.m
//  SQLExample
//

#import "WebServiceDataAdaptor.h"
#import <objc/runtime.h>

@implementation WebServiceDataAdaptor
{
    NSString *requestedUrl;
}
@synthesize arrParsedData;

-(NSArray *) autoParse:(NSDictionary *) allValues forServiceName:(NSString *)requestURL
{
    arrParsedData = [NSArray new];
    
    if (isService(URLGetProductList) || isService(URLGetSimilarProductList) || isService(URLGetOrderCatalogueItemData)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:ProductListClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLGetProductSize)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:ProductSizeClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLGetProductSpec)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:ProductSpecClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if(isService(URLGetProductDetail)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:ProductDetailsClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLGetSelectableSpecs)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:ProductSelectableSpecClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLGetModuleFilter)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:FilterClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLGetModuleFilterValues)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:FilterValuesClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if(isService(URLGetDispatchType)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:DispatchTypeClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if(isService(URLGetCart)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:CartDataClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if(isService(URLGetCartCount)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:CartCountClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if(isService(URLAddUpdateCart)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:CartCountClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if(isService(URLGetListOfDistributors)){
        arrParsedData = [self processJSONData:allValues
                                     forClass:DistributorListClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLGetProductCategory))
    {
        arrParsedData = [self processJSONData:allValues
                                     forClass:ProductCategoryClass
                                    forEntity:@""
                                  withJSONKey:kSuccessData];
    }
    else if (isService(URLFormConfiguration))
    {
        arrParsedData = [self processJSONData:allValues
                                     forClass: FormConfigurationClass
                                    forEntity: @""
                                  withJSONKey: kSuccessData];
    }
    else if (isService(URLGetOrderAchievementList))
    {
        arrParsedData = [self processJSONData:allValues
                                     forClass: OrderAchievementClass
                                    forEntity: @""
                                  withJSONKey: kSuccessData];
    }

/** For forgot password and change password we get no data in response. Empty array will be returned. **/

    return arrParsedData;
}

#pragma mark - Helper Method

-(void)processJSONToUserDefaults:(NSDictionary *)dict withJSONKeys:(NSMutableArray *)json_Keys
{
    /** this method will save the value of single key to user default. Modify this method to get multiple inner values of dict key or to return string from function **/
//    for(int i =0;i<[json_Keys count];i++)
//    {
//        [Function setStringValueToUserDefaults:[Function getStringForKey:[json_Keys objectAtIndex:i] fromDictionary:dict] ForKey:[json_Keys objectAtIndex:i]];
//    }
}

-(NSArray *) processJSONData: (NSDictionary *)dict forClass:(NSString *)classname forEntity:(NSString *)entityname withJSONKey:(NSString *)json_Key
{
    NSMutableArray *arrProcessedData = [NSMutableArray array];
    //[CoreDataAdaptor deleteDataInCoreDB:entityname];
    
// conditional flow added by ami
    if ([[dict objectForKey:json_Key] isKindOfClass:[NSArray class]])
    {
        for(int i =0;i<[[dict objectForKey:json_Key] count];i++)
        {
            NSDictionary *allvalues = [[dict objectForKey:json_Key] objectAtIndex:i];
            id objClass = [[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues];
            [arrProcessedData addObject:objClass];
        }
    }
    else
    {
        @try {
            NSDictionary *allvalues = [dict objectForKey:json_Key];
            id objClass = [[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues];
            [arrProcessedData addObject:objClass];
        } @catch (NSException *exception) {
            NSLog(@"Exception : %@", exception);
        }
        
//        NSDictionary *allvalues = [dict objectForKey:json_Key];
//        id objClass = [[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues];
//        [arrProcessedData addObject:objClass];
    }

    return arrProcessedData;
}


@end
