//
//  ABI43_0_0AIRMapLocalTile.h
//  AirMaps
//
//  Created by Peter Zavadsky on 01/12/2017.
//  Copyright © 2017 Christopher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

#import <ABI43_0_0React/ABI43_0_0RCTComponent.h>
#import <ABI43_0_0React/ABI43_0_0RCTView.h>
#import "ABI43_0_0AIRMapCoordinate.h"
#import "ABI43_0_0AIRMap.h"
#import "ABI43_0_0RCTConvert+AirMap.h"

@interface ABI43_0_0AIRMapLocalTile : MKAnnotationView <MKOverlay>

@property (nonatomic, weak) ABI43_0_0AIRMap *map;

@property (nonatomic, strong) MKTileOverlay *tileOverlay;
@property (nonatomic, strong) MKTileOverlayRenderer *renderer;

@property (nonatomic, copy) NSString *pathTemplate;
@property (nonatomic, assign) CGFloat tileSize;

#pragma mark MKOverlay protocol

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, readonly) MKMapRect boundingMapRect;
//- (BOOL)intersectsMapRect:(MKMapRect)mapRect;
- (BOOL)canReplaceMapContent;

@end
