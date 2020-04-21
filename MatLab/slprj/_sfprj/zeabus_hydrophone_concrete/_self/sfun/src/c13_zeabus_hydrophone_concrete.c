/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c13_zeabus_hydrophone_concrete.h"
#include <math.h>
#include "mwmathutil.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(S);
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const mxArray *c13_eml_mx;
static const mxArray *c13_b_eml_mx;
static const mxArray *c13_c_eml_mx;
static const mxArray *c13_d_eml_mx;
static emlrtRSInfo c13_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC3 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:589"    /* pathName */
};

static emlrtRSInfo c13_b_emlrtRSI = { 26,/* lineNo */
  "Hydrophone processing/ADC3 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:589"    /* pathName */
};

static emlrtRSInfo c13_c_emlrtRSI = { 41,/* lineNo */
  "Hydrophone processing/ADC3 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:589"    /* pathName */
};

static emlrtRSInfo c13_d_emlrtRSI = { 14,/* lineNo */
  "bitsra",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\bitsra.m"/* pathName */
};

static emlrtRSInfo c13_e_emlrtRSI = { 75,/* lineNo */
  "eml_fi_bitshift",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\eml_fi_bitshift.m"/* pathName */
};

static emlrtRSInfo c13_f_emlrtRSI = { 236,/* lineNo */
  "eml_fi_bitshift",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\eml_fi_bitshift.m"/* pathName */
};

/* Function Declarations */
static void initialize_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c13_update_jit_animation_state_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c13_do_animation_call_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c13_st);
static void finalize_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c13_emlrt_update_log_1
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static int32_T c13_emlrt_update_log_2
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static uint8_T c13_emlrt_update_log_3
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static int32_T c13_emlrt_update_log_4
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static uint8_T c13_emlrt_update_log_5
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static boolean_T c13_emlrt_update_log_6
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c13_in, emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static int32_T c13_emlrt_update_log_7
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static real_T c13_emlrt_update_log_8
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, real_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index);
static void c13_emlrtInitVarDataTables
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c13_dataTables[18],
   emlrtLocationLoggingHistogramType c13_histTables[18]);
static int32_T c13_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_y, const char_T *c13_identifier);
static int32_T c13_b_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId);
static int32_T c13_c_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_acc, const char_T *c13_identifier,
   boolean_T *c13_svPtr);
static int32_T c13_d_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId, boolean_T *c13_svPtr);
static int32_T c13_e_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_avg, const char_T *c13_identifier,
   boolean_T *c13_svPtr);
static int32_T c13_f_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId, boolean_T *c13_svPtr);
static uint8_T c13_g_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_counter, const char_T
   *c13_identifier, boolean_T *c13_svPtr);
static uint8_T c13_h_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId, boolean_T *c13_svPtr);
static uint8_T c13_i_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c13_b_is_active_c13_zeabus_hydrophone_concrete, const char_T *c13_identifier);
static uint8_T c13_j_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c13_b_u, const emlrtMsgIdentifier *c13_parentId);
static const mxArray *c13_chart_data_browse_helper
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c13_ssIdNumber);
static int32_T c13__s32_shl_s32_(SFc13_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c13_b, int32_T c13_c, int32_T c13_EMLOvCount_src_loc,
  uint32_T c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T
  c13_length_src_loc);
static uint32_T c13__u32_add__(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c13_b, uint32_T c13_c, int32_T c13_EMLOvCount_src_loc,
  uint32_T c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T
  c13_length_src_loc);
static uint8_T c13__u8_u32_(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c13_b, int32_T c13_EMLOvCount_src_loc, uint32_T
  c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T c13_length_src_loc);
static int32_T c13__s32_add__(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c13_b, int32_T c13_c, int32_T c13_EMLOvCount_src_loc,
  uint32_T c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T
  c13_length_src_loc);
