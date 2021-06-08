/*
    === NOTICE ===
    These bindings are meant to be as 1-1 with winsock.h as possible.
    Because of this, nonstandard types have been defined (u_char, UINT_PTR, etc.)
    and are used in the same places.
*/

#import "Windows";

// === Private utilities, types, macros, etc. ===
#scope_file
c :: #import "C";

u_char  :: c.unsigned_char;
u_short :: c.unsigned_short;
u_int   :: c.unsigned_int;
u_long  :: c.unsigned_long;

WORD     :: c.unsigned_short;
BYTE     :: c.unsigned_char;
UINT_PTR :: SOCKET;

// Converted macros
_IO      :: (x: $T, y: T) -> T           { return (IOC_VOID | (x << 8) | y);                                                   }
_IOR     :: (x: $T, y: T, $t: Type) -> T { return (IOC_OUT  | ((cast(c.long)size_of(t) & IOCPARM_MASK) << 16 | (x << 8) | y)); }
_IOW     :: (x: $T, y: T, $t: Type) -> T { return (IOC_IN   | ((cast(c.long)size_of(t) & IOCPARM_MASK) << 16 | (x << 8) | y)); }


// === Public API ===
#scope_export

WINSOCK_VERSION : WORD : 2 | (2 << 8);

// Defines
SOCKET :: u64;
INVALID_SOCKET : SOCKET : ~0;
SOCKET_ERROR   :: -1;

SOCKADDR    :: sockaddr;
SOCKADDR_IN :: sockaddr_in;
LINGER      :: linger;
FD_SET      :: fd_set;
HOSTENT     :: hostent;
SERVENT     :: servent;
PROTOENT    :: protoent;
TIMEVAL     :: timeval;

FD_SETSIZE :: 64;

IOCPARM_MASK :: 0x7f;
IOC_VOID     :: 0x20000000;
IOC_OUT      :: 0x40000000;
IOC_IN       :: 0x80000000;
IOC_INOUT    :: IOC_IN | IOC_OUT;

FIONREAD :: #run _IOR(#char "f", 127, u_long);
FIONBIO  :: #run _IOW(#char "f", 126, u_long);
FIOASYNC :: #run _IOW(#char "f", 125, u_long);

SIOCSHIWAT :: #run _IOW(#char "s", 0, u_long);
SIOCGHIWAT :: #run _IOR(#char "s", 1, u_long);
SIOCSLOWAT :: #run _IOW(#char "s", 2, u_long);
SIOCGLOWAT :: #run _IOR(#char "s", 3, u_long);
SIOCATMARK :: #run _IOR(#char "s", 7, u_long);

IPPROTO_IP   :: 0;
IPPROTO_ICMP :: 1;
IPPROTO_IGMP :: 2;
IPPROTO_GGP  :: 3;
IPPROTO_TCP  :: 6;
IPPROTO_PUP  :: 12;
IPPROTO_UDP  :: 17;
IPPROTO_IDP  :: 22;
IPPROTO_ND   :: 77;
IPPROTO_RAW  :: 255;
IPPROTO_MAX  :: 256;

IPPORT_ECHO       :: 7;
IPPORT_DISCARD    :: 9;
IPPORT_SYSTAT     :: 11;
IPPORT_DAYTIME    :: 13;
IPPORT_NETSTAT    :: 15;
IPPORT_FTP        :: 21;
IPPORT_TELNET     :: 23;
IPPORT_SMTP       :: 25;
IPPORT_TIMESERVER :: 37;
IPPORT_NAMESERVER :: 42;
IPPORT_WHOIS      :: 43;
IPPORT_MTP        :: 57;

IPPORT_TFTP    :: 69;
IPPORT_RJE     :: 77;
IPPORT_FINGER  :: 79;
IPPORT_TTYLINK :: 87;
IPPORT_SUPDUP  :: 95;

IPPORT_EXECSERVER  :: 512;
IPPORT_LOGINSERVER :: 513;
IPPORT_CMDSERVER   :: 514;
IPPORT_EFSSERVER   :: 520;

IPPORT_BIFFUDP     :: 512;
IPPORT_WHOSERVER   :: 513;
IPPORT_ROUTESERVER :: 520;

