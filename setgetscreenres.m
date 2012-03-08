/*
* setgetscreenres.m
* 
* juanfc 2009-04-13
* Based on newscreen
*    Created by Jeffrey Osterman on 10/30/07.
*    Copyright 2007 Jeffrey Osterman. All rights reserved. 
*    PROVIDED AS IS AND WITH NO WARRANTIES WHATSOEVER
*    http://forums.macosxhints.com/showthread.php?t=59575
*
* COMPILE:
*    c++ setgetscreenres.m -framework ApplicationServices -o setgetscreenres
* USE:
*    setgetscreenres 1440 900
*/

#include <ApplicationServices/ApplicationServices.h>

bool MyDisplaySwitchToMode (CGDirectDisplayID display, CFDictionaryRef mode);

int main (int argc, const char * argv[])
{
    int h;                          // horizontal resolution
    int v;                          // vertical resolution
    CFDictionaryRef switchMode;     // mode to switch to
    CGDirectDisplayID mainDisplay;  // ID of main display

    CFDictionaryRef CGDisplayCurrentMode(CGDirectDisplayID display);

    if (argc == 1) {
        CGRect screenFrame = CGDisplayBounds(kCGDirectMainDisplay);
        CGSize screenSize  = screenFrame.size;
        printf("%d %d\n", screenSize.width, screenSize.height);
        return 0;
    }
    if (argc != 3 || !(h = atoi(argv[1])) || !(v = atoi(argv[2])) ) {
        fprintf(stderr, "ERROR: Use %s horres vertres\n", argv[0]);
        return -1;
    }

    mainDisplay = CGMainDisplayID();

    switchMode = CGDisplayBestModeForParameters(mainDisplay, 32, h, v, NULL);

    if (! MyDisplaySwitchToMode(mainDisplay, switchMode)) {
        fprintf(stderr, "Error changing resolution to %d %d\n", h, v);
        return 1;
    }

    return 0;
}

bool MyDisplaySwitchToMode (CGDirectDisplayID display, CFDictionaryRef mode)
{
    CGDisplayConfigRef config;
    if (CGBeginDisplayConfiguration(&config) == kCGErrorSuccess) {
        CGConfigureDisplayMode(config, display, mode);
        CGCompleteDisplayConfiguration(config, kCGConfigureForSession );
        return true;
    }
    return false;
}
