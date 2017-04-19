
;; Function main._omp_fn.0 (main._omp_fn.0, funcdef_no=30, decl_uid=3074, cgraph_uid=32, symbol_order=32)

main._omp_fn.0 (struct .omp_data_s.3 & restrict .omp_data_i)
{
  unsigned int seed;
  unsigned int i;
  unsigned int local_count;
  double x;
  double y;
  unsigned int D.3169;
  unsigned int num_points_per_thread;
  unsigned int index;
  unsigned int num_points;
  unsigned int num_threads;
  unsigned int inside_points;
  unsigned int q.6_3;
  unsigned int tt.7_4;
  _Bool _9;
  int _15;
  unsigned int _16;
  int _17;
  unsigned int _18;
  unsigned int q.6_19;
  unsigned int tt.7_20;
  unsigned int q.6_21;
  unsigned int _22;
  unsigned int _23;
  unsigned int _24;
  unsigned int _25;
  unsigned int _26;
  unsigned int _29;
  unsigned int * _32;
  int _34;
  double _35;
  int _37;
  double _38;
  double _40;
  double _41;
  double _42;

  <bb 2>:
  num_threads_12 = *.omp_data_i_11(D).num_threads;
  num_points_13 = *.omp_data_i_11(D).num_points;
  if (num_threads_12 != 0)
    goto <bb 4>;
  else
    goto <bb 3>;

  <bb 3>:
  # inside_points_2 = PHI <0(5), inside_points_30(11), 0(2)>
  _32 = &.omp_data_i_11(D)->inside_points;
  __atomic_fetch_add_4 (_32, inside_points_2, 0);
  return;

  <bb 4>:
  _15 = __builtin_omp_get_num_threads ();
  _16 = (unsigned int) _15;
  _17 = __builtin_omp_get_thread_num ();
  _18 = (unsigned int) _17;
  q.6_19 = num_threads_12 / _16;
  tt.7_20 = num_threads_12 % _16;
  if (_18 < tt.7_20)
    goto <bb 12>;
  else
    goto <bb 5>;

  <bb 5>:
  # q.6_3 = PHI <q.6_21(12), q.6_19(4)>
  # tt.7_4 = PHI <0(12), tt.7_20(4)>
  _22 = q.6_3 * _18;
  _23 = tt.7_4 + _22;
  _24 = q.6_3 + _23;
  if (_23 >= _24)
    goto <bb 3>;
  else
    goto <bb 6>;

  <bb 6>:
  # inside_points_6 = PHI <0(5)>
  # index_14 = PHI <_23(5)>

  <bb 7>:
  # inside_points_1 = PHI <inside_points_6(6), inside_points_30(11)>
  # index_5 = PHI <index_14(6), index_31(11)>
  _25 = num_points_13 / num_threads_12;
  _26 = num_points_13 % num_threads_12;
  _9 = index_5 < _26;
  _29 = (unsigned int) _9;
  num_points_per_thread_27 = _25 + _29;
  seed = index_5;
  if (num_points_per_thread_27 != 0)
    goto <bb 8>;
  else
    goto <bb 11>;

  <bb 8>:
  # local_count_64 = PHI <local_count_47(10), 0(7)>
  # i_55 = PHI <i_46(10), 0(7)>
  _34 = rand_r (&seed);
  _35 = (double) _34;
  x_36 = _35 / 2.147483647e+9;
  _37 = rand_r (&seed);
  _38 = (double) _37;
  y_39 = _38 / 2.147483647e+9;
  __printf_chk (1, "Thread %d - Point %f %f\n", index_5, x_36, y_39);
  _40 = x_36 * x_36;
  _41 = y_39 * y_39;
  _42 = _40 + _41;
  if (_42 <= 1.0e+0)
    goto <bb 9>;
  else
    goto <bb 10>;

  <bb 9>:
  local_count_44 = local_count_64 + 1;

  <bb 10>:
  # local_count_47 = PHI <local_count_64(8), local_count_44(9)>
  i_46 = i_55 + 1;
  if (num_points_per_thread_27 > i_46)
    goto <bb 8>;
  else
    goto <bb 11>;

  <bb 11>:
  # local_count_65 = PHI <local_count_47(10), 0(7)>
  seed ={v} {CLOBBER};
  inside_points_30 = inside_points_1 + local_count_65;
  index_31 = index_5 + 1;
  if (_24 > index_31)
    goto <bb 7>;
  else
    goto <bb 3>;

  <bb 12>:
  q.6_21 = q.6_19 + 1;
  goto <bb 5>;

}



