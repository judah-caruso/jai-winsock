// This is a modified version of https://github.com/judah-caruso/C

// I've modified it so this module doesn't technically have any
// external dependencies that also need to be cloned/managed.

// Once there's a way to make external modules easier to manage
// for users, I will update this.

c :: struct {
	// === Standard Types ===
	char          :: #type u8;
	short         :: #type s16;
	int           :: #type s32;
	float         :: #type float32;
	double        :: #type float64;

	short_int     :: #type s16;
	long_long     :: #type s64;
	long_long_int :: #type s64;
	long_double   :: #type s64;

	// Platform-specific types
	// @Todo(Judah): Doesn't account for Mac or Linux besides them... not being Windows.
	#if OS == .WINDOWS {
		long          :: #type s32;
		signed_long   :: #type s32;
		unsigned_long :: #type u32;
	} else {
		long          :: #type s64;
		signed_long   :: #type s64;
		unsigned_long :: #type u64;
	}

	// === Unsigned Types ===
	unsigned_char          :: #type u8;
	unsigned_short         :: #type u16;
	unsigned_short_int     :: #type u16;
	unsigned               :: #type u32;
	unsigned_int           :: #type u32;
	unsigned_long_long     :: #type u64;
	unsigned_long_long_int :: #type u64;

	// === Signed Types ===
	signed_char          :: #type s8;
	signed_short         :: #type s16;
	signed_short_int     :: #type s16;
	signed               :: #type s32;
	signed_int           :: #type s32;
	signed_long_long     :: #type s64;
	signed_long_long_int :: #type s64;

	// === Extended Types ===
	size_t    :: #type s64;
	intptr_t  :: #type s64;
	uintptr_t :: #type u64;
}

#assert(size_of(c.uintptr_t) >= size_of(c.size_t));

#import "Basic";
