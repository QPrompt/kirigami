#cmakedefine01 HAVE_OpenMP

#if HAVE_OpenMP && !defined(_MSC_VER) && (!defined(__GNUC__) || (defined(__GNUC__) && __GNUC__ >= 10))
#define OPENMP_SUPPORT_NESTED
#endif