static void init_dsm_address_info(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c13_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c13_st.tls = chartInstance->c13_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c13_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c13_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c13_acc_not_empty = false;
  chartInstance->c13_counter_not_empty = false;
  chartInstance->c13_avg_not_empty = false;
  chartInstance->c13_is_active_c13_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c13_d_eml_mx, sf_mex_call(&c13_st, "numerictype", 1U, 14U, 15,
    "SignednessBool", 3, false, 15, "Signedness", 15, "Unsigned", 15,
    "WordLength", 6, 7.0, 15, "FractionLength", 6, 0.0, 15, "BinaryPoint", 6,
    0.0, 15, "Slope", 6, 1.0, 15, "FixedExponent", 6, 0.0), true);
  sf_mex_assign(&c13_c_eml_mx, sf_mex_call(&c13_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 24.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c13_b_eml_mx, sf_mex_call(&c13_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c13_eml_mx, sf_mex_call(&c13_st, "fimath", 1U, 42U, 15,
    "RoundMode", 15, "floor", 15, "RoundingMethod", 15, "Floor", 15,
    "OverflowMode", 15, "wrap", 15, "OverflowAction", 15, "Wrap", 15,
    "ProductMode", 15, "FullPrecision", 15, "SumMode", 15, "FullPrecision", 15,
    "ProductWordLength", 6, 32.0, 15, "SumWordLength", 6, 32.0, 15,
    "MaxProductWordLength", 6, 128.0, 15, "MaxSumWordLength", 6, 128.0, 15,
    "ProductFractionLength", 6, 30.0, 15, "ProductFixedExponent", 6, -30.0, 15,
    "SumFractionLength", 6, 30.0, 15, "SumFixedExponent", 6, -30.0, 15,
    "SumSlopeAdjustmentFactor", 6, 1.0, 15, "SumBias", 6, 0.0, 15,
    "ProductSlopeAdjustmentFactor", 6, 1.0, 15, "ProductBias", 6, 0.0, 15,
    "CastBeforeSum", 3, true, 15, "SumSlope", 6, 9.3132257461547852E-10, 15,
    "ProductSlope", 6, 9.3132257461547852E-10), true);
  chartInstance->c13_emlrtLocLogSimulated = false;
  c13_emlrtInitVarDataTables(chartInstance,
    chartInstance->c13_emlrtLocationLoggingDataTables,
    chartInstance->c13_emlrtLocLogHistTables);
}

static void initialize_params_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c13_update_jit_animation_state_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c13_do_animation_call_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c13_st;
  const mxArray *c13_b_y = NULL;
  const mxArray *c13_c_y = NULL;
  int32_T c13_b_u;
  const mxArray *c13_d_y = NULL;
  const mxArray *c13_e_y = NULL;
  int32_T c13_c_u;
  const mxArray *c13_f_y = NULL;
  const mxArray *c13_g_y = NULL;
  int32_T c13_d_u;
  const mxArray *c13_h_y = NULL;
  const mxArray *c13_i_y = NULL;
  uint8_T c13_e_u;
  const mxArray *c13_j_y = NULL;
  const mxArray *c13_k_y = NULL;
  c13_st = NULL;
  c13_st = NULL;
  c13_b_y = NULL;
  sf_mex_assign(&c13_b_y, sf_mex_createcellmatrix(5, 1), false);
  c13_c_y = NULL;
  c13_b_u = *chartInstance->c13_y;
  c13_d_y = NULL;
  sf_mex_assign(&c13_d_y, sf_mex_create("y", &c13_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c13_c_y, sf_mex_create_fi(sf_mex_dup(c13_eml_mx), sf_mex_dup
    (c13_b_eml_mx), "simulinkarray", c13_d_y, false, false), false);
  sf_mex_setcell(c13_b_y, 0, c13_c_y);
  c13_e_y = NULL;
  if (!chartInstance->c13_acc_not_empty) {
    sf_mex_assign(&c13_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c13_c_u = chartInstance->c13_acc;
    c13_f_y = NULL;
    sf_mex_assign(&c13_f_y, sf_mex_create("y", &c13_c_u, 6, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c13_e_y, sf_mex_create_fi(sf_mex_dup(c13_eml_mx), sf_mex_dup
      (c13_c_eml_mx), "simulinkarray", c13_f_y, true, false), false);
  }

  sf_mex_setcell(c13_b_y, 1, c13_e_y);
  c13_g_y = NULL;
  if (!chartInstance->c13_avg_not_empty) {
    sf_mex_assign(&c13_g_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c13_d_u = chartInstance->c13_avg;
    c13_h_y = NULL;
    sf_mex_assign(&c13_h_y, sf_mex_create("y", &c13_d_u, 6, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c13_g_y, sf_mex_create_fi(sf_mex_dup(c13_eml_mx), sf_mex_dup
      (c13_b_eml_mx), "simulinkarray", c13_h_y, true, false), false);
  }

  sf_mex_setcell(c13_b_y, 2, c13_g_y);
  c13_i_y = NULL;
  if (!chartInstance->c13_counter_not_empty) {
    sf_mex_assign(&c13_i_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c13_e_u = chartInstance->c13_counter;
    c13_j_y = NULL;
    sf_mex_assign(&c13_j_y, sf_mex_create("y", &c13_e_u, 3, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c13_i_y, sf_mex_create_fi(sf_mex_dup(c13_eml_mx), sf_mex_dup
      (c13_d_eml_mx), "simulinkarray", c13_j_y, true, false), false);
  }

  sf_mex_setcell(c13_b_y, 3, c13_i_y);
  c13_k_y = NULL;
  sf_mex_assign(&c13_k_y, sf_mex_create("y",
    &chartInstance->c13_is_active_c13_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c13_b_y, 4, c13_k_y);
  sf_mex_assign(&c13_st, c13_b_y, false);
  return c13_st;
}

static void set_sim_state_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c13_st)
{
  emlrtStack c13_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c13_b_u;
  c13_b_st.tls = chartInstance->c13_fEmlrtCtx;
  chartInstance->c13_doneDoubleBufferReInit = true;
  c13_b_u = sf_mex_dup(c13_st);
  *chartInstance->c13_y = c13_emlrt_marshallIn(chartInstance, &c13_b_st,
    sf_mex_dup(sf_mex_getcell(c13_b_u, 0)), "y");
  chartInstance->c13_acc = c13_c_emlrt_marshallIn(chartInstance, &c13_b_st,
    sf_mex_dup(sf_mex_getcell(c13_b_u, 1)), "acc",
    &chartInstance->c13_acc_not_empty);
  chartInstance->c13_avg = c13_e_emlrt_marshallIn(chartInstance, &c13_b_st,
    sf_mex_dup(sf_mex_getcell(c13_b_u, 2)), "avg",
    &chartInstance->c13_avg_not_empty);
  chartInstance->c13_counter = c13_g_emlrt_marshallIn(chartInstance, &c13_b_st,
    sf_mex_dup(sf_mex_getcell(c13_b_u, 3)), "counter",
    &chartInstance->c13_counter_not_empty);
  chartInstance->c13_is_active_c13_zeabus_hydrophone_concrete =
    c13_i_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c13_b_u, 4)),
    "is_active_c13_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c13_b_u);
  sf_mex_destroy(&c13_st);
}

static void finalize_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c13_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:589", /* mexFileName */
    "Thu Apr 16 10:58:05 2020",        /* timestamp */
    "",                                /* buildDir */
    2,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c13_emlrtLocationLoggingFunctionInfoTable[2] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      15                               /* numInstrPoints */
    }, { "fi_div_by_shift",            /* fcnName */
      79,                              /* fcnId */
      3                                /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c13_emlrtLocationInfo[21] = { { 1,/* MxInfoID */
      43,                              /* TextStart */
      1,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      75,                              /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      79,                              /* TextStart */
      20,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      178,                             /* TextStart */
      3,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 5,                            /* MxInfoID */
      237,                             /* TextStart */
      7,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      294,                             /* TextStart */
      3,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      371,                             /* TextStart */
      3,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      380,                             /* TextStart */
      7,                               /* TextLength */
      5,                               /* Reason */
      false                            /* MoreLocations */
    }, { 5,                            /* MxInfoID */
      408,                             /* TextStart */
      7,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 7,                            /* MxInfoID */
      421,                             /* TextStart */
      28,                              /* TextLength */
      5,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      455,                             /* TextStart */
      30,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 5,                            /* MxInfoID */
      492,                             /* TextStart */
      7,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      512,                             /* TextStart */
      3,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 9,                            /* MxInfoID */
      521,                             /* TextStart */
      23,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      550,                             /* TextStart */
      3,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      567,                             /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      571,                             /* TextStart */
      22,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      631,                             /* TextStart */
      1,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 9,                            /* MxInfoID */
      856,                             /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 9,                            /* MxInfoID */
      860,                             /* TextStart */
      39,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 12,                           /* MxInfoID */
      633,                             /* TextStart */
      9,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    } };

  const int32_T c13_emlrtLocationLoggingFieldCounts[18] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c13_RuntimeVar);
  if (chartInstance->c13_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:589");
    emlrtLocationLoggingPushLog(&c13_emlrtLocationLoggingFileInfo,
      c13_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c13_emlrtLocationLoggingDataTables, c13_emlrtLocationInfo,
      NULL, 0U, c13_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:589");
  }

  sf_mex_destroy(&c13_eml_mx);
  sf_mex_destroy(&c13_b_eml_mx);
  sf_mex_destroy(&c13_c_eml_mx);
  sf_mex_destroy(&c13_d_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c13_covrtInstance);
}

static void sf_gateway_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c13_PICOffset;
  int32_T c13_b_u;
  int32_T c13_varargin_1;
  int32_T c13_b_varargin_1;
  int32_T c13_var1;
  int32_T c13_hfi;
  int32_T c13_c_u;
  int32_T c13_a0;
  int32_T c13_b0;
  int32_T c13_i;
  real_T c13_d;
  int32_T c13_i1;
  real_T c13_d1;
  real_T c13_d2;
  real_T c13_d3;
  int32_T c13_i2;
  int32_T c13_i3;
  int32_T c13_i4;
  real_T c13_d4;
  real_T c13_d5;
  int32_T c13_c;
  int32_T c13_i5;
  real_T c13_d6;
  real_T c13_d7;
  int32_T c13_i6;
  uint8_T c13_b_a0;
  uint8_T c13_b_c;
  uint8_T c13_d_u;
  real_T c13_d8;
  uint8_T c13_c_a0;
  uint8_T c13_a;
  uint8_T c13_d_a0;
  uint8_T c13_a1;
  uint8_T c13_b_a1;
  boolean_T c13_c_c;
  int32_T c13_i7;
  int32_T c13_i8;
  real_T c13_d9;
  int32_T c13_c_varargin_1;
  int32_T c13_b_a;
  int32_T c13_d_varargin_1;
  int32_T c13_b_var1;
  int32_T c13_b_hfi;
  int32_T c13_b_y;
  int32_T c13_i9;
  real_T c13_d10;
  real_T c13_d11;
  int32_T c13_ain;
  int32_T c13_b_ain;
  int32_T c13_c_a;
  int32_T c13_e_varargin_1;
  int32_T c13_i10;
  int32_T c13_d_c;
  int32_T c13_cout;
  int32_T c13_c_y;
  int32_T c13_i11;
  real_T c13_d12;
  real_T c13_d13;
  int32_T c13_i12;
  observerLogReadPIC(&c13_PICOffset);
  chartInstance->c13_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c13_covrtInstance, 0U, (real_T)
                    *chartInstance->c13_u);
  chartInstance->c13_sfEvent = CALL_EVENT;
  c13_b_u = *chartInstance->c13_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c13_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c13_emlrt_update_log_1(chartInstance, c13_b_u,
    chartInstance->c13_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c13_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c13_covrtInstance, 4U, 0, 2);
  c13_varargin_1 = c13_b_u;
  c13_b_varargin_1 = c13_varargin_1;
  c13_var1 = c13_b_varargin_1;
  c13_hfi = c13_var1;
  c13_c_u = c13_emlrt_update_log_1(chartInstance, c13_hfi,
    chartInstance->c13_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c13_covrtInstance, 4U, 0, 0,
                     !chartInstance->c13_acc_not_empty)) {
    chartInstance->c13_acc = c13_emlrt_update_log_2(chartInstance, 0,
      chartInstance->c13_emlrtLocationLoggingDataTables, 2);
    chartInstance->c13_acc_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c13_covrtInstance, 4U, 0, 1,
                     !chartInstance->c13_counter_not_empty)) {
    chartInstance->c13_counter = c13_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c13_emlrtLocationLoggingDataTables, 3);
    chartInstance->c13_counter_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c13_covrtInstance, 4U, 0, 2,
                     !chartInstance->c13_avg_not_empty)) {
    chartInstance->c13_avg = c13_emlrt_update_log_1(chartInstance, 0,
      chartInstance->c13_emlrtLocationLoggingDataTables, 4);
    chartInstance->c13_avg_not_empty = true;
  }

  c13_a0 = chartInstance->c13_acc;
  c13_b0 = c13_c_u;
  c13_i = c13_a0;
  if (c13_i > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c13_d = 1.0;
    observerLog(143 + c13_PICOffset, &c13_d, 1);
  }

  if (c13_i < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c13_d1 = 1.0;
    observerLog(143 + c13_PICOffset, &c13_d1, 1);
  }

  c13_i1 = c13_b0;
  if (c13_i1 > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c13_d2 = 1.0;
    observerLog(146 + c13_PICOffset, &c13_d2, 1);
  }

  if (c13_i1 < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c13_d3 = 1.0;
    observerLog(146 + c13_PICOffset, &c13_d3, 1);
  }

  if ((c13_i & 16777216) != 0) {
    c13_i2 = c13_i | -16777216;
  } else {
    c13_i2 = c13_i & 16777215;
  }

  if ((c13_i1 & 16777216) != 0) {
    c13_i3 = c13_i1 | -16777216;
  } else {
    c13_i3 = c13_i1 & 16777215;
  }

  c13_i4 = c13__s32_add__(chartInstance, c13_i2, c13_i3, 145, 1U, 380, 7);
  if (c13_i4 > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c13_d4 = 1.0;
    observerLog(171 + c13_PICOffset, &c13_d4, 1);
  }

  if (c13_i4 < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c13_d5 = 1.0;
    observerLog(171 + c13_PICOffset, &c13_d5, 1);
  }

  if ((c13_i4 & 16777216) != 0) {
    c13_c = c13_i4 | -16777216;
  } else {
    c13_c = c13_i4 & 16777215;
  }

  c13_i5 = c13_emlrt_update_log_4(chartInstance, c13_c,
    chartInstance->c13_emlrtLocationLoggingDataTables, 6);
  if (c13_i5 > 8388607) {
    sf_data_overflow_error(chartInstance->S, 1U, 371, 16);
    c13_d6 = 1.0;
    observerLog(151 + c13_PICOffset, &c13_d6, 1);
  }

  if (c13_i5 < -8388608) {
    sf_data_overflow_error(chartInstance->S, 1U, 371, 16);
    c13_d7 = 1.0;
    observerLog(151 + c13_PICOffset, &c13_d7, 1);
  }

  if ((c13_i5 & 8388608) != 0) {
    c13_i6 = c13_i5 | -8388608;
  } else {
    c13_i6 = c13_i5 & 8388607;
  }

  chartInstance->c13_acc = c13_emlrt_update_log_2(chartInstance, c13_i6,
    chartInstance->c13_emlrtLocationLoggingDataTables, 5);
  c13_b_a0 = chartInstance->c13_counter;
  c13_b_c = c13__u8_u32_(chartInstance, c13__u32_add__(chartInstance, (uint32_T)
    c13_b_a0, 1U, 153, 1U, 421, 28), 152, 1U, 421, 28);
  c13_d_u = c13_emlrt_update_log_5(chartInstance, c13_b_c,
    chartInstance->c13_emlrtLocationLoggingDataTables, 8);
  if (c13_d_u > 127) {
    sf_data_overflow_error(chartInstance->S, 1U, 408, 41);
    c13_d8 = 1.0;
    observerLog(155 + c13_PICOffset, &c13_d8, 1);
  }

  chartInstance->c13_counter = c13_emlrt_update_log_3(chartInstance, (uint8_T)
    (c13_d_u & 127), chartInstance->c13_emlrtLocationLoggingDataTables, 7);
  c13_c_a0 = chartInstance->c13_counter;
  c13_a = c13_c_a0;
  c13_d_a0 = c13_a;
  c13_a1 = c13_d_a0;
  c13_b_a1 = c13_a1;
  c13_c_c = (c13_b_a1 == 64);
  c13_i7 = 64 - (int8_T)chartInstance->c13_counter;
  if (c13_i7 > 127) {
    c13_i7 = 127;
  } else {
    if (c13_i7 < -128) {
      c13_i7 = -128;
    }
  }

  c13_i8 = (int8_T)chartInstance->c13_counter - 64;
  if (c13_i8 > 127) {
    c13_i8 = 127;
  } else {
    if (c13_i8 < -128) {
      c13_i8 = -128;
    }
  }

  if ((int8_T)chartInstance->c13_counter < 64) {
    c13_d9 = (real_T)((int8_T)c13_i7 <= 1);
  } else if ((int8_T)chartInstance->c13_counter > 64) {
    if ((int8_T)c13_i8 <= 1) {
      c13_d9 = 3.0;
    } else {
      c13_d9 = 0.0;
    }
  } else {
    c13_d9 = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c13_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c13_covrtInstance,
        4U, 0U, 0U, c13_d9, 0.0, -2, 0U, (int32_T)c13_emlrt_update_log_6
        (chartInstance, c13_c_c,
         chartInstance->c13_emlrtLocationLoggingDataTables, 9)))) {
    chartInstance->c13_counter = c13_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c13_emlrtLocationLoggingDataTables, 10);
    c13_b_a = chartInstance->c13_acc;
    c13_emlrt_update_log_8(chartInstance, 6.0,
      chartInstance->c13_emlrtLocationLoggingDataTables, 17);

    /* logging input variable 'a' for function 'fi_div_by_shift' */
    c13_emlrt_update_log_2(chartInstance, c13_b_a,
      chartInstance->c13_emlrtLocationLoggingDataTables, 15);
    covrtEmlFcnEval(chartInstance->c13_covrtInstance, 4U, 0, 1);
    covrtEmlIfEval(chartInstance->c13_covrtInstance, 4U, 0, 4, true);
    c13_i9 = c13__s32_shl_s32_(chartInstance, c13_b_a, 6, 160, 1U, 868, 18);
    if (c13_i9 > 536870911) {
      sf_data_overflow_error(chartInstance->S, 1U, 868, 18);
      c13_d10 = 1.0;
      observerLog(168 + c13_PICOffset, &c13_d10, 1);
    }

    if (c13_i9 < -536870912) {
      sf_data_overflow_error(chartInstance->S, 1U, 868, 18);
      c13_d11 = 1.0;
      observerLog(168 + c13_PICOffset, &c13_d11, 1);
    }

    if ((c13_i9 & 536870912) != 0) {
      c13_ain = c13_i9 | -536870912;
    } else {
      c13_ain = c13_i9 & 536870911;
    }

    c13_b_ain = c13_ain;
    c13_c_a = c13_b_ain;
    c13_e_varargin_1 = c13_c_a;
    c13_i10 = c13_e_varargin_1 >> 6;
    if ((c13_i10 & 536870912) != 0) {
      c13_d_c = c13_i10 | -536870912;
    } else {
      c13_d_c = c13_i10 & 536870911;
    }

    c13_cout = c13_d_c;
    c13_c_y = c13_emlrt_update_log_7(chartInstance, c13_cout,
      chartInstance->c13_emlrtLocationLoggingDataTables, 16);
    c13_i11 = c13_emlrt_update_log_7(chartInstance, c13_c_y,
      chartInstance->c13_emlrtLocationLoggingDataTables, 12) >> 6;
    if (c13_i11 > 131071) {
      sf_data_overflow_error(chartInstance->S, 1U, 512, 32);
      c13_d12 = 1.0;
      observerLog(166 + c13_PICOffset, &c13_d12, 1);
    }

    if (c13_i11 < -131072) {
      sf_data_overflow_error(chartInstance->S, 1U, 512, 32);
      c13_d13 = 1.0;
      observerLog(166 + c13_PICOffset, &c13_d13, 1);
    }

    if ((c13_i11 & 131072) != 0) {
      c13_i12 = c13_i11 | -131072;
    } else {
      c13_i12 = c13_i11 & 131071;
    }

    chartInstance->c13_avg = c13_emlrt_update_log_1(chartInstance, c13_i12,
      chartInstance->c13_emlrtLocationLoggingDataTables, 11);
    chartInstance->c13_acc = c13_emlrt_update_log_2(chartInstance, 0,
      chartInstance->c13_emlrtLocationLoggingDataTables, 13);
  }

  c13_c_varargin_1 = chartInstance->c13_avg;
  c13_d_varargin_1 = c13_c_varargin_1;
  c13_b_var1 = c13_d_varargin_1;
  c13_b_hfi = c13_b_var1;
  c13_b_y = c13_emlrt_update_log_1(chartInstance, c13_b_hfi,
    chartInstance->c13_emlrtLocationLoggingDataTables, 14);
  *chartInstance->c13_y = c13_b_y;
  c13_do_animation_call_c13_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c13_covrtInstance, 1U, (real_T)
                    *chartInstance->c13_y);
}

