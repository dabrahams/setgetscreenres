# setgetscreenres

This is some code for querying/changing MacOS screen resolution that I
found in multiple versions around the web.  It seemed useful, and as
though it ought to be rescued, so I put it in a proper repository and
tried to reconstruct its revision history. 

## Support/Maintenance

I am not supporting or maintaining this code, but if you find a
compelling improvement, I might be inclined to accept your pull
request ;-)

## Building

This produces lots of warnings, but seems to work for me.

```sh
c++ setgetscreenres.m -framework ApplicationServices -o ~/bin/setgetscreenres -arch i386
```

## Enjoy!

—Dave
