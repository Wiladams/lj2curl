local ffi = require("ffi")

ffi.cdef[[
CURL *curl_easy_init(void);
CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...);
CURLcode curl_easy_perform(CURL *curl);
void curl_easy_cleanup(CURL *curl);


CURLcode curl_easy_getinfo(CURL *curl, CURLINFO info, ...);

CURL* curl_easy_duphandle(CURL *curl);

void curl_easy_reset(CURL *curl);

CURLcode curl_easy_recv(CURL *curl, void *buffer, size_t buflen,
                                    size_t *n);

CURLcode curl_easy_send(CURL *curl, const void *buffer,
                                    size_t buflen, size_t *n);
]]
