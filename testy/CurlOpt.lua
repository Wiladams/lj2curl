
CINIT(WRITEDATA, OBJECTPOINT, 1),

CINIT(URL, OBJECTPOINT, 2),

CINIT(PORT, LONG, 3),

CINIT(PROXY, OBJECTPOINT, 4),

CINIT(USERPWD, OBJECTPOINT, 5),
CINIT(PROXYUSERPWD, OBJECTPOINT, 6),

CINIT(RANGE, OBJECTPOINT, 7),

CINIT(READDATA, OBJECTPOINT, 9),

CINIT(ERRORBUFFER, OBJECTPOINT, 10),

CINIT(WRITEFUNCTION, FUNCTIONPOINT, 11),

CINIT(READFUNCTION, FUNCTIONPOINT, 12),

CINIT(TIMEOUT, LONG, 13),

CINIT(INFILESIZE, LONG, 14),

CINIT(POSTFIELDS, OBJECTPOINT, 15),

CINIT(REFERER, OBJECTPOINT, 16),

CINIT(FTPPORT, OBJECTPOINT, 17),

CINIT(USERAGENT, OBJECTPOINT, 18),

CINIT(LOW_SPEED_LIMIT, LONG, 19),

CINIT(LOW_SPEED_TIME, LONG, 20),

CINIT(RESUME_FROM, LONG, 21),

CINIT(COOKIE, OBJECTPOINT, 22),

CINIT(HTTPHEADER, OBJECTPOINT, 23),

CINIT(HTTPPOST, OBJECTPOINT, 24),

CINIT(SSLCERT, OBJECTPOINT, 25),

CINIT(KEYPASSWD, OBJECTPOINT, 26),

CINIT(CRLF, LONG, 27),

CINIT(QUOTE, OBJECTPOINT, 28),

CINIT(HEADERDATA, OBJECTPOINT, 29),

CINIT(COOKIEFILE, OBJECTPOINT, 31),

CINIT(SSLVERSION, LONG, 32),

CINIT(TIMECONDITION, LONG, 33),

CINIT(TIMEVALUE, LONG, 34),

  -- 35 = OBSOLETE

CINIT(CUSTOMREQUEST, OBJECTPOINT, 36),

CINIT(STDERR, OBJECTPOINT, 37),

  -- 38 is not used

CINIT(POSTQUOTE, OBJECTPOINT, 39),

CINIT(OBSOLETE40, OBJECTPOINT, 40), /* OBSOLETE, do not use! */

CINIT(VERBOSE, LONG, 41),      /* talk a lot */
CINIT(HEADER, LONG, 42),       /* throw the header out too */
CINIT(NOPROGRESS, LONG, 43),   /* shut off the progress meter */
CINIT(NOBODY, LONG, 44),       /* use HEAD to get http document */
CINIT(FAILONERROR, LONG, 45),  /* no output on http error codes >= 400 */
CINIT(UPLOAD, LONG, 46),       /* this is an upload */
CINIT(POST, LONG, 47),         /* HTTP POST method */
CINIT(DIRLISTONLY, LONG, 48),  /* bare names when listing directories */

CINIT(APPEND, LONG, 50),       /* Append instead of overwrite on upload! */

CINIT(NETRC, LONG, 51),

CINIT(FOLLOWLOCATION, LONG, 52),  /* use Location: Luke! */

CINIT(TRANSFERTEXT, LONG, 53), /* transfer data in text/ASCII format */
CINIT(PUT, LONG, 54),          /* HTTP PUT */

  -- 55 = OBSOLETE 

  /* DEPRECATED
   * Function that will be called instead of the internal progress display
   * function. This function should be defined as the curl_progress_callback
   * prototype defines. */
CINIT(PROGRESSFUNCTION, FUNCTIONPOINT, 56),

  /* Data passed to the CURLOPT_PROGRESSFUNCTION and CURLOPT_XFERINFOFUNCTION
     callbacks */
CINIT(PROGRESSDATA, OBJECTPOINT, 57),
CURLOPT_XFERINFODATA CURLOPT_PROGRESSDATA

  /* We want the referrer field set automatically when following locations */
CINIT(AUTOREFERER, LONG, 58),

  /* Port of the proxy, can be set in the proxy string as well with:
     "[host]:[port]" */