IPPORT_RESERVED :: 1024;

IMPLINK_IP        :: 155;
IMPLINK_LOWEXPER  :: 156;
IMPLINK_HIGHEXPER :: 158;

IN_CLASSA_NET    :: 0xff000000;
IN_CLASSA_NSHIFT :: 24;
IN_CLASSA_HOST   :: 0x00ffffff;
IN_CLASSA_MAX    :: 128;
IN_CLASSB_NET    :: 0xffff0000;
IN_CLASSB_NSHIFT :: 16;
IN_CLASSB_HOST   :: 0x0000ffff;
IN_CLASSB_MAX    :: 65536;
IN_CLASSC_NET    :: 0xffffff00;
IN_CLASSC_NSHIFT :: 8;
IN_CLASSC_HOST   :: 0x000000ff;

IP_OPTIONS         :: 1;
IP_MULTICAST_IF    :: 2;
IP_MULTICAST_TTL   :: 3;
IP_MULTICAST_LOOP  :: 4;
IP_ADD_MEMBERSHIP  :: 5;
IP_DROP_MEMBERSHIP :: 6;
IP_TTL             :: 7;
IP_TOS             :: 8;
IP_DONTFRAGMENT    :: 9;

IP_DEFAULT_MULTICAST_TTL  :: 1;
IP_DEFAULT_MULTICAST_LOOP :: 1;
IP_MAX_MEMBERSHIPS        :: 20;

INADDR_ANY       : u_long : 0x00000000;
INADDR_BROADCAST : u_long : 0xffffffff;
INADDR_LOOPBACK          :: 0x7f000001;
INADDR_NONE              :: 0xffffffff;

WSADESCRIPTION_LEN :: 256;
WSASYS_STATUS_LEN  :: 128;

LPWSADATA :: *WSADATA;

SOCK_STREAM    :: 1;
SOCK_DGRAM     :: 2;
SOCK_RAW       :: 3;
SOCK_RDM       :: 4;
SOCK_SEQPACKET :: 5;

SO_DEBUG       :: 0x0001;
SO_ACCEPTCONN  :: 0x0002;
SO_REUSEADDR   :: 0x0004;
SO_KEEPALIVE   :: 0x0008;
SO_DONTROUTE   :: 0x0010;
SO_BROADCAST   :: 0x0020;
SO_USELOOPBACK :: 0x0040;
SO_LINGER      :: 0x0080;
SO_OOBINLINE   :: 0x0100;

SO_DONTLINGER :: ~SO_LINGER;

SO_SNDBUF   :: 0x1001;
SO_RCVBUF   :: 0x1002;
SO_SNDLOWAT :: 0x1003;
SO_RCVLOWAT :: 0x1004;
SO_SNDTIMEO :: 0x1005;
SO_RCVTIMEO :: 0x1006;
SO_ERROR    :: 0x1007;
SO_TYPE     :: 0x1008;

SO_CONNDATA    :: 0x7000;
SO_CONNOPT     :: 0x7001;
SO_DISCDATA    :: 0x7002;
SO_DISCOPT     :: 0x7003;
SO_CONNDATALEN :: 0x7004;
SO_CONNOPTLEN  :: 0x7005;
SO_DISCDATALEN :: 0x7006;
SO_DISCOPTLEN  :: 0x7007;

SO_OPENTYPE :: 0x7008;

SO_SYNCHRONOUS_ALERT    :: 0x10;
SO_SYNCHRONOUS_NONALERT :: 0x20;

SO_MAXDG                 :: 0x7009;
SO_MAXPATHDG             :: 0x700A;
SO_UPDATE_ACCEPT_CONTEXT :: 0x700B;
SO_CONNECT_TIME          :: 0x700C;

SD_SEND :: 0x01;

TCP_NODELAY   :: 0x0001;
TCP_BSDURGENT :: 0x7000;

