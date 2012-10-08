//
//  ViewController.h
//  BrandNames
//
//  Created by Anil Kumar on 10/4/12.
//  Copyright (c) 2012 Anil Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *brandTable;
    NSMutableArray *brandArray;
     NSMutableArray *indexArray;
   // NSArray *brandNames;
    NSMutableArray *productArray;
    UISearchBar *reportSearchBar;
   // UISearchDisplayController *reportSearchDisplayController;
     BOOL searching;
    NSMutableArray *tempArray;
    NSMutableArray *searchedDataArray;
    
   
    
}
-(void)searchTableView;
-(void)doneBarButtonClicked;
-(void)cancelBarButtonClicked;

@property(nonatomic,retain) UITableView *brandTable;
@property(nonatomic,retain) UISearchBar *reportSearchBar;
@property(nonatomic,retain) NSMutableArray *productArray;
@property (nonatomic, retain) NSMutableArray *searchedDataArray;

//@property(nonatomic,retain)  UISearchDisplayController *reportSearchDisplayController;
@end