static void mdl_start_c13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c13_decisionTxtStartIdx = 0U;
  static const uint32_T c13_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c13_chart_data_browse_helper);
  chartInstance->c13_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c13_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c13_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c13_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c13_decisionTxtStartIdx, &c13_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c13_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c13_covrtInstance, "", 4U, 0U, 3U, 0U, 5U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 598);
  covrtEmlFcnInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 1U,
                     "fi_div_by_shift", 602, -1, 952);
  covrtEmlFcnInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 2U, "get_fimath",
                     954, -1, 1208);
  covrtEmlIfInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 0U, 155, 171, -1,
                    209);
  covrtEmlIfInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 1U, 210, 230, -1,
                    270);
  covrtEmlIfInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 2U, 271, 287, -1,
                    325);
  covrtEmlIfInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 3U, 451, 485, -1,
                    565);
  covrtEmlIfInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 4U, 678, 690, 905,
                    948);
  covrtEmlRelationalInitFcn(chartInstance->c13_covrtInstance, 4U, 0U, 0U, 455,
    485, -2, 0U);
}

static void initSimStructsc13_zeabus_hydrophone_concrete
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c13_emlrt_update_log_1
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_d;
  int32_T c13_i;
  int32_T c13_localMin;
  real_T c13_d1;
  int32_T c13_i1;
  int32_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_d = muDoubleScalarFloor(c13_b_table[0U].SimMin * 131072.0);
    if (c13_d < 131072.0) {
      if (c13_d >= -131072.0) {
        c13_i = (int32_T)c13_d;
      } else {
        c13_i = -131072;
      }
    } else if (c13_d >= 131072.0) {
      c13_i = 131071;
    } else {
      c13_i = 0;
    }

    c13_localMin = c13_i;
    c13_d1 = muDoubleScalarFloor(c13_b_table[0U].SimMax * 131072.0);
    if (c13_d1 < 131072.0) {
      if (c13_d1 >= -131072.0) {
        c13_i1 = (int32_T)c13_d1;
      } else {
        c13_i1 = -131072;
      }
    } else if (c13_d1 >= 131072.0) {
      c13_i1 = 131071;
    } else {
      c13_i1 = 0;
    }

    c13_localMax = c13_i1;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in * 7.62939453125E-6;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin * 7.62939453125E-6;
    c13_b_table[0U].SimMax = (real_T)c13_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c13_in & 131071U) != 0U) {
      c13_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c13_in;
}

