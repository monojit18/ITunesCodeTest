//
//  DetailViewController.m
//  ITunesSearch
//
//  Created by Monojit Datta on 22/11/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *artWorkImageView;
@property (weak, nonatomic) IBOutlet UILabel *collectionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLabel;

-(void) prepareDetailsView;

@end

@implementation DetailViewController

-(void) prepareDetailsView
{
    
    self.artWorkImageView.image = [UIImage imageWithData:self.searchModel.artWorkData];
    self.collectionNameLabel.text = self.searchModel.collectionName;
    self.releaseDateLabel.text = self.searchModel.releaseDate;
    self.priceNameLabel.text = self.searchModel.collectionPrice.stringValue;
    
    self.artWorkImageView.layer.cornerRadius = self.artWorkImageView.bounds.size.width/2;
    self.artWorkImageView.layer.masksToBounds = YES;
    self.artWorkImageView.layer.borderWidth = 2.0;
    self.artWorkImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    
}

- (void)configureView {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self prepareDetailsView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