// Address families
AF_UNSPEC    :: 0;
AF_UNIX      :: 1;
AF_INET      :: 2;
AF_IMPLINK   :: 3;
AF_PUP       :: 4;
AF_CHAOS     :: 5;
AF_IPX       :: 6;
AF_NS        :: 6;
AF_ISO       :: 7;
AF_OSI       :: AF_ISO;
AF_ECMA      :: 8;
AF_DATAKIT   :: 9;
AF_CCITT     :: 10;
AF_SNA       :: 11;
AF_DECnet    :: 12;
AF_DLI       :: 13;
AF_LAT       :: 14;
AF_HYLINK    :: 15;
AF_APPLETALK :: 16;
AF_NETBIOS   :: 17;
AF_VOICEVIEW :: 18;
AF_FIREFOX   :: 19;
AF_UNKNOWN1  :: 20;
AF_BAN       :: 21;
AF_MAX       :: 22;

PF_UNSPEC    :: AF_UNSPEC;
PF_UNIX      :: AF_UNIX;
PF_INET      :: AF_INET;
PF_IMPLINK   :: AF_IMPLINK;
PF_PUP       :: AF_PUP;
PF_CHAOS     :: AF_CHAOS;
PF_NS        :: AF_NS;
PF_IPX       :: AF_IPX;
PF_ISO       :: AF_ISO;
PF_OSI       :: AF_OSI;
PF_ECMA      :: AF_ECMA;
PF_DATAKIT   :: AF_DATAKIT;
PF_CCITT     :: AF_CCITT;
PF_SNA       :: AF_SNA;
PF_DECnet    :: AF_DECnet;
PF_DLI       :: AF_DLI;
PF_LAT       :: AF_LAT;
PF_HYLINK    :: AF_HYLINK;
PF_APPLETALK :: AF_APPLETALK;
PF_VOICEVIEW :: AF_VOICEVIEW;
PF_FIREFOX   :: AF_FIREFOX;
PF_UNKNOWN1  :: AF_UNKNOWN1;
PF_BAN       :: AF_BAN;

PF_MAX :: AF_MAX;

SOL_SOCKET :: 0xffff;

SOMAXCONN :: 0x7fffffff;

MSG_OOB       :: 0x1;
MSG_PEEK      :: 0x2;
MSG_DONTROUTE :: 0x4;
MSG_MAXIOVLEN :: 16;
MSG_PARTIAL   :: 0x8000;

MAXGETHOSTSTRUCT :: 1024;

FD_READ    :: 0x01;
FD_WRITE   :: 0x02;
FD_OOB     :: 0x04;
FD_ACCEPT  :: 0x08;
FD_CONNECT :: 0x10;
FD_CLOSE   :: 0x20;

TF_DISCONNECT   :: 0x01;
TF_REUSE_SOCKET :: 0x02;
TF_WRITE_BEHIND :: 0x04;

// Windows Sockets error codes
WSABASEERR :: 10000;

WSAEINTR  :: WSABASEERR + 4;
WSAEBADF  :: WSABASEERR + 9;
WSAEACCES :: WSABASEERR + 13;
WSAEFAULT :: WSABASEERR + 14;
WSAEINVAL :: WSABASEERR + 22;
WSAEMFILE :: WSABASEERR + 24;