CINIT(PROXYPORT, LONG, 59),

  /* size of the POST input data, if strlen() is not good to use */
CINIT(POSTFIELDSIZE, LONG, 60),

  /* tunnel non-http operations through a HTTP proxy */
CINIT(HTTPPROXYTUNNEL, LONG, 61),

  /* Set the interface string to use as outgoing network interface */
CINIT(INTERFACE, OBJECTPOINT, 62),

  /* Set the krb4/5 security level, this also enables krb4/5 awareness.  This
   * is a string, 'clear', 'safe', 'confidential' or 'private'.  If the string
   * is set but doesn't match one of these, 'private' will be used.  */
CINIT(KRBLEVEL, OBJECTPOINT, 63),

  /* Set if we should verify the peer in ssl handshake, set 1 to verify. */
CINIT(SSL_VERIFYPEER, LONG, 64),

  /* The CApath or CAfile used to validate the peer certificate
     this option is used only if SSL_VERIFYPEER is true */
CINIT(CAINFO, OBJECTPOINT, 65),

  /* 66 = OBSOLETE */
  /* 67 = OBSOLETE */

  /* Maximum number of http redirects to follow */
CINIT(MAXREDIRS, LONG, 68),

  /* Pass a long set to 1 to get the date of the requested document (if
     possible)! Pass a zero to shut it off. */
CINIT(FILETIME, LONG, 69),

  /* This points to a linked list of telnet options */
CINIT(TELNETOPTIONS, OBJECTPOINT, 70),

  /* Max amount of cached alive connections */
CINIT(MAXCONNECTS, LONG, 71),

CINIT(OBSOLETE72, LONG, 72), /* OBSOLETE, do not use! */

  /* 73 = OBSOLETE */

  /* Set to explicitly use a new connection for the upcoming transfer.
     Do not use this unless you're absolutely sure of this, as it makes the
     operation slower and is less friendly for the network. */
CINIT(FRESH_CONNECT, LONG, 74),

  /* Set to explicitly forbid the upcoming transfer's connection to be re-used
     when done. Do not use this unless you're absolutely sure of this, as it
     makes the operation slower and is less friendly for the network. */
CINIT(FORBID_REUSE, LONG, 75),

  /* Set to a file name that contains random data for libcurl to use to
     seed the random engine when doing SSL connects. */
CINIT(RANDOM_FILE, OBJECTPOINT, 76),

  /* Set to the Entropy Gathering Daemon socket pathname */
CINIT(EGDSOCKET, OBJECTPOINT, 77),

  /* Time-out connect operations after this amount of seconds, if connects are
     OK within this time, then fine... This only aborts the connect phase. */
CINIT(CONNECTTIMEOUT, LONG, 78),

  /* Function that will be called to store headers (instead of fwrite). The
   * parameters will use fwrite() syntax, make sure to follow them. */
CINIT(HEADERFUNCTION, FUNCTIONPOINT, 79),

  /* Set this to force the HTTP request to get back to GET. Only really usable
     if POST, PUT or a custom request have been used first.
   */
CINIT(HTTPGET, LONG, 80),

  /* Set if we should verify the Common name from the peer certificate in ssl
   * handshake, set 1 to check existence, 2 to ensure that it matches the
   * provided hostname. */
CINIT(SSL_VERIFYHOST, LONG, 81),

  /* Specify which file name to write all known cookies in after completed
     operation. Set file name to "-" (dash) to make it go to stdout. */
CINIT(COOKIEJAR, OBJECTPOINT, 82),

  /* Specify which SSL ciphers to use */
CINIT(SSL_CIPHER_LIST, OBJECTPOINT, 83),

  /* Specify which HTTP version to use! This must be set to one of the
     CURL_HTTP_VERSION* enums set below. */
CINIT(HTTP_VERSION, LONG, 84),

  /* Specifically switch on or off the FTP engine's use of the EPSV command. By
     default, that one will always be attempted before the more traditional
     PASV command. */
CINIT(FTP_USE_EPSV, LONG, 85),

  /* type of the file keeping your SSL-certificate ("DER", "PEM", "ENG") */
CINIT(SSLCERTTYPE, OBJECTPOINT, 86),

  /* name of the file keeping your private SSL-key */
CINIT(SSLKEY, OBJECTPOINT, 87),

  /* type of the file keeping your private SSL-key ("DER", "PEM", "ENG") */
