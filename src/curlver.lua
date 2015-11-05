


#define LIBCURL_COPYRIGHT "1996 - 2015 Daniel Stenberg, <daniel@haxx.se>."

/* This is the version number of the libcurl package from which this header
   file origins: */
#define LIBCURL_VERSION "7.46.0-DEV"


#define LIBCURL_VERSION_MAJOR 7
#define LIBCURL_VERSION_MINOR 46
#define LIBCURL_VERSION_PATCH 0


#define LIBCURL_VERSION_NUM 0x072E00


#define CURL_VERSION_BITS(x,y,z) ((x)<<16|(y)<<8|z)
#define CURL_AT_LEAST_VERSION(x,y,z) \
  (LIBCURL_VERSION_NUM >= CURL_VERSION_BITS(x, y, z))

