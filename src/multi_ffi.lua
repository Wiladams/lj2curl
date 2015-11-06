
local ffi = require("ffi")


ffi.cdef[[
typedef void CURLM;

typedef enum {
  CURLM_CALL_MULTI_PERFORM = -1, /* please call curl_multi_perform() or
                                    curl_multi_socket*() soon */
  CURLM_OK,
  CURLM_BAD_HANDLE,      /* the passed-in handle is not a valid CURLM handle */
  CURLM_BAD_EASY_HANDLE, /* an easy handle was not good/valid */
  CURLM_OUT_OF_MEMORY,   /* if you ever get this, you're in deep sh*t */
  CURLM_INTERNAL_ERROR,  /* this is a libcurl bug */
  CURLM_BAD_SOCKET,      /* the passed in socket argument did not match */
  CURLM_UNKNOWN_OPTION,  /* curl_multi_setopt() with unsupported option */
  CURLM_ADDED_ALREADY,   /* an easy handle already added to a multi handle was
                            attempted to get added - again */
  CURLM_LAST
} CURLMcode;
]]

/* just to make code nicer when using curl_multi_socket() you can now check
   for CURLM_CALL_MULTI_SOCKET too in the same style it works for
   curl_multi_perform() and CURLM_CALL_MULTI_PERFORM */
#define CURLM_CALL_MULTI_SOCKET CURLM_CALL_MULTI_PERFORM

/* bitmask bits for CURLMOPT_PIPELINING */
#define CURLPIPE_NOTHING   0L
#define CURLPIPE_HTTP1     1L
#define CURLPIPE_MULTIPLEX 2L

ffi.cdef[[
typedef enum {
  CURLMSG_NONE, /* first, not used */
  CURLMSG_DONE, /* This easy handle has completed. 'result' contains
                   the CURLcode of the transfer */
  CURLMSG_LAST /* last, not used */
} CURLMSG;

struct CURLMsg {
  CURLMSG msg;       /* what this message means */
  CURL *easy_handle; /* the handle it concerns */
  union {
    void *whatever;    /* message-specific data */
    CURLcode result;   /* return code for transfer */
  } data;
};
typedef struct CURLMsg CURLMsg;
]]

ffi.cdef[[
/* Based on poll(2) structure and values.
 * We don't use pollfd and POLL* constants explicitly
 * to cover platforms without poll(). */
static const int CURL_WAIT_POLLIN    0x0001
static const int CURL_WAIT_POLLPRI   0x0002
static const int CURL_WAIT_POLLOUT   0x0004


struct curl_waitfd {
  curl_socket_t fd;
  short events;
  short revents; /* not supported yet */
};
]]

ffi.cdef[[

CURL_EXTERN CURLM *curl_multi_init(void);


CURL_EXTERN CURLMcode curl_multi_add_handle(CURLM *multi_handle,
                                            CURL *curl_handle);


CURL_EXTERN CURLMcode curl_multi_remove_handle(CURLM *multi_handle,
                                               CURL *curl_handle);


CURL_EXTERN CURLMcode curl_multi_fdset(CURLM *multi_handle,
                                       fd_set *read_fd_set,
                                       fd_set *write_fd_set,
                                       fd_set *exc_fd_set,
                                       int *max_fd);


CURL_EXTERN CURLMcode curl_multi_wait(CURLM *multi_handle,
                                      struct curl_waitfd extra_fds[],
                                      unsigned int extra_nfds,
                                      int timeout_ms,
                                      int *ret);

CURL_EXTERN CURLMcode curl_multi_perform(CURLM *multi_handle,
                                         int *running_handles);


CURL_EXTERN CURLMcode curl_multi_cleanup(CURLM *multi_handle);


CURL_EXTERN CURLMsg *curl_multi_info_read(CURLM *multi_handle,
                                          int *msgs_in_queue);


CURL_EXTERN const char *curl_multi_strerror(CURLMcode);
]]