CINIT(SSLKEYTYPE, OBJECTPOINT, 88),

  /* crypto engine for the SSL-sub system */
CINIT(SSLENGINE, OBJECTPOINT, 89),

  /* set the crypto engine for the SSL-sub system as default
     the param has no meaning...
   */
CINIT(SSLENGINE_DEFAULT, LONG, 90),

  /* Non-zero value means to use the global dns cache */
CINIT(DNS_USE_GLOBAL_CACHE, LONG, 91), /* DEPRECATED, do not use! */

  /* DNS cache timeout */
CINIT(DNS_CACHE_TIMEOUT, LONG, 92),

  /* send linked-list of pre-transfer QUOTE commands */
CINIT(PREQUOTE, OBJECTPOINT, 93),

  /* set the debug function */
CINIT(DEBUGFUNCTION, FUNCTIONPOINT, 94),

  /* set the data for the debug function */
CINIT(DEBUGDATA, OBJECTPOINT, 95),

  /* mark this as start of a cookie session */
CINIT(COOKIESESSION, LONG, 96),

  /* The CApath directory used to validate the peer certificate
     this option is used only if SSL_VERIFYPEER is true */
CINIT(CAPATH, OBJECTPOINT, 97),

  /* Instruct libcurl to use a smaller receive buffer */
CINIT(BUFFERSIZE, LONG, 98),

  /* Instruct libcurl to not use any signal/alarm handlers, even when using
     timeouts. This option is useful for multi-threaded applications.
     See libcurl-the-guide for more background information. */
CINIT(NOSIGNAL, LONG, 99),

  /* Provide a CURLShare for mutexing non-ts data */
CINIT(SHARE, OBJECTPOINT, 100),

  /* indicates type of proxy. accepted values are CURLPROXY_HTTP (default),
     CURLPROXY_SOCKS4, CURLPROXY_SOCKS4A and CURLPROXY_SOCKS5. */
CINIT(PROXYTYPE, LONG, 101),

  /* Set the Accept-Encoding string. Use this to tell a server you would like
     the response to be compressed. Before 7.21.6, this was known as
     CURLOPT_ENCODING */
CINIT(ACCEPT_ENCODING, OBJECTPOINT, 102),

  /* Set pointer to private data */
CINIT(PRIVATE, OBJECTPOINT, 103),

  /* Set aliases for HTTP 200 in the HTTP Response header */
CINIT(HTTP200ALIASES, OBJECTPOINT, 104),

  /* Continue to send authentication (user+password) when following locations,
     even when hostname changed. This can potentially send off the name
     and password to whatever host the server decides. */
CINIT(UNRESTRICTED_AUTH, LONG, 105),

CINIT(FTP_USE_EPRT, LONG, 106),

CINIT(HTTPAUTH, LONG, 107),


CINIT(SSL_CTX_FUNCTION, FUNCTIONPOINT, 108),


CINIT(SSL_CTX_DATA, OBJECTPOINT, 109),


CINIT(FTP_CREATE_MISSING_DIRS, LONG, 110),

CINIT(PROXYAUTH, LONG, 111),

CINIT(FTP_RESPONSE_TIMEOUT, LONG, 112),
CURLOPT_SERVER_RESPONSE_TIMEOUT CURLOPT_FTP_RESPONSE_TIMEOUT

CINIT(IPRESOLVE, LONG, 113),

CINIT(MAXFILESIZE, LONG, 114),

CINIT(INFILESIZE_LARGE, OFF_T, 115),

CINIT(RESUME_FROM_LARGE, OFF_T, 116),

CINIT(MAXFILESIZE_LARGE, OFF_T, 117),

CINIT(NETRC_FILE, OBJECTPOINT, 118),

CINIT(USE_SSL, LONG, 119),

CINIT(POSTFIELDSIZE_LARGE, OFF_T, 120),

CINIT(TCP_NODELAY, LONG, 121),

  -- 122 OBSOLETE, used in 7.12.3. Gone in 7.13.0
  -- 123 OBSOLETE. Gone in 7.16.0
  -- 124 OBSOLETE, used in 7.12.3. Gone in 7.13.0 
  -- 125 OBSOLETE, used in 7.12.3. Gone in 7.13.0 
  -- 126 OBSOLETE, used in 7.12.3. Gone in 7.13.0 
  -- 127 OBSOLETE. Gone in 7.16.0 
  -- 128 OBSOLETE. Gone in 7.16.0 