static int32_T c13_emlrt_update_log_2
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_d;
  int32_T c13_i;
  int32_T c13_localMin;
  real_T c13_d1;
  int32_T c13_i1;
  int32_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_d = muDoubleScalarFloor(c13_b_table[0U].SimMin * 131072.0);
    if (c13_d < 8.388608E+6) {
      if (c13_d >= -8.388608E+6) {
        c13_i = (int32_T)c13_d;
      } else {
        c13_i = -8388608;
      }
    } else if (c13_d >= 8.388608E+6) {
      c13_i = 8388607;
    } else {
      c13_i = 0;
    }

    c13_localMin = c13_i;
    c13_d1 = muDoubleScalarFloor(c13_b_table[0U].SimMax * 131072.0);
    if (c13_d1 < 8.388608E+6) {
      if (c13_d1 >= -8.388608E+6) {
        c13_i1 = (int32_T)c13_d1;
      } else {
        c13_i1 = -8388608;
      }
    } else if (c13_d1 >= 8.388608E+6) {
      c13_i1 = 8388607;
    } else {
      c13_i1 = 0;
    }

    c13_localMax = c13_i1;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in * 7.62939453125E-6;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin * 7.62939453125E-6;
    c13_b_table[0U].SimMax = (real_T)c13_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c13_in & 131071U) != 0U) {
      c13_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c13_in;
}