ffi.cdef[[
static const int CURL_POLL_NONE   = 0;
static const int CURL_POLL_IN     = 1;
static const int CURL_POLL_OUT    = 2;
static const int CURL_POLL_INOUT  = 3;
static const int CURL_POLL_REMOVE = 4;

static const int CURL_SOCKET_TIMEOUT = CURL_SOCKET_BAD;

static const int CURL_CSELECT_IN   = 0x01;
static const int CURL_CSELECT_OUT  = 0x02;
static const int CURL_CSELECT_ERR  = 0x04;
]]

ffi.cdef[[
typedef int (*curl_socket_callback)(CURL *easy,      /* easy handle */
                                    curl_socket_t s, /* socket */
                                    int what,        /* see above */
                                    void *userp,     /* private callback
                                                        pointer */
                                    void *socketp);  /* private socket
                                                        pointer */

typedef int (*curl_multi_timer_callback)(CURLM *multi,    /* multi handle */
                                         long timeout_ms, /* see above */
                                         void *userp);    /* private callback
                                                             pointer */

CURL_EXTERN CURLMcode curl_multi_socket(CURLM *multi_handle, curl_socket_t s,
                                        int *running_handles);

CURL_EXTERN CURLMcode curl_multi_socket_action(CURLM *multi_handle,
                                               curl_socket_t s,
                                               int ev_bitmask,
                                               int *running_handles);

CURL_EXTERN CURLMcode curl_multi_socket_all(CURLM *multi_handle,
                                            int *running_handles);
]]


ffi.cdef[[

CURL_EXTERN CURLMcode curl_multi_timeout(CURLM *multi_handle,
                                         long *milliseconds);
]]


ffi.cdef[[
typedef enum {
  CURLMOPT_PUSHDATA = CURLOPTTYPE_OBJECTPOINT+15,
  CURLMOPT_TIMERFUNCTION = CURLOPTTYPE_FUNCTIONPOINT+4,
  CURLMOPT_CHUNK_LENGTH_PENALTY_SIZE = CURLOPTTYPE_OFF_T+10,
  CURLMOPT_PUSHFUNCTION = CURLOPTTYPE_FUNCTIONPOINT+14,
  CURLMOPT_TIMERDATA = CURLOPTTYPE_OBJECTPOINT+5,
  CURLMOPT_SOCKETDATA = CURLOPTTYPE_OBJECTPOINT+2,
  CURLMOPT_MAX_TOTAL_CONNECTIONS = CURLOPTTYPE_LONG+13,
  CURLMOPT_SOCKETFUNCTION = CURLOPTTYPE_FUNCTIONPOINT+1,
  CURLMOPT_PIPELINING_SERVER_BL = CURLOPTTYPE_OBJECTPOINT+12,
  CURLMOPT_MAX_HOST_CONNECTIONS = CURLOPTTYPE_LONG+7,
  CURLMOPT_MAX_PIPELINE_LENGTH = CURLOPTTYPE_LONG+8,
  CURLMOPT_PIPELINING = CURLOPTTYPE_LONG+3,
  CURLMOPT_CONTENT_LENGTH_PENALTY_SIZE = CURLOPTTYPE_OFF_T+9,
  CURLMOPT_PIPELINING_SITE_BL = CURLOPTTYPE_OBJECTPOINT+11,
  CURLMOPT_MAXCONNECTS = CURLOPTTYPE_LONG+6,

  CURLMOPT_LASTENTRY /* the last unused */
} CURLMoption;]]



ffi.cdef[[

CURL_EXTERN CURLMcode curl_multi_setopt(CURLM *multi_handle,
                                        CURLMoption option, ...);



CURL_EXTERN CURLMcode curl_multi_assign(CURLM *multi_handle,
                                        curl_socket_t sockfd, void *sockp);
]]

ffi.cdef[[

static const int CURL_PUSH_OK   = 0;
static const int CURL_PUSH_DENY = 1;

struct curl_pushheaders;  /* forward declaration only */

CURL_EXTERN char *curl_pushheader_bynum(struct curl_pushheaders *h,
                                        size_t num);
CURL_EXTERN char *curl_pushheader_byname(struct curl_pushheaders *h,
                                         const char *name);

typedef int (*curl_push_callback)(CURL *parent,
                                  CURL *easy,
                                  size_t num_headers,
                                  struct curl_pushheaders *headers,
                                  void *userp);
]]