CINIT(FTPSSLAUTH, LONG, 129),

CINIT(IOCTLFUNCTION, FUNCTIONPOINT, 130),
CINIT(IOCTLDATA, OBJECTPOINT, 131),

  -- 132 OBSOLETE. Gone in 7.16.0 */
  -- 133 OBSOLETE. Gone in 7.16.0 */

CINIT(FTP_ACCOUNT, OBJECTPOINT, 134),

CINIT(COOKIELIST, OBJECTPOINT, 135),

CINIT(IGNORE_CONTENT_LENGTH, LONG, 136),

CINIT(FTP_SKIP_PASV_IP, LONG, 137),

CINIT(FTP_FILEMETHOD, LONG, 138),

CINIT(LOCALPORT, LONG, 139),

CINIT(LOCALPORTRANGE, LONG, 140),

CINIT(CONNECT_ONLY, LONG, 141),

CINIT(CONV_FROM_NETWORK_FUNCTION, FUNCTIONPOINT, 142),

CINIT(CONV_TO_NETWORK_FUNCTION, FUNCTIONPOINT, 143),

CINIT(CONV_FROM_UTF8_FUNCTION, FUNCTIONPOINT, 144),

CINIT(MAX_SEND_SPEED_LARGE, OFF_T, 145),
CINIT(MAX_RECV_SPEED_LARGE, OFF_T, 146),

CINIT(FTP_ALTERNATIVE_TO_USER, OBJECTPOINT, 147),

CINIT(SOCKOPTFUNCTION, FUNCTIONPOINT, 148),
CINIT(SOCKOPTDATA, OBJECTPOINT, 149),

CINIT(SSL_SESSIONID_CACHE, LONG, 150),

CINIT(SSH_AUTH_TYPES, LONG, 151),

CINIT(SSH_PUBLIC_KEYFILE, OBJECTPOINT, 152),
CINIT(SSH_PRIVATE_KEYFILE, OBJECTPOINT, 153),

CINIT(FTP_SSL_CCC, LONG, 154),

CINIT(TIMEOUT_MS, LONG, 155),
CINIT(CONNECTTIMEOUT_MS, LONG, 156),

CINIT(HTTP_TRANSFER_DECODING, LONG, 157),
CINIT(HTTP_CONTENT_DECODING, LONG, 158),

CINIT(NEW_FILE_PERMS, LONG, 159),
CINIT(NEW_DIRECTORY_PERMS, LONG, 160),

CINIT(POSTREDIR, LONG, 161),

CINIT(SSH_HOST_PUBLIC_KEY_MD5, OBJECTPOINT, 162),

CINIT(OPENSOCKETFUNCTION, FUNCTIONPOINT, 163),
CINIT(OPENSOCKETDATA, OBJECTPOINT, 164),

CINIT(COPYPOSTFIELDS, OBJECTPOINT, 165),

CINIT(PROXY_TRANSFER_MODE, LONG, 166),

CINIT(SEEKFUNCTION, FUNCTIONPOINT, 167),
CINIT(SEEKDATA, OBJECTPOINT, 168),

CINIT(CRLFILE, OBJECTPOINT, 169),

CINIT(ISSUERCERT, OBJECTPOINT, 170),

CINIT(ADDRESS_SCOPE, LONG, 171),

CINIT(CERTINFO, LONG, 172),

CINIT(USERNAME, OBJECTPOINT, 173),
CINIT(PASSWORD, OBJECTPOINT, 174),

CINIT(PROXYUSERNAME, OBJECTPOINT, 175),
CINIT(PROXYPASSWORD, OBJECTPOINT, 176),

CINIT(NOPROXY, OBJECTPOINT, 177),

CINIT(TFTP_BLKSIZE, LONG, 178),

CINIT(SOCKS5_GSSAPI_SERVICE, OBJECTPOINT, 179),

CINIT(SOCKS5_GSSAPI_NEC, LONG, 180),

CINIT(PROTOCOLS, LONG, 181),

CINIT(REDIR_PROTOCOLS, LONG, 182),

CINIT(SSH_KNOWNHOSTS, OBJECTPOINT, 183),

CINIT(SSH_KEYFUNCTION, FUNCTIONPOINT, 184),

