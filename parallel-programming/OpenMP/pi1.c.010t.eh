
;; Function check_points (check_points, funcdef_no=28, decl_uid=3015, cgraph_uid=28, symbol_order=28)

check_points (unsigned int index, unsigned int num_points_per_thread)
{
  double y;
  double x;
  unsigned int local_count;
  unsigned int i;
  unsigned int seed;
  unsigned int D.3045;
  double D.3042;
  double D.3041;
  double D.3040;
  double D.3039;
  int D.3038;
  double D.3037;
  int D.3036;

  seed = index;
  local_count = 0;
  i = 0;
  goto <D.3023>;
  <D.3022>:
  D.3036 = rand_r (&seed);
  D.3037 = (double) D.3036;
  x = D.3037 / 2.147483647e+9;
  D.3038 = rand_r (&seed);
  D.3039 = (double) D.3038;
  y = D.3039 / 2.147483647e+9;
  printf ("Thread %d - Point %f %f\n", index, x, y);
  D.3040 = x * x;
  D.3041 = y * y;
  D.3042 = D.3040 + D.3041;
  if (D.3042 <= 1.0e+0) goto <D.3043>; else goto <D.3044>;
  <D.3043>:
  local_count = local_count + 1;
  <D.3044>:
  i = i + 1;
  <D.3023>:
  if (i < num_points_per_thread) goto <D.3022>; else goto <D.3024>;
  <D.3024>:
  D.3045 = local_count;
  goto <D.3047>;
  <D.3047>:
  seed = {CLOBBER};
  goto <D.3046>;
  <D.3046>:
  return D.3045;
}



;; Function printf (<unset-asm-name>, funcdef_no=11, decl_uid=760, cgraph_uid=11, symbol_order=11)

__attribute__((__artificial__, __gnu_inline__, __always_inline__))
printf (const char * restrict __fmt)
{
  int D.3048;

  D.3048 = __printf_chk (1, __fmt, __builtin_va_arg_pack ());
  goto <D.3049>;
  <D.3049>:
  return D.3048;
}



;; Function main (main, funcdef_no=29, decl_uid=3027, cgraph_uid=29, symbol_order=29)

main (int argc, char * * argv)
{
  unsigned int num_points_per_thread;
  unsigned int num_threads.4;
  unsigned int index;
  double pi;
  unsigned int inside_points;
  unsigned int num_threads;
  unsigned int num_points;
  double D.3072;
  double D.3071;
  double D.3070;
  int D.3062;
  int num_threads.1;
  int D.3060;
  int D.3059;
  char * D.3058;
  char * * D.3057;
  int D.3056;
  char * D.3055;
  char * * D.3054;
  int D.3053;
  struct _IO_FILE * stdout.0;
  unsigned int D.3087;
  unsigned int * D.3088;
  unsigned int D.3089;
  struct .omp_data_s.3 .omp_data_o.5;

  if (argc != 3) goto <D.3050>; else goto <D.3051>;
  <D.3050>:
  stdout.0 = stdout;
  fprintf (stdout.0, "Wrong number of parameters\n");
  D.3053 = 0;
  goto <D.3091>;
  <D.3051>:
  D.3054 = argv + 8;
  D.3055 = *D.3054;
  D.3056 = atoi (D.3055);
  num_points = (unsigned int) D.3056;
  printf ("Number of points is %d\n", num_points);
  D.3057 = argv + 16;
  D.3058 = *D.3057;
  D.3059 = atoi (D.3058);
  num_threads = (unsigned int) D.3059;
  inside_points = 0;
  D.3060 = omp_get_max_threads ();
  stdout.0 = stdout;
  fprintf (stdout.0, "%d\n", D.3060);
  num_threads.1 = (int) num_threads;
  omp_set_num_threads (num_threads.1);
  D.3062 = omp_get_max_threads ();
  stdout.0 = stdout;
  fprintf (stdout.0, "%d\n", D.3062);
  .omp_data_o.5.inside_points = inside_points;
  .omp_data_o.5.num_threads = num_threads;
  .omp_data_o.5.num_points = num_points;
  #pragma omp parallel reduction(+:inside_points) firstprivate(num_threads) firstprivate(num_points) [child fn: main._omp_fn.0 (.omp_data_o.5)]
  .omp_data_i = (struct .omp_data_s.3 & restrict) &.omp_data_o.5;
  inside_points = 0;
  num_threads = .omp_data_i->num_threads;
  num_points = .omp_data_i->num_points;
  num_threads.4 = num_threads;
  #pragma omp for nowait
  for (index = 0; index < num_threads.4; index = index + 1)
  D.3063 = num_points / num_threads;
  D.3065 = num_points % num_threads;
  if (D.3065 > index) goto <D.3083>; else goto <D.3084>;
  <D.3083>:
  iftmp.2 = 1;
  goto <D.3085>;
  <D.3084>:
  iftmp.2 = 0;
  <D.3085>:
  num_points_per_thread = D.3063 + iftmp.2;
  D.3069 = check_points (index, num_points_per_thread);
  inside_points = D.3069 + inside_points;
  #pragma omp continue (index, index)
  #pragma omp return(nowait)
  D.3088 = &.omp_data_i->inside_points;
  #pragma omp atomic_load
    D.3087 = *D.3088
  D.3089 = D.3087 + inside_points;
  #pragma omp atomic_store (D.3089)
  #pragma omp return
  inside_points = .omp_data_o.5.inside_points;
  .omp_data_o.5 = {CLOBBER};
  D.3070 = (double) inside_points;
  D.3071 = D.3070 * 4.0e+0;
  D.3072 = (double) num_points;
  pi = D.3071 / D.3072;
  stdout.0 = stdout;
  fprintf (stdout.0, "Computed pi is %f\n", pi);
  D.3053 = 0;
  goto <D.3091>;
  D.3053 = 0;
  goto <D.3091>;
  <D.3091>:
  return D.3053;
}



;; Function atoi (atoi, funcdef_no=18, decl_uid=2448, cgraph_uid=18, symbol_order=18)

__attribute__((__gnu_inline__, __pure__, __leaf__, __nothrow__))
atoi (const char * __nptr)
{
  long int D.3122;
  int D.3121;

  D.3122 = strtol (__nptr, 0B, 10);
  D.3121 = (int) D.3122;
  goto <D.3123>;
  <D.3123>:
  return D.3121;
}



;; Function fprintf (<unset-asm-name>, funcdef_no=10, decl_uid=738, cgraph_uid=10, symbol_order=10)

__attribute__((__artificial__, __gnu_inline__, __always_inline__))
fprintf (struct FILE * restrict __stream, const char * restrict __fmt)
{
  int D.3124;

  D.3124 = __fprintf_chk (__stream, 1, __fmt, __builtin_va_arg_pack ());
  goto <D.3125>;
  <D.3125>:
  return D.3124;
}


