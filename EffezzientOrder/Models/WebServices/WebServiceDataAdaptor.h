//
//  WebHelper.h
//  SQLExample
//

#import <Foundation/Foundation.h>




@interface WebServiceDataAdaptor : NSObject
{

}
@property(nonatomic,retain) NSArray *arrParsedData;


-(NSArray *) autoParse:(NSDictionary *) allValues
        forServiceName:(NSString *)requestURL;

-(NSArray *) processJSONData: (NSDictionary *)dict
                    forClass:(NSString *)classname
                   forEntity:(NSString *)entityname
                 withJSONKey:(NSString *)json_Key;

@end