// Berkeley error codes
WSAEWOULDBLOCK     :: WSABASEERR + 35;
WSAEINPROGRESS     :: WSABASEERR + 36;
WSAEALREADY        :: WSABASEERR + 37;
WSAENOTSOCK        :: WSABASEERR + 38;
WSAEDESTADDRREQ    :: WSABASEERR + 39;
WSAEMSGSIZE        :: WSABASEERR + 40;
WSAEPROTOTYPE      :: WSABASEERR + 41;
WSAENOPROTOOPT     :: WSABASEERR + 42;
WSAEPROTONOSUPPORT :: WSABASEERR + 43;
WSAESOCKTNOSUPPORT :: WSABASEERR + 44;
WSAEOPNOTSUPP      :: WSABASEERR + 45;
WSAEPFNOSUPPORT    :: WSABASEERR + 46;
WSAEAFNOSUPPORT    :: WSABASEERR + 47;
WSAEADDRINUSE      :: WSABASEERR + 48;
WSAEADDRNOTAVAIL   :: WSABASEERR + 49;
WSAENETDOWN        :: WSABASEERR + 50;
WSAENETUNREACH     :: WSABASEERR + 51;
WSAENETRESET       :: WSABASEERR + 52;
WSAECONNABORTED    :: WSABASEERR + 53;
WSAECONNRESET      :: WSABASEERR + 54;
WSAENOBUFS         :: WSABASEERR + 55;
WSAEISCONN         :: WSABASEERR + 56;
WSAENOTCONN        :: WSABASEERR + 57;
WSAESHUTDOWN       :: WSABASEERR + 58;
WSAETOOMANYREFS    :: WSABASEERR + 59;
WSAETIMEDOUT       :: WSABASEERR + 60;
WSAECONNREFUSED    :: WSABASEERR + 61;
WSAELOOP           :: WSABASEERR + 62;
WSAENAMETOOLONG    :: WSABASEERR + 63;
WSAEHOSTDOWN       :: WSABASEERR + 64;
WSAEHOSTUNREACH    :: WSABASEERR + 65;
WSAENOTEMPTY       :: WSABASEERR + 66;
WSAEPROCLIM        :: WSABASEERR + 67;
WSAEUSERS          :: WSABASEERR + 68;
WSAEDQUOT          :: WSABASEERR + 69;
WSAESTALE          :: WSABASEERR + 70;
WSAEREMOTE         :: WSABASEERR + 71;

WSAEDISCON :: WSABASEERR + 101;

// Extended error codes
WSASYSNOTREADY     :: WSABASEERR + 91;
WSAVERNOTSUPPORTED :: WSABASEERR + 92;
WSANOTINITIALISED  :: WSABASEERR + 93;

WSAHOST_NOT_FOUND           :: WSABASEERR + 1001;
WSATRY_AGAIN                :: WSABASEERR + 1002;
WSANO_RECOVERY              :: WSABASEERR + 1003;
WSANO_DATA                  :: WSABASEERR + 1004;
WSA_SECURE_HOST_NOT_FOUND   :: WSABASEERR + 1032;
WSA_IPSEC_NAME_POLICY_ERROR :: WSABASEERR + 1033;

// Compatibility
h_errno        :: WSAGetLastError;
HOST_NOT_FOUND :: WSAHOST_NOT_FOUND;
TRY_AGAIN      :: WSATRY_AGAIN;
NO_RECOVERY    :: WSANO_RECOVERY;
NO_DATA        :: WSANO_DATA;
WSANO_ADDRESS  :: WSANO_DATA;
NO_ADDRESS     :: WSANO_ADDRESS;

// Functions
IN_CLASSA :: inline (i: int) -> bool { return (cast(c.long)(i) & 0x80000000) == 0;          }
IN_CLASSB :: inline (i: int) -> bool { return (cast(c.long)(i) & 0xc0000000) == 0x80000000; }
IN_CLASSC :: inline (i: int) -> bool { return (cast(c.long)(i) & 0xe0000000) == 0xc0000000; }

// Structs
timeval :: struct
{
    tv_sec  : c.long;
    tv_usec : c.long;
}

hostent :: struct
{
    h_name      : *c.char;
    h_aliases   : **c.char;
    h_addrtype  : c.short;
    h_length    : c.short;
    h_addr_list : **c.char;
}

netent :: struct
{
    n_name     : **c.char;
    n_aliases  : **c.char;
    n_addrtype : c.short;
    n_net      : u_long;
}

servent :: struct
{
    s_name    : *c.char;
    s_aliases : **c.char;
    s_port    : c.short;
    s_proto   : *c.char;
}

protoent :: struct
{
    p_name    : *c.char;
    p_aliases : **c.char;
    p_proto   : c.short;
}

sockaddr_in :: struct
{
    sin_family : c.short;
    sin_port   : u_short;
    sin_addr   : in_addr;
    sin_zero   : [8]c.char;
}

sockaddr :: struct
{
    sa_family : u_short;
    sa_data   : [14]c.char;
}

ip_mreq :: struct
{
    imr_multiaddr: in_addr;
    imr_interface: in_addr;
}

in_addr :: struct
{
    union {
        s_un_b: struct {
            s_b1: u_char;
            s_b2: u_char;
            s_b3: u_char;
            s_b4: u_char;
        };
        s_un_w: struct  {
            s_w1: u_short;
            s_w2: u_short;
        };
        s_addr: u_long;
    };
}