static uint8_T c13_emlrt_update_log_3
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_d;
  uint8_T c13_b_u;
  uint8_T c13_localMin;
  real_T c13_d1;
  uint8_T c13_u1;
  uint8_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_d = c13_b_table[0U].SimMin;
    if (c13_d < 128.0) {
      if (c13_d >= 0.0) {
        c13_b_u = (uint8_T)c13_d;
      } else {
        c13_b_u = 0U;
      }
    } else if (c13_d >= 128.0) {
      c13_b_u = 127U;
    } else {
      c13_b_u = 0U;
    }

    c13_localMin = c13_b_u;
    c13_d1 = c13_b_table[0U].SimMax;
    if (c13_d1 < 128.0) {
      if (c13_d1 >= 0.0) {
        c13_u1 = (uint8_T)c13_d1;
      } else {
        c13_u1 = 0U;
      }
    } else if (c13_d1 >= 128.0) {
      c13_u1 = 127U;
    } else {
      c13_u1 = 0U;
    }

    c13_localMax = c13_u1;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin;
    c13_b_table[0U].SimMax = (real_T)c13_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c13_in;
}

static int32_T c13_emlrt_update_log_4
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_d;
  int32_T c13_i;
  int32_T c13_localMin;
  real_T c13_d1;
  int32_T c13_i1;
  int32_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_d = muDoubleScalarFloor(c13_b_table[0U].SimMin * 131072.0);
    if (c13_d < 1.6777216E+7) {
      if (c13_d >= -1.6777216E+7) {
        c13_i = (int32_T)c13_d;
      } else {
        c13_i = -16777216;
      }
    } else if (c13_d >= 1.6777216E+7) {
      c13_i = 16777215;
    } else {
      c13_i = 0;
    }

    c13_localMin = c13_i;
    c13_d1 = muDoubleScalarFloor(c13_b_table[0U].SimMax * 131072.0);
    if (c13_d1 < 1.6777216E+7) {
      if (c13_d1 >= -1.6777216E+7) {
        c13_i1 = (int32_T)c13_d1;
      } else {
        c13_i1 = -16777216;
      }
    } else if (c13_d1 >= 1.6777216E+7) {
      c13_i1 = 16777215;
    } else {
      c13_i1 = 0;
    }

    c13_localMax = c13_i1;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in * 7.62939453125E-6;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin * 7.62939453125E-6;
    c13_b_table[0U].SimMax = (real_T)c13_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c13_in & 131071U) != 0U) {
      c13_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c13_in;
}

static uint8_T c13_emlrt_update_log_5
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_d;
  uint8_T c13_b_u;
  uint8_T c13_localMin;
  real_T c13_d1;
  uint8_T c13_u1;
  uint8_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_d = c13_b_table[0U].SimMin;
    if (c13_d < 256.0) {
      if (c13_d >= 0.0) {
        c13_b_u = (uint8_T)c13_d;
      } else {
        c13_b_u = 0U;
      }
    } else if (c13_d >= 256.0) {
      c13_b_u = MAX_uint8_T;
    } else {
      c13_b_u = 0U;
    }

    c13_localMin = c13_b_u;
    c13_d1 = c13_b_table[0U].SimMax;
    if (c13_d1 < 256.0) {
      if (c13_d1 >= 0.0) {
        c13_u1 = (uint8_T)c13_d1;
      } else {
        c13_u1 = 0U;
      }
    } else if (c13_d1 >= 256.0) {
      c13_u1 = MAX_uint8_T;
    } else {
      c13_u1 = 0U;
    }

    c13_localMax = c13_u1;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin;
    c13_b_table[0U].SimMax = (real_T)c13_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c13_in;
}

static boolean_T c13_emlrt_update_log_6
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c13_in, emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  boolean_T c13_localMin;
  boolean_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_localMin = (c13_b_table[0U].SimMin > 0.0);
    c13_localMax = (c13_b_table[0U].SimMax > 0.0);
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c13_in < (int32_T)c13_localMin) {
      c13_localMin = c13_in;
    }

    if ((int32_T)c13_in > (int32_T)c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin;
    c13_b_table[0U].SimMax = (real_T)c13_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c13_in;
}

static int32_T c13_emlrt_update_log_7
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_d;
  int32_T c13_i;
  int32_T c13_localMin;
  real_T c13_d1;
  int32_T c13_i1;
  int32_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_d = muDoubleScalarFloor(c13_b_table[0U].SimMin * 8.388608E+6);
    if (c13_d < 5.36870912E+8) {
      if (c13_d >= -5.36870912E+8) {
        c13_i = (int32_T)c13_d;
      } else {
        c13_i = -536870912;
      }
    } else if (c13_d >= 5.36870912E+8) {
      c13_i = 536870911;
    } else {
      c13_i = 0;
    }

    c13_localMin = c13_i;
    c13_d1 = muDoubleScalarFloor(c13_b_table[0U].SimMax * 8.388608E+6);
    if (c13_d1 < 5.36870912E+8) {
      if (c13_d1 >= -5.36870912E+8) {
        c13_i1 = (int32_T)c13_d1;
      } else {
        c13_i1 = -536870912;
      }
    } else if (c13_d1 >= 5.36870912E+8) {
      c13_i1 = 536870911;
    } else {
      c13_i1 = 0;
    }

    c13_localMax = c13_i1;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = (real_T)c13_in * 1.1920928955078125E-7;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = (real_T)c13_localMin * 1.1920928955078125E-7;
    c13_b_table[0U].SimMax = (real_T)c13_localMax * 1.1920928955078125E-7;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c13_in & 8388607U) != 0U) {
      c13_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c13_in;
}

