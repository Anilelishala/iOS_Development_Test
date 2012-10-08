//
//  ViewController.m
//  BrandNames
//
//  Created by Anil Kumar on 10/4/12.
//  Copyright (c) 2012 Anil Kumar. All rights reserved.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize brandTable,reportSearchBar,productArray,searchedDataArray;

- (void)viewDidLoad
{
       
    brandTable=[[UITableView alloc]initWithFrame:CGRectMake(0,40,320,420) style:UITableViewStylePlain];
    [brandTable setDataSource:self];
    [brandTable setDelegate:self];
    [self.view addSubview:brandTable];
    
    NSString *jsonString = [NSString
                            stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://50.112.126.131:8181/brandNames"]]
                            encoding:NSStringEncodingConversionAllowLossy
                            error:nil];
    
    
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSMutableArray *brandNames = [parser objectWithString:jsonString];
    
    productArray= [brandNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
   
    tempArray=[[NSMutableArray alloc]init];
    self.searchedDataArray = [[NSMutableArray alloc]init];
    

    
    reportSearchBar= [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,320,40)];
    reportSearchBar.tintColor = [UIColor clearColor];;
  //  reportSearchBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    reportSearchBar.delegate = self;
    [self.view addSubview:reportSearchBar];
 
    [self shortListTheSearhBar];
      
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)shortListTheSearhBar
{
    int tCount = [self.productArray count];
    [tempArray removeAllObjects];
    
    for (int i = 0; i < tCount; i++) {
        NSString *tempStr = [self.productArray objectAtIndex:i];
        if (tempStr && [tempStr length]) {
            NSString *firstChar = [NSString stringWithFormat:@"%c",[tempStr characterAtIndex:0]];
            firstChar=[firstChar uppercaseString];
            int charCount = [tempArray count];
            BOOL  isCharFound = NO;
            for (int k = 0; k < charCount; k++) {
                if ([[tempArray objectAtIndex:k] isEqualToString:firstChar]) {
                    isCharFound = YES;
                    break;
                }
            }
            if (isCharFound == NO) {
                [tempArray addObject:firstChar];
            }
        }
    }
    NSLog(@"tempArray:%@",tempArray);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [tempArray count];

   // return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tempArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (searching) {
        return [searchedDataArray count];
    }else{
        return [productArray count];
      
    }

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:CellIdentifier];
    }
    
    if (searching) {
        cell.textLabel.text = [searchedDataArray objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text =[productArray objectAtIndex:indexPath.row];
    }
    
    

    
    return cell;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	
    
	if (tableView.tag==1) {
        //  NSLog(@"..serchbytableView");
        
        return nil;
    }
    
    [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
  //  NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    

//	[tempArray addObject:@"A"];
//	[tempArray addObject:@"B"];
//	[tempArray addObject:@"C"];
//	[tempArray addObject:@"D"];
//	[tempArray addObject:@"E"];
//	[tempArray addObject:@"F"];
//	[tempArray addObject:@"G"];
//	[tempArray addObject:@"H"];
//	[tempArray addObject:@"I"];
//	[tempArray addObject:@"J"];
//	[tempArray addObject:@"K"];
//	[tempArray addObject:@"L"];
//	[tempArray addObject:@"M"];
//	[tempArray addObject:@"N"];
//	[tempArray addObject:@"O"];
//	[tempArray addObject:@"P"];
//	[tempArray addObject:@"Q"];
//	[tempArray addObject:@"R"];
//	[tempArray addObject:@"S"];
//	[tempArray addObject:@"T"];
//	[tempArray addObject:@"U"];
//	[tempArray addObject:@"V"];
//	[tempArray addObject:@"W"];
//	[tempArray addObject:@"X"];
//	[tempArray addObject:@"Y"];
//	[tempArray addObject:@"Z"];
//	
    //  NSLog(@"%@",tempArray);
    // return tableView.
       [self comparing];
	return tempArray;
    
}





- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	
	NSLog(@"%@",title);
    if (searching) 

	{
        for (int i = 0; i < [searchedDataArray count]; i++) {
            NSString *firstLetter = [[searchedDataArray objectAtIndex:i] substringToIndex:1];
            if ([firstLetter isEqualToString:title]) {
                if (i != 0) {
                    [self.brandTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    return i;
                }
            }
        }
        return -1;
    }
    else{
        
        for (int i = 0; i < [productArray count]; i++) {
            NSString *firstLetter = [[productArray objectAtIndex:i] substringToIndex:1];
            if ([firstLetter isEqualToString:title]) {
                if (i != 0) {
                    [self.brandTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    return i;
                }
            }
        }
        return -1;
    }
    
    //tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	
}
-(void)comparing;
{
    for (int i=0;i<[productArray count];i++)
    {
        for (int j=0;j<[tempArray count];j++)
        {
            if ([[productArray objectAtIndex:i] isEqualToString:[tempArray objectAtIndex:j]])
            {
                [indexArray addObject:[productArray objectAtIndex:i]];
                NSLog(@"anil%@",indexArray);
            }
            
        }
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //edit = @"Selected";
    
    
}
#pragma mark UISearchBar
#pragma mark Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
     self.brandTable.allowsSelection = NO;
     self.brandTable.scrollEnabled = NO;
    
    
}
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    NSLog(@"text has been changed");
   [searchedDataArray removeAllObjects];
    [self searchTableView];
    [self.brandTable reloadData];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    self.brandTable.allowsSelection = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.brandTable.allowsSelection = YES;
    self.brandTable.scrollEnabled = YES;
    
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [reportSearchBar setShowsCancelButton:NO animated:YES];
    [reportSearchBar resignFirstResponder];
    self.brandTable.allowsSelection = YES;
    self.brandTable.scrollEnabled = YES;
	
    [self.searchedDataArray removeAllObjects];
    [self searchTableView];
    [self.brandTable reloadData];
}
- (void)searchTableView {
	NSString *searchText = reportSearchBar.text;
    
   int i=0;
	for (NSString *sTemp in productArray)
	{
          //Category* objCategory = [eventsArray objectAtIndex:i];
        NSComparisonResult result = [[productArray objectAtIndex:i] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
          {
            [searchedDataArray addObject:[productArray objectAtIndex:i]];
             
              
              

       }
      i++;
	}
    searching = YES;
	NSLog(@"searchedDataArray items===============%@",searchedDataArray);
    
}

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active{
    self.brandTable.allowsSelection = !active;
    self.brandTable.scrollEnabled = !active;
    if (!active) {
        [searchBar resignFirstResponder];
    } else {
		
        // probably not needed if you have a details view since you
        // will go there on selection
        NSIndexPath *selected = [self.brandTable
                                 indexPathForSelectedRow];
        if (selected) {
            [self.brandTable deselectRowAtIndexPath:selected
                                                   animated:NO];
        }
    }
    [searchBar setShowsCancelButton:active animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
