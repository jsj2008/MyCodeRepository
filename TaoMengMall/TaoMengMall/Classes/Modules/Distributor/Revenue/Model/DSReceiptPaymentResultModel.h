//
//  DSReceiptPaymentResultModel.h
//  CarKeeper
//
//  Created by marco on 3/3/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSReceiptPaymentModel.h"

@interface DSReceiptPaymentResultModel : BaseModel

@property (nonatomic, strong) NSArray<DSReceiptPaymentModel,Optional> *list;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;;

@end