static real_T c13_emlrt_update_log_8
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, real_T c13_in,
   emlrtLocationLoggingDataType c13_table[], int32_T c13_index)
{
  boolean_T c13_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c13_b_table;
  real_T c13_localMin;
  real_T c13_localMax;
  emlrtLocationLoggingHistogramType *c13_histTable;
  real_T c13_inDouble;
  real_T c13_significand;
  int32_T c13_exponent;
  (void)chartInstance;
  c13_isLoggingEnabledHere = (c13_index >= 0);
  if (c13_isLoggingEnabledHere) {
    c13_b_table = (emlrtLocationLoggingDataType *)&c13_table[c13_index];
    c13_localMin = c13_b_table[0U].SimMin;
    c13_localMax = c13_b_table[0U].SimMax;
    c13_histTable = c13_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c13_in < c13_localMin) {
      c13_localMin = c13_in;
    }

    if (c13_in > c13_localMax) {
      c13_localMax = c13_in;
    }

    /* Histogram logging. */
    c13_inDouble = c13_in;
    c13_histTable->TotalNumberOfValues++;
    if (c13_inDouble == 0.0) {
      c13_histTable->NumberOfZeros++;
    } else {
      c13_histTable->SimSum += c13_inDouble;
      if ((!muDoubleScalarIsInf(c13_inDouble)) && (!muDoubleScalarIsNaN
           (c13_inDouble))) {
        c13_significand = frexp(c13_inDouble, &c13_exponent);
        if (c13_exponent > 128) {
          c13_exponent = 128;
        }

        if (c13_exponent < -127) {
          c13_exponent = -127;
        }

        if (c13_significand < 0.0) {
          c13_histTable->NumberOfNegativeValues++;
          c13_histTable->HistogramOfNegativeValues[127 + c13_exponent]++;
        } else {
          c13_histTable->NumberOfPositiveValues++;
          c13_histTable->HistogramOfPositiveValues[127 + c13_exponent]++;
        }
      }
    }

    c13_b_table[0U].SimMin = c13_localMin;
    c13_b_table[0U].SimMax = c13_localMax;

    /* IsAlwaysInteger logging. */
    if (c13_in != muDoubleScalarFloor(c13_in)) {
      c13_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c13_in;
}

static void c13_emlrtInitVarDataTables
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c13_dataTables[18],
   emlrtLocationLoggingHistogramType c13_histTables[18])
{
  int32_T c13_i;
  int32_T c13_iH;
  (void)chartInstance;
  for (c13_i = 0; c13_i < 18; c13_i++) {
    c13_dataTables[c13_i].SimMin = rtInf;
    c13_dataTables[c13_i].SimMax = rtMinusInf;
    c13_dataTables[c13_i].OverflowWraps = 0;
    c13_dataTables[c13_i].Saturations = 0;
    c13_dataTables[c13_i].IsAlwaysInteger = true;
    c13_dataTables[c13_i].HistogramTable = &c13_histTables[c13_i];
    c13_histTables[c13_i].NumberOfZeros = 0.0;
    c13_histTables[c13_i].NumberOfPositiveValues = 0.0;
    c13_histTables[c13_i].NumberOfNegativeValues = 0.0;
    c13_histTables[c13_i].TotalNumberOfValues = 0.0;
    c13_histTables[c13_i].SimSum = 0.0;
    for (c13_iH = 0; c13_iH < 256; c13_iH++) {
      c13_histTables[c13_i].HistogramOfPositiveValues[c13_iH] = 0.0;
      c13_histTables[c13_i].HistogramOfNegativeValues[c13_iH] = 0.0;
    }
  }
}

const mxArray *sf_c13_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c13_nameCaptureInfo = NULL;
  c13_nameCaptureInfo = NULL;
  sf_mex_assign(&c13_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c13_nameCaptureInfo;
}

static int32_T c13_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_y, const char_T *c13_identifier)
{
  int32_T c13_c_y;
  emlrtMsgIdentifier c13_thisId;
  c13_thisId.fIdentifier = (const char *)c13_identifier;
  c13_thisId.fParent = NULL;
  c13_thisId.bParentIsCell = false;
  c13_c_y = c13_b_emlrt_marshallIn(chartInstance, c13_sp, sf_mex_dup(c13_b_y),
    &c13_thisId);
  sf_mex_destroy(&c13_b_y);
  return c13_c_y;
}

static int32_T c13_b_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId)
{
  int32_T c13_b_y;
  const mxArray *c13_mxFi = NULL;
  const mxArray *c13_mxInt = NULL;
  int32_T c13_i;
  (void)chartInstance;
  sf_mex_check_fi(c13_parentId, c13_b_u, false, 0U, NULL, c13_eml_mx,
                  c13_b_eml_mx);
  sf_mex_assign(&c13_mxFi, sf_mex_dup(c13_b_u), false);
  sf_mex_assign(&c13_mxInt, sf_mex_call(c13_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c13_mxFi)), false);
  sf_mex_import(c13_parentId, sf_mex_dup(c13_mxInt), &c13_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c13_mxFi);
  sf_mex_destroy(&c13_mxInt);
  c13_b_y = c13_i;
  sf_mex_destroy(&c13_mxFi);
  sf_mex_destroy(&c13_b_u);
  return c13_b_y;
}

static int32_T c13_c_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_acc, const char_T *c13_identifier,
   boolean_T *c13_svPtr)
{
  int32_T c13_b_y;
  emlrtMsgIdentifier c13_thisId;
  c13_thisId.fIdentifier = (const char *)c13_identifier;
  c13_thisId.fParent = NULL;
  c13_thisId.bParentIsCell = false;
  c13_b_y = c13_d_emlrt_marshallIn(chartInstance, c13_sp, sf_mex_dup(c13_b_acc),
    &c13_thisId, c13_svPtr);
  sf_mex_destroy(&c13_b_acc);
  return c13_b_y;
}

static int32_T c13_d_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId, boolean_T *c13_svPtr)
{
  int32_T c13_b_y;
  const mxArray *c13_mxFi = NULL;
  const mxArray *c13_mxInt = NULL;
  int32_T c13_i;
  (void)chartInstance;
  if (mxIsEmpty(c13_b_u)) {
    *c13_svPtr = false;
  } else {
    *c13_svPtr = true;
    sf_mex_check_fi(c13_parentId, c13_b_u, false, 0U, NULL, c13_eml_mx,
                    c13_c_eml_mx);
    sf_mex_assign(&c13_mxFi, sf_mex_dup(c13_b_u), false);
    sf_mex_assign(&c13_mxInt, sf_mex_call(c13_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c13_mxFi)), false);
    sf_mex_import(c13_parentId, sf_mex_dup(c13_mxInt), &c13_i, 1, 6, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c13_mxFi);
    sf_mex_destroy(&c13_mxInt);
    c13_b_y = c13_i;
  }

  sf_mex_destroy(&c13_mxFi);
  sf_mex_destroy(&c13_b_u);
  return c13_b_y;
}

