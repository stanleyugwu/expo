//
//  ABI44_0_0AIRMapLocalTile.m
//  AirMaps
//
//  Created by Peter Zavadsky on 01/12/2017.
//  Copyright © 2017 Christopher. All rights reserved.
//

#import "ABI44_0_0AIRMapLocalTile.h"
#import <ABI44_0_0React/ABI44_0_0UIView+React.h>
#import "ABI44_0_0AIRMapLocalTileOverlay.h"

@implementation ABI44_0_0AIRMapLocalTile {
    BOOL _pathTemplateSet;
    BOOL _tileSizeSet;
}


- (void)setPathTemplate:(NSString *)pathTemplate{
    _pathTemplate = pathTemplate;
    _pathTemplateSet = YES;
    [self createTileOverlayAndRendererIfPossible];
    [self update];
}

- (void)setTileSize:(CGFloat)tileSize{
    _tileSize = tileSize;
    _tileSizeSet = YES;
    [self createTileOverlayAndRendererIfPossible];
    [self update];
}

- (void) createTileOverlayAndRendererIfPossible
{
    if (!_pathTemplateSet || !_tileSizeSet) return;
    self.tileOverlay = [[ABI44_0_0AIRMapLocalTileOverlay alloc] initWithURLTemplate:self.pathTemplate];
    self.tileOverlay.canReplaceMapContent = YES;
    self.tileOverlay.tileSize = CGSizeMake(_tileSize, _tileSize);
    self.renderer = [[MKTileOverlayRenderer alloc] initWithTileOverlay:self.tileOverlay];
}

- (void) update
{
    if (!_renderer) return;
    
    if (_map == nil) return;
    [_map removeOverlay:self];
    [_map addOverlay:self level:MKOverlayLevelAboveLabels];
}

#pragma mark MKOverlay implementation

- (CLLocationCoordinate2D) coordinate
{
    return self.tileOverlay.coordinate;
}

- (MKMapRect) boundingMapRect
{
    return self.tileOverlay.boundingMapRect;
}

- (BOOL)canReplaceMapContent
{
    return self.tileOverlay.canReplaceMapContent;
}

@end