sockproto :: struct
{
    sp_family   : u_short;
    sp_protocol : u_short;
}

fd_set :: struct
{
    fd_count: u_int;
    fd_array: [FD_SETSIZE]SOCKET;
}

linger :: struct
{
    l_onoff  : u_short;
    l_linger : u_short;
}

WSADATA :: struct
{
    wVersion       : WORD;
    wHighVersion   : WORD;
    szDescription  : [WSADESCRIPTION_LEN + 1]c.char;
    szSystemStatus : [WSADESCRIPTION_LEN + 1]c.char;
    iMaxSockets    : c.unsigned_short;
    iMaxUdpDg      : c.unsigned_short;
    lpVendorInfo   : *c.char;
}

TRANSMIT_FILE_BUFFERS :: struct
{
    Head       : *void;
    HeadLength : DWORD;
    Tail       : *void;
    TailLength : DWORD;
}

// OVERLAPPED :: struct
// {
//     Internal     : *u_long;
//     InternalHigh : *u_long;
//     union {
//         struct {
//             Offset     : DWORD;
//             OffsetHigh : DWORD;
//         };
//     };
//     Pointer : *void;
//     hEvent  : HANDLE;
// };

// WSA specific functions
WSAStartup               :: (wVersionRequired: WORD, lpWSAData: *WSADATA)                                                  -> c.int  #foreign winsock;
WSACleanup               :: ()                                                                                             -> c.int  #foreign winsock;
WSASetLastError          :: (iError: c.int)                                                                                -> c.int  #foreign winsock;
WSAGetLastError          :: ()                                                                                             -> c.int  #foreign winsock;
WSAIsBlocking            :: ()                                                                                             -> bool   #foreign winsock;
WSAUnhookBlockingHook    :: ()                                                                                             -> c.int  #foreign winsock;
WSACancelBlockingCall    :: ()                                                                                             -> c.int  #foreign winsock;
WSAAsyncGetServByName    :: (hWnd: HWND, wMsg: u_int, name: *c.char, proto: *c.char, buf: *c.char, buflen: c.int)          -> HANDLE #foreign winsock;
WSAAsyncGetServByPort    :: (hWnd: HWND, wMsg: u_int, port: c.int, proto: *c.char, buf: *c.char, buglen: c.int)            -> HANDLE #foreign winsock;
WSAAsyncGetProtoByName   :: (hWnd: HWND, wMsg: u_int, name: *c.char, buf: *c.char, buflen: c.int)                          -> HANDLE #foreign winsock;
WSAAsyncGetProtoByNumber :: (hWnd: HWND, wMsg: u_int, number: c.int, buf: *c.char, buflen: c.int)                          -> HANDLE #foreign winsock;
WSAAsyncGetHostByName    :: (hWnd: HWND, wMsg: u_int, name: *c.char, buf: *c.char, buflen: c.int)                          -> HANDLE #foreign winsock;
WSAAsyncGetHostByAddr    :: (hWnd: HWND, wMsg: u_int, addr: *c.char, len: c.int, type: c.int, buf: *c.char, buflen: c.int) -> HANDLE #foreign winsock;

WSACancelAsyncRequest :: (hAsyncTaskHandle: HANDLE)                           -> c.int #foreign winsock;
WSAAsyncSelect        :: (s: SOCKET, hWnd: HWND, wMsg: u_int, lEvent: c.long) -> c.int #foreign winsock;
WSARecvEx             :: (s: SOCKET, buf: *c.char, len: c.int, flags: *c.int) -> c.int #foreign winsock;