static int32_T c13_e_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_avg, const char_T *c13_identifier,
   boolean_T *c13_svPtr)
{
  int32_T c13_b_y;
  emlrtMsgIdentifier c13_thisId;
  c13_thisId.fIdentifier = (const char *)c13_identifier;
  c13_thisId.fParent = NULL;
  c13_thisId.bParentIsCell = false;
  c13_b_y = c13_f_emlrt_marshallIn(chartInstance, c13_sp, sf_mex_dup(c13_b_avg),
    &c13_thisId, c13_svPtr);
  sf_mex_destroy(&c13_b_avg);
  return c13_b_y;
}

static int32_T c13_f_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId, boolean_T *c13_svPtr)
{
  int32_T c13_b_y;
  const mxArray *c13_mxFi = NULL;
  const mxArray *c13_mxInt = NULL;
  int32_T c13_i;
  (void)chartInstance;
  if (mxIsEmpty(c13_b_u)) {
    *c13_svPtr = false;
  } else {
    *c13_svPtr = true;
    sf_mex_check_fi(c13_parentId, c13_b_u, false, 0U, NULL, c13_eml_mx,
                    c13_b_eml_mx);
    sf_mex_assign(&c13_mxFi, sf_mex_dup(c13_b_u), false);
    sf_mex_assign(&c13_mxInt, sf_mex_call(c13_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c13_mxFi)), false);
    sf_mex_import(c13_parentId, sf_mex_dup(c13_mxInt), &c13_i, 1, 6, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c13_mxFi);
    sf_mex_destroy(&c13_mxInt);
    c13_b_y = c13_i;
  }

  sf_mex_destroy(&c13_mxFi);
  sf_mex_destroy(&c13_b_u);
  return c13_b_y;
}

static uint8_T c13_g_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_counter, const char_T
   *c13_identifier, boolean_T *c13_svPtr)
{
  uint8_T c13_b_y;
  emlrtMsgIdentifier c13_thisId;
  c13_thisId.fIdentifier = (const char *)c13_identifier;
  c13_thisId.fParent = NULL;
  c13_thisId.bParentIsCell = false;
  c13_b_y = c13_h_emlrt_marshallIn(chartInstance, c13_sp, sf_mex_dup
    (c13_b_counter), &c13_thisId, c13_svPtr);
  sf_mex_destroy(&c13_b_counter);
  return c13_b_y;
}

static uint8_T c13_h_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c13_sp, const mxArray *c13_b_u, const emlrtMsgIdentifier
   *c13_parentId, boolean_T *c13_svPtr)
{
  uint8_T c13_b_y;
  const mxArray *c13_mxFi = NULL;
  const mxArray *c13_mxInt = NULL;
  uint8_T c13_c_u;
  (void)chartInstance;
  if (mxIsEmpty(c13_b_u)) {
    *c13_svPtr = false;
  } else {
    *c13_svPtr = true;
    sf_mex_check_fi(c13_parentId, c13_b_u, false, 0U, NULL, c13_eml_mx,
                    c13_d_eml_mx);
    sf_mex_assign(&c13_mxFi, sf_mex_dup(c13_b_u), false);
    sf_mex_assign(&c13_mxInt, sf_mex_call(c13_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c13_mxFi)), false);
    sf_mex_import(c13_parentId, sf_mex_dup(c13_mxInt), &c13_c_u, 1, 3, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c13_mxFi);
    sf_mex_destroy(&c13_mxInt);
    c13_b_y = c13_c_u;
  }

  sf_mex_destroy(&c13_mxFi);
  sf_mex_destroy(&c13_b_u);
  return c13_b_y;
}

static uint8_T c13_i_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c13_b_is_active_c13_zeabus_hydrophone_concrete, const char_T *c13_identifier)
{
  uint8_T c13_b_y;
  emlrtMsgIdentifier c13_thisId;
  c13_thisId.fIdentifier = (const char *)c13_identifier;
  c13_thisId.fParent = NULL;
  c13_thisId.bParentIsCell = false;
  c13_b_y = c13_j_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c13_b_is_active_c13_zeabus_hydrophone_concrete), &c13_thisId);
  sf_mex_destroy(&c13_b_is_active_c13_zeabus_hydrophone_concrete);
  return c13_b_y;
}

static uint8_T c13_j_emlrt_marshallIn
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c13_b_u, const emlrtMsgIdentifier *c13_parentId)
{
  uint8_T c13_b_y;
  uint8_T c13_c_u;
  (void)chartInstance;
  sf_mex_import(c13_parentId, sf_mex_dup(c13_b_u), &c13_c_u, 1, 3, 0U, 0, 0U, 0);
  c13_b_y = c13_c_u;
  sf_mex_destroy(&c13_b_u);
  return c13_b_y;
}

