//
//  DetailViewController.h
//  Te_Ki_To_U
//
//  Created by kanon kitamura on 2015/02/19.
//  Copyright (c) 2015年 myname. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