TransmitFile         :: (hSocket: SOCKET, hFile: HANDLE, nNumberOfBytesToWrite: DWORD, nNumberOfBytesPerSend: DWORD, lpOverlapped: *OVERLAPPED, lpTransmitBuffers: *TRANSMIT_FILE_BUFFERS, dwReserved: DWORD)                                            -> bool #foreign winsock;
AcceptEx             :: (sListenSocket: SOCKET, sAcceptSocket: SOCKET, lpOutputBuffer: *void, dwReceiveDataLength: DWORD, dwLocalAddressLength: DWORD, dwRemoteAddressLength: DWORD, lpdwBytesReceived: *DWORD, lpOverlapped: *OVERLAPPED)               -> bool #foreign winsock;
GetAcceptExSockaddrs :: (lpOutputBuffer: *void, dwReceiveDataLength: DWORD, dwLocalAddressLength: DWORD, dwRemoteAddressLength: DWORD, LocalSockaddr: **sockaddr, LocalSockaddrLength: *c.int, RemoteSockaddr: **sockaddr, RemoteSockaddrLength: *c.int)         #foreign winsock;

socket      :: (af: c.int, type: c.int, protocol: c.int)                                                 -> SOCKET #foreign winsock;
accept      :: (s: SOCKET, addr: *sockaddr, addrlen: *c.int)                                             -> SOCKET #foreign winsock;
bind        :: (s: SOCKET, addr: *sockaddr, namelen: c.int)                                              -> c.int  #foreign winsock;
closesocket :: (s: SOCKET)                                                                               -> c.int  #foreign winsock;
ioctlsocket :: (s: SOCKET, cmd: c.long_long, argp: *u_long)                                              -> c.int  #foreign winsock;
getpeername :: (s: SOCKET, name: *sockaddr, namelen: *c.int)                                             -> c.int  #foreign winsock;
getsockname :: (s: SOCKET, name: *sockaddr, namelen: *c.int)                                             -> c.int  #foreign winsock;
getsockopt  :: (s: SOCKET, level: c.int, optname: c.int, optval: *c.char, optlen: c.int)                 -> c.int  #foreign winsock;
listen      :: (s: SOCKET, backlog: c.int)                                                               -> c.int  #foreign winsock;
recv        :: (s: SOCKET, buf: *c.char, len: c.int, flags: c.int, fromlen: *c.int)                      -> c.int  #foreign winsock;
recvfrom    :: (s: SOCKET, buf: *c.char, len: c.int, flags: c.int, from: *sockaddr, fromlen: *c.int)     -> c.int  #foreign winsock;
select      :: (nfds: c.int, readfds: *fd_set, writefds: *fd_set, exceptfds: *fd_set, timeout: *timeval) -> c.int  #foreign winsock;
send        :: (s: SOCKET, buf: *c.char, len: c.int, flags: c.int)                                       -> c.int  #foreign winsock;
sendto      :: (s: SOCKET, buf: *c.char, len: c.int, flags: c.int, to: *sockaddr, tolen: c.int)          -> c.int  #foreign winsock;
setsockopt  :: (s: SOCKET, level: c.int, optname: c.int, optval: *c.char, optlen: c.int)                 -> c.int  #foreign winsock;
shutdown    :: (s: SOCKET, how: c.int)                                                                   -> c.int  #foreign winsock;
connect     :: (s: SOCKET, name: *sockaddr, namelen: c.int)                                              -> c.int  #foreign winsock;

gethostbyaddr    :: (addr: *c.char, len: c.int, type: c.int) -> *hostent  #foreign winsock;
gethostbyname    :: (name: *c.char)                          -> *hostent  #foreign winsock;
gethostname      :: (name: *c.char, namelen: c.int)          -> c.int     #foreign winsock;
getservbyport    :: (port: c.int, proto: *c.char)            -> *servent  #foreign winsock;
getservbyname    :: (name: *c.char, proto: *c.char)          -> *servent  #foreign winsock;
getprotobynumber :: (proto: c.int)                           -> *protoent #foreign winsock;
getprotobyname   :: (name: *c.char)                          -> *protoent #foreign winsock;

inet_addr :: (cp: *c.char) -> c.unsigned_long #foreign winsock;
inet_ntoa :: (in: in_addr) -> *c.char #foreign winsock;

htonl :: (hostlong: u_long)   -> u_long  #foreign winsock;
htons :: (hostshort: u_short) -> u_short #foreign winsock;
ntohl :: (netlong: u_long)    -> u_long  #foreign winsock;
ntohs :: (netshort: u_short)  -> u_short #foreign winsock;

winsock :: #foreign_system_library "wsock32";

