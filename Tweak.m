#import <CoreLocation/CoreLocation.h>

/* Log only on DEBUG builds */
#ifdef DEBUG
#define DebugLog(...) NSLog(@"[locationfaker] " __VA_ARGS__)
#else
#define DebugLog(...)
#endif

%hook CLLocation

CLLocationCoordinate2D location;

-(CLLocationCoordinate2D)coordinate {
    
    /* Open the configuration file */
    NSString *path = [@"/var/mobile/Library/Preferences" stringByAppendingPathComponent:[@"fun.tweaks.locationfaker" stringByAppendingPathExtension:@"plist"]];
    NSDictionary *conf = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    if (conf) {
        if ([conf objectForKey:@"Enabled"]) {
            if ([[conf objectForKey:@"Enabled"] boolValue] != TRUE) {
                DebugLog(@"Using actual location\n");
                return %orig;
            }
        }
        if (!([conf objectForKey:@"Latitude"] && [conf objectForKey:@"Longitude"])) {
            DebugLog(@"Missing Latitude/Longitude in configuration file %@\n", path);
        }
        else {
            location.latitude = [[conf objectForKey:@"Latitude"] doubleValue];
            location.longitude = [[conf objectForKey:@"Longitude"] doubleValue];
        }
    }
    else {
        DebugLog(@"Failed to open plist, creating %@\n", path);
        
        /* Use Apple's HQ as default location */
        conf = @{@"Latitude":[NSNumber numberWithDouble:37.3349],
                 @"Longitude":[NSNumber numberWithDouble:-122.0093]};
        [conf writeToFile:path atomically:YES];
        location.latitude = [[conf objectForKey:@"Latitude"] doubleValue];
        location.longitude = [[conf objectForKey:@"Longitude"] doubleValue];
    }
    
    [conf release];
    
    DebugLog(@"Using coordinates: %f, %f\n", location.latitude, location.longitude);
    
    return location;
}

%end