CINIT(SSH_KEYDATA, OBJECTPOINT, 185),

CINIT(MAIL_FROM, OBJECTPOINT, 186),

CINIT(MAIL_RCPT, OBJECTPOINT, 187),

CINIT(FTP_USE_PRET, LONG, 188),

CINIT(RTSP_REQUEST, LONG, 189),

CINIT(RTSP_SESSION_ID, OBJECTPOINT, 190),

CINIT(RTSP_STREAM_URI, OBJECTPOINT, 191),

CINIT(RTSP_TRANSPORT, OBJECTPOINT, 192),

CINIT(RTSP_CLIENT_CSEQ, LONG, 193),

CINIT(RTSP_SERVER_CSEQ, LONG, 194),

CINIT(INTERLEAVEDATA, OBJECTPOINT, 195),

CINIT(INTERLEAVEFUNCTION, FUNCTIONPOINT, 196),

CINIT(WILDCARDMATCH, LONG, 197),

CINIT(CHUNK_BGN_FUNCTION, FUNCTIONPOINT, 198),

CINIT(CHUNK_END_FUNCTION, FUNCTIONPOINT, 199),

CINIT(FNMATCH_FUNCTION, FUNCTIONPOINT, 200),

CINIT(CHUNK_DATA, OBJECTPOINT, 201),

CINIT(FNMATCH_DATA, OBJECTPOINT, 202),

CINIT(RESOLVE, OBJECTPOINT, 203),

CINIT(TLSAUTH_USERNAME, OBJECTPOINT, 204),

CINIT(TLSAUTH_PASSWORD, OBJECTPOINT, 205),

CINIT(TLSAUTH_TYPE, OBJECTPOINT, 206),


CINIT(TRANSFER_ENCODING, LONG, 207),

CINIT(CLOSESOCKETFUNCTION, FUNCTIONPOINT, 208),
CINIT(CLOSESOCKETDATA, OBJECTPOINT, 209),

CINIT(GSSAPI_DELEGATION, LONG, 210),

CINIT(DNS_SERVERS, OBJECTPOINT, 211),

CINIT(ACCEPTTIMEOUT_MS, LONG, 212),

CINIT(TCP_KEEPALIVE, LONG, 213),

CINIT(TCP_KEEPIDLE, LONG, 214),
CINIT(TCP_KEEPINTVL, LONG, 215),

CINIT(SSL_OPTIONS, LONG, 216),

CINIT(MAIL_AUTH, OBJECTPOINT, 217),

CINIT(SASL_IR, LONG, 218),

CINIT(XFERINFOFUNCTION, FUNCTIONPOINT, 219),

CINIT(XOAUTH2_BEARER, OBJECTPOINT, 220),

CINIT(DNS_INTERFACE, OBJECTPOINT, 221),

CINIT(DNS_LOCAL_IP4, OBJECTPOINT, 222),

CINIT(DNS_LOCAL_IP6, OBJECTPOINT, 223),

CINIT(LOGIN_OPTIONS, OBJECTPOINT, 224),

CINIT(SSL_ENABLE_NPN, LONG, 225),

CINIT(SSL_ENABLE_ALPN, LONG, 226),

CINIT(EXPECT_100_TIMEOUT_MS, LONG, 227),

CINIT(PROXYHEADER, OBJECTPOINT, 228),

CINIT(HEADEROPT, LONG, 229),

CINIT(PINNEDPUBLICKEY, OBJECTPOINT, 230),

CINIT(UNIX_SOCKET_PATH, OBJECTPOINT, 231),

CINIT(SSL_VERIFYSTATUS, LONG, 232),

CINIT(SSL_FALSESTART, LONG, 233),

CINIT(PATH_AS_IS, LONG, 234),

CINIT(PROXY_SERVICE_NAME, OBJECTPOINT, 235),

CINIT(SERVICE_NAME, OBJECTPOINT, 236),

CINIT(PIPEWAIT, LONG, 237),

CINIT(DEFAULT_PROTOCOL, OBJECTPOINT, 238),

CINIT(STREAM_WEIGHT, LONG, 239),

CINIT(STREAM_DEPENDS, OBJECTPOINT, 240),

CINIT(STREAM_DEPENDS_E, OBJECTPOINT, 241),

  CURLOPT_LASTENTRY /* the last unused */