static const mxArray *c13_chart_data_browse_helper
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c13_ssIdNumber)
{
  const mxArray *c13_mxData = NULL;
  int32_T c13_i;
  int32_T c13_i1;
  real_T c13_d;
  real_T c13_d1;
  c13_mxData = NULL;
  switch (c13_ssIdNumber) {
   case 4U:
    c13_i = *chartInstance->c13_u;
    c13_d = (real_T)c13_i * 7.62939453125E-6;
    sf_mex_assign(&c13_mxData, sf_mex_create("mxData", &c13_d, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 5U:
    c13_i1 = *chartInstance->c13_y;
    c13_d1 = (real_T)c13_i1 * 7.62939453125E-6;
    sf_mex_assign(&c13_mxData, sf_mex_create("mxData", &c13_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c13_mxData;
}

static int32_T c13__s32_shl_s32_(SFc13_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c13_b, int32_T c13_c, int32_T c13_EMLOvCount_src_loc,
  uint32_T c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T
  c13_length_src_loc)
{
  int32_T c13_a;
  int32_T c13_PICOffset;
  real_T c13_d;
  observerLogReadPIC(&c13_PICOffset);
  c13_a = c13_b << c13_c;
  if ((c13_b != c13_a >> c13_c) || ((uint32_T)c13_c > 31U)) {
    sf_data_overflow_error(chartInstance->S, c13_ssid_src_loc,
      c13_offset_src_loc, c13_length_src_loc);
    c13_d = 1.0;
    observerLog(c13_EMLOvCount_src_loc + c13_PICOffset, &c13_d, 1);
  }

  return c13_a;
}

static uint32_T c13__u32_add__(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c13_b, uint32_T c13_c, int32_T c13_EMLOvCount_src_loc,
  uint32_T c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T
  c13_length_src_loc)
{
  uint32_T c13_a;
  int32_T c13_PICOffset;
  real_T c13_d;
  observerLogReadPIC(&c13_PICOffset);
  c13_a = c13_b + c13_c;
  if (c13_a < c13_b) {
    sf_data_overflow_error(chartInstance->S, c13_ssid_src_loc,
      c13_offset_src_loc, c13_length_src_loc);
    c13_d = 1.0;
    observerLog(c13_EMLOvCount_src_loc + c13_PICOffset, &c13_d, 1);
  }

  return c13_a;
}

static uint8_T c13__u8_u32_(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c13_b, int32_T c13_EMLOvCount_src_loc, uint32_T
  c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T c13_length_src_loc)
{
  uint8_T c13_a;
  int32_T c13_PICOffset;
  real_T c13_d;
  observerLogReadPIC(&c13_PICOffset);
  c13_a = (uint8_T)c13_b;
  if (c13_a != c13_b) {
    sf_data_overflow_error(chartInstance->S, c13_ssid_src_loc,
      c13_offset_src_loc, c13_length_src_loc);
    c13_d = 1.0;
    observerLog(c13_EMLOvCount_src_loc + c13_PICOffset, &c13_d, 1);
  }

  return c13_a;
}

static int32_T c13__s32_add__(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c13_b, int32_T c13_c, int32_T c13_EMLOvCount_src_loc,
  uint32_T c13_ssid_src_loc, int32_T c13_offset_src_loc, int32_T
  c13_length_src_loc)
{
  int32_T c13_a;
  int32_T c13_PICOffset;
  real_T c13_d;
  observerLogReadPIC(&c13_PICOffset);
  c13_a = c13_b + c13_c;
  if (((c13_a ^ c13_b) & (c13_a ^ c13_c)) < 0) {
    sf_data_overflow_error(chartInstance->S, c13_ssid_src_loc,
      c13_offset_src_loc, c13_length_src_loc);
    c13_d = 1.0;
    observerLog(c13_EMLOvCount_src_loc + c13_PICOffset, &c13_d, 1);
  }

  return c13_a;
}

static void init_dsm_address_info(SFc13_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c13_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c13_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c13_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c13_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c13_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1201767455U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3387158271U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3170754769U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1421900040U);
}

mxArray *sf_c13_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c13_zeabus_hydrophone_concrete_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("early");
  mxArray *fallbackReason = mxCreateString("fixpt_minmax_logging");
  mxArray *hiddenFallbackType = mxCreateString("");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c13_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c13_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiDewcbAAEQMHEDMxAABrFA+I5TNCBdngYsrAHFJZUEqSLy4KNkzBUjnJeaC+Ym"
    "lFZ55aflg8y0YEOazYTGfEcl8Tqg4BHywp0y/iANIvwGSfhYC+gWArEpouMDCh3z7BRwo0w+xn5"
    "D7mVHcz8yQmJwM1neBAX+8MqLFKxOUD9KTw5DJUAC134GA+5nQ3C8Ac7xDjAOEEUuVcBiy8VGWP"
    "jjiY0ESND6Sh1V8WBCID3aU+IDwk/NL80pSiwZHvCgkQOMlcZDEiwJV3BFBIF400OIFxM8sjk9M"
    "LsksS41PNjSOr0pNTCotjs+oTCnKL8jIzwOK5uclF6WWpML8CQDUmzli"
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c13_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "sfcoMQwMlai0BppVMY0GPPD";
}

static void sf_opaque_initialize_c13_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c13_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c13_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c13_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c13_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c13_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c13_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc13_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c13_zeabus_hydrophone_concrete
      ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc13_zeabus_hydrophone_concrete
    ((SFc13_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c13_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c13_zeabus_hydrophone_concrete
      ((SFc13_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc13_zeabus_hydrophone_concrete
      ((SFc13_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c13_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [18] = {
    "eNrtV0tvI0UQbnuzWVaCyIeV9sIhNyJxCdoDe8PED7AUEy/OBpBApt1T9rTc0z30w0k48i+4rbR",
    "3zuyRGxckTvwD7vwCRPV4nJjxPNY4rMJjpPFMj7/6uqq+6poeUuv1CR57eDYfELKL19fwrJPFcT",
    "cd11bOxfMd8lY6fo4g6aIB1TQypPSQNIKPwSjhLFeyJycqF8blBDRIhthYaVvEZnjkBJezrpPM8",
    "5lPQs7CYaicCI7QlgYnUlwiW+zsAHnaXAOzXYDAhlq5adgVdHrlsbbnrRDYzLioLAQDduhi75bp",
    "O2F5LKBzAawnjaXosbn2bWiphZa9KAzTR2qGS6CKYsGpzI02pGYIMSbYwtM4wN8TZzGoLIyFVNs",
    "jCOkczDGfJZxKQpaTG/xjzCW1SnMqOpFoecN13wYC/emrAERJQtC3Iw10FisubbH+wy5G2pF0LK",
    "ANYzctZhvCV86Lf8bhHHRh3iYtNQdNp3AiCydNEtK5SNS6qpJ1mOURnFH9PkP9DASF1YuVY4YUd",
    "YJTtCiCQRJkz5xqPsf0FrK5qOcrs2rJuGghtqmCJWydOZSpcMXWZbJFhTCFsFMVH8McRMLappaW",
    "wxas+bhYq5hOsWoDTLIv8ZaSAV/TgjljVdTCcmsfH3+EnSLfuWtYT1rQE8ogb90aFkLgBGCg2Jl",
    "sMl0OacCNV6sClWpahSJm4mT7XOkZBlqy7K9D8BoUAiMzxexj7T41WOZlMJ/9Styyzx+S6z7/+k",
    "v0+aVd9nqwwlPL4SEr1+y89+vl89bxrrZ8L63YvZGZZydj53ENPH//sfndL+NvL959+4dHL3765",
    "tdt5g/vbfZe3EvHby4b0FV5zteqwmM/XPFrJ4f/4Qp/Ix2bCVP9J+d9QfnhURyf9T87/GAwaCd8",
    "3++W+3s34+/y+b7vhJdx0teMZr0gfWH7MXWL15jnf7zi725FPu6nzxfHb+9tZ/+gmdVxp8K+gXe",
    "Xmbr96/M3mtvZr6+DPP/v/Mn/O4Qyltj9TDarw3o69jaCcBLnrKc8/+sZ/xtL55ufNxc3X9xIHv",
    "6xesynt0OPZ+NUD/av0uNxhR73Mv3Qj5lyfjNwO3TZ/zLVhd4SXfZvxI9PK3Q5yOhykOzTRxR33",
    "XMYsXcejb4GOnZmFF4GuCMM8ctkxJRkGizs3cA+YVM78r/drbCr/Qfje5l996u2I6/Ybtv4Nv3+",
    "2OZ7JdvvSAbf2GKevxu/7XfbJvg/AK2Cf0I=",
    ""
  };

  static char newstr [1237] = "";
  newstr[0] = '\0';
  for (i = 0; i < 18; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c13_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c13_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(2923481342U));
  ssSetChecksum1(S,(2023318230U));
  ssSetChecksum2(S,(868297527U));
  ssSetChecksum3(S,(3850554809U));
}

static void mdlRTW_c13_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c13_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc13_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc13_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc13_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc13_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c13_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartEventFcn = NULL;
  chartInstance->S = S;
  chartInstance->chartInfo.dispatchToExportedFcn = NULL;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0,
    chartInstance->c13_JITStateAnimation,
    chartInstance->c13_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c13_zeabus_hydrophone_concrete(chartInstance);
}

void c13_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c13_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c13_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c13_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c13_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
