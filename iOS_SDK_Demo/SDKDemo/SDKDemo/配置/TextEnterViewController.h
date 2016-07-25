//
//  TextEnterViewController.h
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/7/13.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextEnterViewControllerDelegate <NSObject>

- (void)textEnterCompleteWithTextString:(NSString *)textString controllerTag:(NSInteger)controllerTag;

@end


@interface TextEnterViewController : UIViewController

@property (nonatomic, strong) NSString *placeHolderString;
@property (nonatomic, strong) NSString *textString;
@property (nonatomic) NSInteger tag;
@property (nonatomic, weak) id<TextEnterViewControllerDelegate> delegate;

@end