;; Function check_points (check_points, funcdef_no=28, decl_uid=3015, cgraph_uid=28, symbol_order=28)

check_points (unsigned int index, unsigned int num_points_per_thread)
{
  double y;
  double x;
  unsigned int local_count;
  unsigned int i;
  unsigned int seed;
  int _10;
  double _11;
  int _14;
  double _15;
  double _17;
  double _18;
  double _19;

  <bb 2>:
  seed = index_6(D);
  if (num_points_per_thread_8(D) != 0)
    goto <bb 3>;
  else
    goto <bb 6>;

  <bb 3>:
  # i_27 = PHI <i_21(5), 0(2)>
  # local_count_28 = PHI <local_count_2(5), 0(2)>
  _10 = rand_r (&seed);
  _11 = (double) _10;
  x_12 = _11 / 2.147483647e+9;
  _14 = rand_r (&seed);
  _15 = (double) _14;
  y_16 = _15 / 2.147483647e+9;
  __printf_chk (1, "Thread %d - Point %f %f\n", index_6(D), x_12, y_16);
  _17 = x_12 * x_12;
  _18 = y_16 * y_16;
  _19 = _17 + _18;
  if (_19 <= 1.0e+0)
    goto <bb 4>;
  else
    goto <bb 5>;

  <bb 4>:
  local_count_20 = local_count_28 + 1;

  <bb 5>:
  # local_count_2 = PHI <local_count_28(3), local_count_20(4)>
  i_21 = i_27 + 1;
  if (num_points_per_thread_8(D) > i_21)
    goto <bb 3>;
  else
    goto <bb 6>;

  <bb 6>:
  # local_count_29 = PHI <local_count_2(5), 0(2)>
  seed ={v} {CLOBBER};
  return local_count_29;

}



;; Function main (main, funcdef_no=29, decl_uid=3027, cgraph_uid=29, symbol_order=29) (executed once)

main (int argc, char * * argv)
{
  double pi;
  unsigned int inside_points;
  unsigned int num_threads;
  unsigned int num_points;
  struct .omp_data_s.3 .omp_data_o.5;
  struct _IO_FILE * stdout.0_4;
  char * _6;
  char * _8;
  int _11;
  struct _IO_FILE * stdout.0_12;
  int _15;
  struct _IO_FILE * stdout.0_16;
  double _23;
  double _24;
  double _25;
  struct _IO_FILE * stdout.0_27;
  long int _28;
  int _29;
  long int _30;

  <bb 2>:
  if (argc_2(D) != 3)
    goto <bb 3>;
  else
    goto <bb 4>;

  <bb 3>:
  stdout.0_4 = stdout;
  __builtin_fwrite ("Wrong number of parameters\n", 1, 27, stdout.0_4);
  goto <bb 5>;

  <bb 4>:
  _6 = MEM[(char * *)argv_5(D) + 8B];
  _30 = strtol (_6, 0B, 10);
  num_points_7 = (unsigned int) _30;
  __printf_chk (1, "Number of points is %d\n", num_points_7);
  _8 = MEM[(char * *)argv_5(D) + 16B];
  _28 = strtol (_8, 0B, 10);
  _29 = (int) _28;
  num_threads_9 = (unsigned int) _28;
  _11 = omp_get_max_threads ();
  stdout.0_12 = stdout;
  __fprintf_chk (stdout.0_12, 1, "%d\n", _11);
  omp_set_num_threads (_29);
  _15 = omp_get_max_threads ();
  stdout.0_16 = stdout;
  __fprintf_chk (stdout.0_16, 1, "%d\n", _15);
  .omp_data_o.5.inside_points = 0;
  .omp_data_o.5.num_threads = num_threads_9;
  .omp_data_o.5.num_points = num_points_7;
  __builtin_GOMP_parallel (main._omp_fn.0, &.omp_data_o.5, 0, 0);
  inside_points_21 = .omp_data_o.5.inside_points;
  .omp_data_o.5 ={v} {CLOBBER};
  _23 = (double) inside_points_21;
  _24 = _23 * 4.0e+0;
  _25 = (double) num_points_7;
  pi_26 = _24 / _25;
  stdout.0_27 = stdout;
  __fprintf_chk (stdout.0_27, 1, "Computed pi is %f\n", pi_26);

  <bb 5>:
  return 0;

}


