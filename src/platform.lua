local ffi = require("ffi")

ffi.cdef[[
typedef long ssize_t;


typedef uint64_t dev_t;
typedef uint32_t mode_t;

// networking
typedef uint32_t socket_t;
typedef unsigned short sa_family_t;
typedef unsigned int socklen_t;

]]



ffi.cdef[[
typedef long time_t;
typedef long suseconds_t;
]]


ffi.cdef[[
typedef uint16_t in_port_t;
typedef uint32_t in_addr_t;
]]

ffi.cdef[[
struct in_addr 
{ 
	in_addr_t s_addr; 
};
]]

ffi.cdef[[
struct sockaddr_in
{
	sa_family_t sin_family;
	in_port_t sin_port;
	struct in_addr sin_addr;
	uint8_t sin_zero[8];
};
]]

ffi.cdef[[
struct in6_addr
{
	union {
		uint8_t __s6_addr[16];
		uint16_t __s6_addr16[8];
		uint32_t __s6_addr32[4];
	} __in6_union;
};
]]

ffi.cdef[[
struct linger
{
	int l_onoff;
	int l_linger;
};

struct sockaddr
{
	sa_family_t sa_family;
	char sa_data[14];
};

struct sockaddr_storage
{
	sa_family_t ss_family;
	unsigned long __ss_align;
	char __ss_padding[128-2*sizeof(unsigned long)];
};
]]