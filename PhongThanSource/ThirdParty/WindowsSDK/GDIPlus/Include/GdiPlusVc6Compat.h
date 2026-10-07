#ifndef PHONGTHAN_GDIPLUS_VC6_COMPAT_H
#define PHONGTHAN_GDIPLUS_VC6_COMPAT_H

/* SAL annotations used by current Microsoft GDI+ headers are not available
   in the VC6 Platform SDK. They are compile-time analysis markers only. */
#ifndef _Always_
#define _Always_(expr)
#endif
#ifndef _Field_size_opt_
#define _Field_size_opt_(size)
#endif
#ifndef _In_
#define _In_
#endif
#ifndef _In_reads_opt_
#define _In_reads_opt_(size)
#endif
#ifndef _Inexpressible_
#define _Inexpressible_(text)
#endif
#ifndef _Inout_
#define _Inout_
#endif
#ifndef _Out_
#define _Out_
#endif
#ifndef _Out_opt_
#define _Out_opt_
#endif
#ifndef _Out_range_
#define _Out_range_(low, high)
#endif
#ifndef _Out_writes_
#define _Out_writes_(size)
#endif
#ifndef _Out_writes_bytes_
#define _Out_writes_bytes_(size)
#endif
#ifndef _Out_writes_bytes_to_
#define _Out_writes_bytes_to_(size, count)
#endif
#ifndef _Out_writes_to_
#define _Out_writes_to_(size, count)
#endif
#ifndef _Out_writes_to_opt_
#define _Out_writes_to_opt_(size, count)
#endif
#ifndef _Outptr_
#define _Outptr_
#endif
#ifndef _Post_equal_to_
#define _Post_equal_to_(expr)
#endif
#ifndef _Post_satisfies_
#define _Post_satisfies_(expr)
#endif
#ifndef _Return_type_success_
#define _Return_type_success_(expr)
#endif

#endif

