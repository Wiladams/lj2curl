return {	
	WRITEDATA                 = {'OBJECTPOINT', 1},
	URL                       = {'OBJECTPOINT', 2},
	PORT                      = {'LONG', 3},
	PROXY                     = {'OBJECTPOINT', 4},
	USERPWD                   = {'OBJECTPOINT', 5},
	PROXYUSERPWD              = {'OBJECTPOINT', 6},
	RANGE                     = {'OBJECTPOINT', 7},
	READDATA                  = {'OBJECTPOINT', 9},
	ERRORBUFFER               = {'OBJECTPOINT', 10},
	WRITEFUNCTION             = {'FUNCTIONPOINT', 11},
	READFUNCTION              = {'FUNCTIONPOINT', 12},
	TIMEOUT                   = {'LONG', 13},
	INFILESIZE                = {'LONG', 14},
	POSTFIELDS                = {'OBJECTPOINT', 15},
	REFERER                   = {'OBJECTPOINT', 16},
	FTPPORT                   = {'OBJECTPOINT', 17},
	USERAGENT                 = {'OBJECTPOINT', 18},
	LOW_SPEED_LIMIT           = {'LONG', 19},
	LOW_SPEED_TIME            = {'LONG', 20},
	RESUME_FROM               = {'LONG', 21},
	COOKIE                    = {'OBJECTPOINT', 22},
	HTTPHEADER                = {'OBJECTPOINT', 23},
	HTTPPOST                  = {'OBJECTPOINT', 24},
	SSLCERT                   = {'OBJECTPOINT', 25},
	KEYPASSWD                 = {'OBJECTPOINT', 26},
	CRLF                      = {'LONG', 27},
	QUOTE                     = {'OBJECTPOINT', 28},
	HEADERDATA                = {'OBJECTPOINT', 29},
	COOKIEFILE                = {'OBJECTPOINT', 31},
	SSLVERSION                = {'LONG', 32},
	TIMECONDITION             = {'LONG', 33},
	TIMEVALUE                 = {'LONG', 34},
	CUSTOMREQUEST             = {'OBJECTPOINT', 36},
	STDERR                    = {'OBJECTPOINT', 37},
	POSTQUOTE                 = {'OBJECTPOINT', 39},
	OBSOLETE40                = {'OBJECTPOINT', 40},
	VERBOSE                   = {'LONG', 41},
	HEADER                    = {'LONG', 42},
	NOPROGRESS                = {'LONG', 43},
	NOBODY                    = {'LONG', 44},
	FAILONERROR               = {'LONG', 45},
	UPLOAD                    = {'LONG', 46},
	POST                      = {'LONG', 47},
	DIRLISTONLY               = {'LONG', 48},
	APPEND                    = {'LONG', 50},
	NETRC                     = {'LONG', 51},
	FOLLOWLOCATION            = {'LONG', 52},
	TRANSFERTEXT              = {'LONG', 53},
	PUT                       = {'LONG', 54},
	PROGRESSFUNCTION          = {'FUNCTIONPOINT', 56},
	PROGRESSDATA              = {'OBJECTPOINT', 57},
	AUTOREFERER               = {'LONG', 58},
	PROXYPORT                 = {'LONG', 59},
	POSTFIELDSIZE             = {'LONG', 60},
	HTTPPROXYTUNNEL           = {'LONG', 61},
	INTERFACE                 = {'OBJECTPOINT', 62},
	KRBLEVEL                  = {'OBJECTPOINT', 63},
	SSL_VERIFYPEER            = {'LONG', 64},
	CAINFO                    = {'OBJECTPOINT', 65},
	MAXREDIRS                 = {'LONG', 68},
	FILETIME                  = {'LONG', 69},
	TELNETOPTIONS             = {'OBJECTPOINT', 70},
	MAXCONNECTS               = {'LONG', 71},
	OBSOLETE72                = {'LONG', 72},
	FRESH_CONNECT             = {'LONG', 74},
	FORBID_REUSE              = {'LONG', 75},
	RANDOM_FILE               = {'OBJECTPOINT', 76},
	EGDSOCKET                 = {'OBJECTPOINT', 77},
	CONNECTTIMEOUT            = {'LONG', 78},
	HEADERFUNCTION            = {'FUNCTIONPOINT', 79},
	HTTPGET                   = {'LONG', 80},
	SSL_VERIFYHOST            = {'LONG', 81},
	COOKIEJAR                 = {'OBJECTPOINT', 82},
	SSL_CIPHER_LIST           = {'OBJECTPOINT', 83},
	HTTP_VERSION              = {'LONG', 84},
	FTP_USE_EPSV              = {'LONG', 85},
	SSLCERTTYPE               = {'OBJECTPOINT', 86},
	SSLKEY                    = {'OBJECTPOINT', 87},
	SSLKEYTYPE                = {'OBJECTPOINT', 88},
	SSLENGINE                 = {'OBJECTPOINT', 89},
	SSLENGINE_DEFAULT         = {'LONG', 90},
	DNS_USE_GLOBAL_CACHE      = {'LONG', 91},
	DNS_CACHE_TIMEOUT         = {'LONG', 92},
	PREQUOTE                  = {'OBJECTPOINT', 93},
	DEBUGFUNCTION             = {'FUNCTIONPOINT', 94},
	DEBUGDATA                 = {'OBJECTPOINT', 95},
	COOKIESESSION             = {'LONG', 96},
	CAPATH                    = {'OBJECTPOINT', 97},
	BUFFERSIZE                = {'LONG', 98},
	NOSIGNAL                  = {'LONG', 99},
	SHARE                     = {'OBJECTPOINT', 100},
	PROXYTYPE                 = {'LONG', 101},
	ACCEPT_ENCODING           = {'OBJECTPOINT', 102},
	PRIVATE                   = {'OBJECTPOINT', 103},
	HTTP200ALIASES            = {'OBJECTPOINT', 104},
	UNRESTRICTED_AUTH         = {'LONG', 105},
	FTP_USE_EPRT              = {'LONG', 106},
	HTTPAUTH                  = {'LONG', 107},
	SSL_CTX_FUNCTION          = {'FUNCTIONPOINT', 108},
	SSL_CTX_DATA              = {'OBJECTPOINT', 109},
	FTP_CREATE_MISSING_DIRS   = {'LONG', 110},
	PROXYAUTH                 = {'LONG', 111},
	FTP_RESPONSE_TIMEOUT      = {'LONG', 112},
	IPRESOLVE                 = {'LONG', 113},
	MAXFILESIZE               = {'LONG', 114},
	INFILESIZE_LARGE          = {'OFF_T', 115},
	RESUME_FROM_LARGE         = {'OFF_T', 116},
	MAXFILESIZE_LARGE         = {'OFF_T', 117},
	NETRC_FILE                = {'OBJECTPOINT', 118},
	USE_SSL                   = {'LONG', 119},
	POSTFIELDSIZE_LARGE       = {'OFF_T', 120},
	TCP_NODELAY               = {'LONG', 121},
	FTPSSLAUTH                = {'LONG', 129},
	IOCTLFUNCTION             = {'FUNCTIONPOINT', 130},
	IOCTLDATA                 = {'OBJECTPOINT', 131},
	FTP_ACCOUNT               = {'OBJECTPOINT', 134},
	COOKIELIST                = {'OBJECTPOINT', 135},
	IGNORE_CONTENT_LENGTH     = {'LONG', 136},
	FTP_SKIP_PASV_IP          = {'LONG', 137},
	FTP_FILEMETHOD            = {'LONG', 138},
	LOCALPORT                 = {'LONG', 139},
	LOCALPORTRANGE            = {'LONG', 140},
	CONNECT_ONLY              = {'LONG', 141},
	CONV_FROM_NETWORK_FUNCTION = {'FUNCTIONPOINT', 142},
	CONV_TO_NETWORK_FUNCTION  = {'FUNCTIONPOINT', 143},
	CONV_FROM_UTF8_FUNCTION   = {'FUNCTIONPOINT', 144},
	MAX_SEND_SPEED_LARGE      = {'OFF_T', 145},
	MAX_RECV_SPEED_LARGE      = {'OFF_T', 146},
	FTP_ALTERNATIVE_TO_USER   = {'OBJECTPOINT', 147},
	SOCKOPTFUNCTION           = {'FUNCTIONPOINT', 148},
	SOCKOPTDATA               = {'OBJECTPOINT', 149},
	SSL_SESSIONID_CACHE       = {'LONG', 150},
	SSH_AUTH_TYPES            = {'LONG', 151},
	SSH_PUBLIC_KEYFILE        = {'OBJECTPOINT', 152},
	SSH_PRIVATE_KEYFILE       = {'OBJECTPOINT', 153},
	FTP_SSL_CCC               = {'LONG', 154},
	TIMEOUT_MS                = {'LONG', 155},
	CONNECTTIMEOUT_MS         = {'LONG', 156},
	HTTP_TRANSFER_DECODING    = {'LONG', 157},
	HTTP_CONTENT_DECODING     = {'LONG', 158},
	NEW_FILE_PERMS            = {'LONG', 159},
	NEW_DIRECTORY_PERMS       = {'LONG', 160},
	POSTREDIR                 = {'LONG', 161},
	SSH_HOST_PUBLIC_KEY_MD5   = {'OBJECTPOINT', 162},
	OPENSOCKETFUNCTION        = {'FUNCTIONPOINT', 163},
	OPENSOCKETDATA            = {'OBJECTPOINT', 164},
	COPYPOSTFIELDS            = {'OBJECTPOINT', 165},
	PROXY_TRANSFER_MODE       = {'LONG', 166},
	SEEKFUNCTION              = {'FUNCTIONPOINT', 167},
	SEEKDATA                  = {'OBJECTPOINT', 168},
	CRLFILE                   = {'OBJECTPOINT', 169},
	ISSUERCERT                = {'OBJECTPOINT', 170},
	ADDRESS_SCOPE             = {'LONG', 171},
	CERTINFO                  = {'LONG', 172},
	USERNAME                  = {'OBJECTPOINT', 173},
	PASSWORD                  = {'OBJECTPOINT', 174},
	PROXYUSERNAME             = {'OBJECTPOINT', 175},
	PROXYPASSWORD             = {'OBJECTPOINT', 176},
	NOPROXY                   = {'OBJECTPOINT', 177},
	TFTP_BLKSIZE              = {'LONG', 178},
	SOCKS5_GSSAPI_SERVICE     = {'OBJECTPOINT', 179},
	SOCKS5_GSSAPI_NEC         = {'LONG', 180},
	PROTOCOLS                 = {'LONG', 181},
	REDIR_PROTOCOLS           = {'LONG', 182},
	SSH_KNOWNHOSTS            = {'OBJECTPOINT', 183},
	SSH_KEYFUNCTION           = {'FUNCTIONPOINT', 184},
	SSH_KEYDATA               = {'OBJECTPOINT', 185},
	MAIL_FROM                 = {'OBJECTPOINT', 186},
	MAIL_RCPT                 = {'OBJECTPOINT', 187},
	FTP_USE_PRET              = {'LONG', 188},
	RTSP_REQUEST              = {'LONG', 189},
	RTSP_SESSION_ID           = {'OBJECTPOINT', 190},
	RTSP_STREAM_URI           = {'OBJECTPOINT', 191},
	RTSP_TRANSPORT            = {'OBJECTPOINT', 192},
	RTSP_CLIENT_CSEQ          = {'LONG', 193},
	RTSP_SERVER_CSEQ          = {'LONG', 194},
	INTERLEAVEDATA            = {'OBJECTPOINT', 195},
	INTERLEAVEFUNCTION        = {'FUNCTIONPOINT', 196},
	WILDCARDMATCH             = {'LONG', 197},
	CHUNK_BGN_FUNCTION        = {'FUNCTIONPOINT', 198},
	CHUNK_END_FUNCTION        = {'FUNCTIONPOINT', 199},
	FNMATCH_FUNCTION          = {'FUNCTIONPOINT', 200},
	CHUNK_DATA                = {'OBJECTPOINT', 201},
	FNMATCH_DATA              = {'OBJECTPOINT', 202},
	RESOLVE                   = {'OBJECTPOINT', 203},
	TLSAUTH_USERNAME          = {'OBJECTPOINT', 204},
	TLSAUTH_PASSWORD          = {'OBJECTPOINT', 205},
	TLSAUTH_TYPE              = {'OBJECTPOINT', 206},
	TRANSFER_ENCODING         = {'LONG', 207},
	CLOSESOCKETFUNCTION       = {'FUNCTIONPOINT', 208},
	CLOSESOCKETDATA           = {'OBJECTPOINT', 209},
	GSSAPI_DELEGATION         = {'LONG', 210},
	DNS_SERVERS               = {'OBJECTPOINT', 211},
	ACCEPTTIMEOUT_MS          = {'LONG', 212},
	TCP_KEEPALIVE             = {'LONG', 213},
	TCP_KEEPIDLE              = {'LONG', 214},
	TCP_KEEPINTVL             = {'LONG', 215},
	SSL_OPTIONS               = {'LONG', 216},
	MAIL_AUTH                 = {'OBJECTPOINT', 217},
	SASL_IR                   = {'LONG', 218},
	XFERINFOFUNCTION          = {'FUNCTIONPOINT', 219},
	XOAUTH2_BEARER            = {'OBJECTPOINT', 220},
	DNS_INTERFACE             = {'OBJECTPOINT', 221},
	DNS_LOCAL_IP4             = {'OBJECTPOINT', 222},
	DNS_LOCAL_IP6             = {'OBJECTPOINT', 223},
	LOGIN_OPTIONS             = {'OBJECTPOINT', 224},
	SSL_ENABLE_NPN            = {'LONG', 225},
	SSL_ENABLE_ALPN           = {'LONG', 226},
	EXPECT_100_TIMEOUT_MS     = {'LONG', 227},
	PROXYHEADER               = {'OBJECTPOINT', 228},
	HEADEROPT                 = {'LONG', 229},
	PINNEDPUBLICKEY           = {'OBJECTPOINT', 230},
	UNIX_SOCKET_PATH          = {'OBJECTPOINT', 231},
	SSL_VERIFYSTATUS          = {'LONG', 232},
	SSL_FALSESTART            = {'LONG', 233},
	PATH_AS_IS                = {'LONG', 234},
	PROXY_SERVICE_NAME        = {'OBJECTPOINT', 235},
	SERVICE_NAME              = {'OBJECTPOINT', 236},
	PIPEWAIT                  = {'LONG', 237},
	DEFAULT_PROTOCOL          = {'OBJECTPOINT', 238},
	STREAM_WEIGHT             = {'LONG', 239},
	STREAM_DEPENDS            = {'OBJECTPOINT', 240},
	STREAM_DEPENDS_E          = {'OBJECTPOINT', 241},
}