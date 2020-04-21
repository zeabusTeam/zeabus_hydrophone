/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c14_zeabus_hydrophone_concrete.h"
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
static const mxArray *c14_eml_mx;
static const mxArray *c14_b_eml_mx;
static const mxArray *c14_c_eml_mx;
static const mxArray *c14_d_eml_mx;
static emlrtRSInfo c14_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC4 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:594"    /* pathName */
};

static emlrtRSInfo c14_b_emlrtRSI = { 26,/* lineNo */
  "Hydrophone processing/ADC4 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:594"    /* pathName */
};

static emlrtRSInfo c14_c_emlrtRSI = { 41,/* lineNo */
  "Hydrophone processing/ADC4 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:594"    /* pathName */
};

static emlrtRSInfo c14_d_emlrtRSI = { 14,/* lineNo */
  "bitsra",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\bitsra.m"/* pathName */
};

static emlrtRSInfo c14_e_emlrtRSI = { 75,/* lineNo */
  "eml_fi_bitshift",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\eml_fi_bitshift.m"/* pathName */
};

static emlrtRSInfo c14_f_emlrtRSI = { 236,/* lineNo */
  "eml_fi_bitshift",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\eml_fi_bitshift.m"/* pathName */
};

/* Function Declarations */
static void initialize_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c14_update_jit_animation_state_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c14_do_animation_call_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c14_st);
static void finalize_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c14_emlrt_update_log_1
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static int32_T c14_emlrt_update_log_2
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static uint8_T c14_emlrt_update_log_3
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static int32_T c14_emlrt_update_log_4
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static uint8_T c14_emlrt_update_log_5
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static boolean_T c14_emlrt_update_log_6
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c14_in, emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static int32_T c14_emlrt_update_log_7
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static real_T c14_emlrt_update_log_8
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, real_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index);
static void c14_emlrtInitVarDataTables
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c14_dataTables[18],
   emlrtLocationLoggingHistogramType c14_histTables[18]);
static int32_T c14_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_y, const char_T *c14_identifier);
static int32_T c14_b_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId);
static int32_T c14_c_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_acc, const char_T *c14_identifier,
   boolean_T *c14_svPtr);
static int32_T c14_d_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId, boolean_T *c14_svPtr);
static int32_T c14_e_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_avg, const char_T *c14_identifier,
   boolean_T *c14_svPtr);
static int32_T c14_f_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId, boolean_T *c14_svPtr);
static uint8_T c14_g_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_counter, const char_T
   *c14_identifier, boolean_T *c14_svPtr);
static uint8_T c14_h_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId, boolean_T *c14_svPtr);
static uint8_T c14_i_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c14_b_is_active_c14_zeabus_hydrophone_concrete, const char_T *c14_identifier);
static uint8_T c14_j_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c14_b_u, const emlrtMsgIdentifier *c14_parentId);
static const mxArray *c14_chart_data_browse_helper
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c14_ssIdNumber);
static int32_T c14__s32_shl_s32_(SFc14_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c14_b, int32_T c14_c, int32_T c14_EMLOvCount_src_loc,
  uint32_T c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T
  c14_length_src_loc);
static uint32_T c14__u32_add__(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c14_b, uint32_T c14_c, int32_T c14_EMLOvCount_src_loc,
  uint32_T c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T
  c14_length_src_loc);
static uint8_T c14__u8_u32_(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c14_b, int32_T c14_EMLOvCount_src_loc, uint32_T
  c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T c14_length_src_loc);
static int32_T c14__s32_add__(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c14_b, int32_T c14_c, int32_T c14_EMLOvCount_src_loc,
  uint32_T c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T
  c14_length_src_loc);
static void init_dsm_address_info(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c14_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c14_st.tls = chartInstance->c14_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c14_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c14_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c14_acc_not_empty = false;
  chartInstance->c14_counter_not_empty = false;
  chartInstance->c14_avg_not_empty = false;
  chartInstance->c14_is_active_c14_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c14_d_eml_mx, sf_mex_call(&c14_st, "numerictype", 1U, 14U, 15,
    "SignednessBool", 3, false, 15, "Signedness", 15, "Unsigned", 15,
    "WordLength", 6, 7.0, 15, "FractionLength", 6, 0.0, 15, "BinaryPoint", 6,
    0.0, 15, "Slope", 6, 1.0, 15, "FixedExponent", 6, 0.0), true);
  sf_mex_assign(&c14_c_eml_mx, sf_mex_call(&c14_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 24.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c14_b_eml_mx, sf_mex_call(&c14_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c14_eml_mx, sf_mex_call(&c14_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c14_emlrtLocLogSimulated = false;
  c14_emlrtInitVarDataTables(chartInstance,
    chartInstance->c14_emlrtLocationLoggingDataTables,
    chartInstance->c14_emlrtLocLogHistTables);
}

static void initialize_params_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c14_update_jit_animation_state_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c14_do_animation_call_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c14_st;
  const mxArray *c14_b_y = NULL;
  const mxArray *c14_c_y = NULL;
  int32_T c14_b_u;
  const mxArray *c14_d_y = NULL;
  const mxArray *c14_e_y = NULL;
  int32_T c14_c_u;
  const mxArray *c14_f_y = NULL;
  const mxArray *c14_g_y = NULL;
  int32_T c14_d_u;
  const mxArray *c14_h_y = NULL;
  const mxArray *c14_i_y = NULL;
  uint8_T c14_e_u;
  const mxArray *c14_j_y = NULL;
  const mxArray *c14_k_y = NULL;
  c14_st = NULL;
  c14_st = NULL;
  c14_b_y = NULL;
  sf_mex_assign(&c14_b_y, sf_mex_createcellmatrix(5, 1), false);
  c14_c_y = NULL;
  c14_b_u = *chartInstance->c14_y;
  c14_d_y = NULL;
  sf_mex_assign(&c14_d_y, sf_mex_create("y", &c14_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c14_c_y, sf_mex_create_fi(sf_mex_dup(c14_eml_mx), sf_mex_dup
    (c14_b_eml_mx), "simulinkarray", c14_d_y, false, false), false);
  sf_mex_setcell(c14_b_y, 0, c14_c_y);
  c14_e_y = NULL;
  if (!chartInstance->c14_acc_not_empty) {
    sf_mex_assign(&c14_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c14_c_u = chartInstance->c14_acc;
    c14_f_y = NULL;
    sf_mex_assign(&c14_f_y, sf_mex_create("y", &c14_c_u, 6, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c14_e_y, sf_mex_create_fi(sf_mex_dup(c14_eml_mx), sf_mex_dup
      (c14_c_eml_mx), "simulinkarray", c14_f_y, true, false), false);
  }

  sf_mex_setcell(c14_b_y, 1, c14_e_y);
  c14_g_y = NULL;
  if (!chartInstance->c14_avg_not_empty) {
    sf_mex_assign(&c14_g_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c14_d_u = chartInstance->c14_avg;
    c14_h_y = NULL;
    sf_mex_assign(&c14_h_y, sf_mex_create("y", &c14_d_u, 6, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c14_g_y, sf_mex_create_fi(sf_mex_dup(c14_eml_mx), sf_mex_dup
      (c14_b_eml_mx), "simulinkarray", c14_h_y, true, false), false);
  }

  sf_mex_setcell(c14_b_y, 2, c14_g_y);
  c14_i_y = NULL;
  if (!chartInstance->c14_counter_not_empty) {
    sf_mex_assign(&c14_i_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c14_e_u = chartInstance->c14_counter;
    c14_j_y = NULL;
    sf_mex_assign(&c14_j_y, sf_mex_create("y", &c14_e_u, 3, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c14_i_y, sf_mex_create_fi(sf_mex_dup(c14_eml_mx), sf_mex_dup
      (c14_d_eml_mx), "simulinkarray", c14_j_y, true, false), false);
  }

  sf_mex_setcell(c14_b_y, 3, c14_i_y);
  c14_k_y = NULL;
  sf_mex_assign(&c14_k_y, sf_mex_create("y",
    &chartInstance->c14_is_active_c14_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c14_b_y, 4, c14_k_y);
  sf_mex_assign(&c14_st, c14_b_y, false);
  return c14_st;
}

static void set_sim_state_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c14_st)
{
  emlrtStack c14_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c14_b_u;
  c14_b_st.tls = chartInstance->c14_fEmlrtCtx;
  chartInstance->c14_doneDoubleBufferReInit = true;
  c14_b_u = sf_mex_dup(c14_st);
  *chartInstance->c14_y = c14_emlrt_marshallIn(chartInstance, &c14_b_st,
    sf_mex_dup(sf_mex_getcell(c14_b_u, 0)), "y");
  chartInstance->c14_acc = c14_c_emlrt_marshallIn(chartInstance, &c14_b_st,
    sf_mex_dup(sf_mex_getcell(c14_b_u, 1)), "acc",
    &chartInstance->c14_acc_not_empty);
  chartInstance->c14_avg = c14_e_emlrt_marshallIn(chartInstance, &c14_b_st,
    sf_mex_dup(sf_mex_getcell(c14_b_u, 2)), "avg",
    &chartInstance->c14_avg_not_empty);
  chartInstance->c14_counter = c14_g_emlrt_marshallIn(chartInstance, &c14_b_st,
    sf_mex_dup(sf_mex_getcell(c14_b_u, 3)), "counter",
    &chartInstance->c14_counter_not_empty);
  chartInstance->c14_is_active_c14_zeabus_hydrophone_concrete =
    c14_i_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c14_b_u, 4)),
    "is_active_c14_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c14_b_u);
  sf_mex_destroy(&c14_st);
}

static void finalize_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c14_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:594", /* mexFileName */
    "Thu Apr 16 10:58:08 2020",        /* timestamp */
    "",                                /* buildDir */
    2,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c14_emlrtLocationLoggingFunctionInfoTable[2] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      15                               /* numInstrPoints */
    }, { "fi_div_by_shift",            /* fcnName */
      79,                              /* fcnId */
      3                                /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c14_emlrtLocationInfo[21] = { { 1,/* MxInfoID */
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

  const int32_T c14_emlrtLocationLoggingFieldCounts[18] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c14_RuntimeVar);
  if (chartInstance->c14_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:594");
    emlrtLocationLoggingPushLog(&c14_emlrtLocationLoggingFileInfo,
      c14_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c14_emlrtLocationLoggingDataTables, c14_emlrtLocationInfo,
      NULL, 0U, c14_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:594");
  }

  sf_mex_destroy(&c14_eml_mx);
  sf_mex_destroy(&c14_b_eml_mx);
  sf_mex_destroy(&c14_c_eml_mx);
  sf_mex_destroy(&c14_d_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c14_covrtInstance);
}

static void sf_gateway_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c14_PICOffset;
  int32_T c14_b_u;
  int32_T c14_varargin_1;
  int32_T c14_b_varargin_1;
  int32_T c14_var1;
  int32_T c14_hfi;
  int32_T c14_c_u;
  int32_T c14_a0;
  int32_T c14_b0;
  int32_T c14_i;
  real_T c14_d;
  int32_T c14_i1;
  real_T c14_d1;
  real_T c14_d2;
  real_T c14_d3;
  int32_T c14_i2;
  int32_T c14_i3;
  int32_T c14_i4;
  real_T c14_d4;
  real_T c14_d5;
  int32_T c14_c;
  int32_T c14_i5;
  real_T c14_d6;
  real_T c14_d7;
  int32_T c14_i6;
  uint8_T c14_b_a0;
  uint8_T c14_b_c;
  uint8_T c14_d_u;
  real_T c14_d8;
  uint8_T c14_c_a0;
  uint8_T c14_a;
  uint8_T c14_d_a0;
  uint8_T c14_a1;
  uint8_T c14_b_a1;
  boolean_T c14_c_c;
  int32_T c14_i7;
  int32_T c14_i8;
  real_T c14_d9;
  int32_T c14_c_varargin_1;
  int32_T c14_b_a;
  int32_T c14_d_varargin_1;
  int32_T c14_b_var1;
  int32_T c14_b_hfi;
  int32_T c14_b_y;
  int32_T c14_i9;
  real_T c14_d10;
  real_T c14_d11;
  int32_T c14_ain;
  int32_T c14_b_ain;
  int32_T c14_c_a;
  int32_T c14_e_varargin_1;
  int32_T c14_i10;
  int32_T c14_d_c;
  int32_T c14_cout;
  int32_T c14_c_y;
  int32_T c14_i11;
  real_T c14_d12;
  real_T c14_d13;
  int32_T c14_i12;
  observerLogReadPIC(&c14_PICOffset);
  chartInstance->c14_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c14_covrtInstance, 0U, (real_T)
                    *chartInstance->c14_u);
  chartInstance->c14_sfEvent = CALL_EVENT;
  c14_b_u = *chartInstance->c14_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c14_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c14_emlrt_update_log_1(chartInstance, c14_b_u,
    chartInstance->c14_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c14_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c14_covrtInstance, 4U, 0, 2);
  c14_varargin_1 = c14_b_u;
  c14_b_varargin_1 = c14_varargin_1;
  c14_var1 = c14_b_varargin_1;
  c14_hfi = c14_var1;
  c14_c_u = c14_emlrt_update_log_1(chartInstance, c14_hfi,
    chartInstance->c14_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c14_covrtInstance, 4U, 0, 0,
                     !chartInstance->c14_acc_not_empty)) {
    chartInstance->c14_acc = c14_emlrt_update_log_2(chartInstance, 0,
      chartInstance->c14_emlrtLocationLoggingDataTables, 2);
    chartInstance->c14_acc_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c14_covrtInstance, 4U, 0, 1,
                     !chartInstance->c14_counter_not_empty)) {
    chartInstance->c14_counter = c14_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c14_emlrtLocationLoggingDataTables, 3);
    chartInstance->c14_counter_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c14_covrtInstance, 4U, 0, 2,
                     !chartInstance->c14_avg_not_empty)) {
    chartInstance->c14_avg = c14_emlrt_update_log_1(chartInstance, 0,
      chartInstance->c14_emlrtLocationLoggingDataTables, 4);
    chartInstance->c14_avg_not_empty = true;
  }

  c14_a0 = chartInstance->c14_acc;
  c14_b0 = c14_c_u;
  c14_i = c14_a0;
  if (c14_i > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c14_d = 1.0;
    observerLog(177 + c14_PICOffset, &c14_d, 1);
  }

  if (c14_i < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c14_d1 = 1.0;
    observerLog(177 + c14_PICOffset, &c14_d1, 1);
  }

  c14_i1 = c14_b0;
  if (c14_i1 > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c14_d2 = 1.0;
    observerLog(180 + c14_PICOffset, &c14_d2, 1);
  }

  if (c14_i1 < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c14_d3 = 1.0;
    observerLog(180 + c14_PICOffset, &c14_d3, 1);
  }

  if ((c14_i & 16777216) != 0) {
    c14_i2 = c14_i | -16777216;
  } else {
    c14_i2 = c14_i & 16777215;
  }

  if ((c14_i1 & 16777216) != 0) {
    c14_i3 = c14_i1 | -16777216;
  } else {
    c14_i3 = c14_i1 & 16777215;
  }

  c14_i4 = c14__s32_add__(chartInstance, c14_i2, c14_i3, 179, 1U, 380, 7);
  if (c14_i4 > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c14_d4 = 1.0;
    observerLog(205 + c14_PICOffset, &c14_d4, 1);
  }

  if (c14_i4 < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c14_d5 = 1.0;
    observerLog(205 + c14_PICOffset, &c14_d5, 1);
  }

  if ((c14_i4 & 16777216) != 0) {
    c14_c = c14_i4 | -16777216;
  } else {
    c14_c = c14_i4 & 16777215;
  }

  c14_i5 = c14_emlrt_update_log_4(chartInstance, c14_c,
    chartInstance->c14_emlrtLocationLoggingDataTables, 6);
  if (c14_i5 > 8388607) {
    sf_data_overflow_error(chartInstance->S, 1U, 371, 16);
    c14_d6 = 1.0;
    observerLog(185 + c14_PICOffset, &c14_d6, 1);
  }

  if (c14_i5 < -8388608) {
    sf_data_overflow_error(chartInstance->S, 1U, 371, 16);
    c14_d7 = 1.0;
    observerLog(185 + c14_PICOffset, &c14_d7, 1);
  }

  if ((c14_i5 & 8388608) != 0) {
    c14_i6 = c14_i5 | -8388608;
  } else {
    c14_i6 = c14_i5 & 8388607;
  }

  chartInstance->c14_acc = c14_emlrt_update_log_2(chartInstance, c14_i6,
    chartInstance->c14_emlrtLocationLoggingDataTables, 5);
  c14_b_a0 = chartInstance->c14_counter;
  c14_b_c = c14__u8_u32_(chartInstance, c14__u32_add__(chartInstance, (uint32_T)
    c14_b_a0, 1U, 187, 1U, 421, 28), 186, 1U, 421, 28);
  c14_d_u = c14_emlrt_update_log_5(chartInstance, c14_b_c,
    chartInstance->c14_emlrtLocationLoggingDataTables, 8);
  if (c14_d_u > 127) {
    sf_data_overflow_error(chartInstance->S, 1U, 408, 41);
    c14_d8 = 1.0;
    observerLog(189 + c14_PICOffset, &c14_d8, 1);
  }

  chartInstance->c14_counter = c14_emlrt_update_log_3(chartInstance, (uint8_T)
    (c14_d_u & 127), chartInstance->c14_emlrtLocationLoggingDataTables, 7);
  c14_c_a0 = chartInstance->c14_counter;
  c14_a = c14_c_a0;
  c14_d_a0 = c14_a;
  c14_a1 = c14_d_a0;
  c14_b_a1 = c14_a1;
  c14_c_c = (c14_b_a1 == 64);
  c14_i7 = 64 - (int8_T)chartInstance->c14_counter;
  if (c14_i7 > 127) {
    c14_i7 = 127;
  } else {
    if (c14_i7 < -128) {
      c14_i7 = -128;
    }
  }

  c14_i8 = (int8_T)chartInstance->c14_counter - 64;
  if (c14_i8 > 127) {
    c14_i8 = 127;
  } else {
    if (c14_i8 < -128) {
      c14_i8 = -128;
    }
  }

  if ((int8_T)chartInstance->c14_counter < 64) {
    c14_d9 = (real_T)((int8_T)c14_i7 <= 1);
  } else if ((int8_T)chartInstance->c14_counter > 64) {
    if ((int8_T)c14_i8 <= 1) {
      c14_d9 = 3.0;
    } else {
      c14_d9 = 0.0;
    }
  } else {
    c14_d9 = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c14_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c14_covrtInstance,
        4U, 0U, 0U, c14_d9, 0.0, -2, 0U, (int32_T)c14_emlrt_update_log_6
        (chartInstance, c14_c_c,
         chartInstance->c14_emlrtLocationLoggingDataTables, 9)))) {
    chartInstance->c14_counter = c14_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c14_emlrtLocationLoggingDataTables, 10);
    c14_b_a = chartInstance->c14_acc;
    c14_emlrt_update_log_8(chartInstance, 6.0,
      chartInstance->c14_emlrtLocationLoggingDataTables, 17);

    /* logging input variable 'a' for function 'fi_div_by_shift' */
    c14_emlrt_update_log_2(chartInstance, c14_b_a,
      chartInstance->c14_emlrtLocationLoggingDataTables, 15);
    covrtEmlFcnEval(chartInstance->c14_covrtInstance, 4U, 0, 1);
    covrtEmlIfEval(chartInstance->c14_covrtInstance, 4U, 0, 4, true);
    c14_i9 = c14__s32_shl_s32_(chartInstance, c14_b_a, 6, 194, 1U, 868, 18);
    if (c14_i9 > 536870911) {
      sf_data_overflow_error(chartInstance->S, 1U, 868, 18);
      c14_d10 = 1.0;
      observerLog(202 + c14_PICOffset, &c14_d10, 1);
    }

    if (c14_i9 < -536870912) {
      sf_data_overflow_error(chartInstance->S, 1U, 868, 18);
      c14_d11 = 1.0;
      observerLog(202 + c14_PICOffset, &c14_d11, 1);
    }

    if ((c14_i9 & 536870912) != 0) {
      c14_ain = c14_i9 | -536870912;
    } else {
      c14_ain = c14_i9 & 536870911;
    }

    c14_b_ain = c14_ain;
    c14_c_a = c14_b_ain;
    c14_e_varargin_1 = c14_c_a;
    c14_i10 = c14_e_varargin_1 >> 6;
    if ((c14_i10 & 536870912) != 0) {
      c14_d_c = c14_i10 | -536870912;
    } else {
      c14_d_c = c14_i10 & 536870911;
    }

    c14_cout = c14_d_c;
    c14_c_y = c14_emlrt_update_log_7(chartInstance, c14_cout,
      chartInstance->c14_emlrtLocationLoggingDataTables, 16);
    c14_i11 = c14_emlrt_update_log_7(chartInstance, c14_c_y,
      chartInstance->c14_emlrtLocationLoggingDataTables, 12) >> 6;
    if (c14_i11 > 131071) {
      sf_data_overflow_error(chartInstance->S, 1U, 512, 32);
      c14_d12 = 1.0;
      observerLog(200 + c14_PICOffset, &c14_d12, 1);
    }

    if (c14_i11 < -131072) {
      sf_data_overflow_error(chartInstance->S, 1U, 512, 32);
      c14_d13 = 1.0;
      observerLog(200 + c14_PICOffset, &c14_d13, 1);
    }

    if ((c14_i11 & 131072) != 0) {
      c14_i12 = c14_i11 | -131072;
    } else {
      c14_i12 = c14_i11 & 131071;
    }

    chartInstance->c14_avg = c14_emlrt_update_log_1(chartInstance, c14_i12,
      chartInstance->c14_emlrtLocationLoggingDataTables, 11);
    chartInstance->c14_acc = c14_emlrt_update_log_2(chartInstance, 0,
      chartInstance->c14_emlrtLocationLoggingDataTables, 13);
  }

  c14_c_varargin_1 = chartInstance->c14_avg;
  c14_d_varargin_1 = c14_c_varargin_1;
  c14_b_var1 = c14_d_varargin_1;
  c14_b_hfi = c14_b_var1;
  c14_b_y = c14_emlrt_update_log_1(chartInstance, c14_b_hfi,
    chartInstance->c14_emlrtLocationLoggingDataTables, 14);
  *chartInstance->c14_y = c14_b_y;
  c14_do_animation_call_c14_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c14_covrtInstance, 1U, (real_T)
                    *chartInstance->c14_y);
}

static void mdl_start_c14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c14_decisionTxtStartIdx = 0U;
  static const uint32_T c14_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c14_chart_data_browse_helper);
  chartInstance->c14_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c14_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c14_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c14_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c14_decisionTxtStartIdx, &c14_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c14_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c14_covrtInstance, "", 4U, 0U, 3U, 0U, 5U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 598);
  covrtEmlFcnInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 1U,
                     "fi_div_by_shift", 602, -1, 952);
  covrtEmlFcnInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 2U, "get_fimath",
                     954, -1, 1208);
  covrtEmlIfInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 0U, 155, 171, -1,
                    209);
  covrtEmlIfInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 1U, 210, 230, -1,
                    270);
  covrtEmlIfInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 2U, 271, 287, -1,
                    325);
  covrtEmlIfInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 3U, 451, 485, -1,
                    565);
  covrtEmlIfInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 4U, 678, 690, 905,
                    948);
  covrtEmlRelationalInitFcn(chartInstance->c14_covrtInstance, 4U, 0U, 0U, 455,
    485, -2, 0U);
}

static void initSimStructsc14_zeabus_hydrophone_concrete
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c14_emlrt_update_log_1
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_d;
  int32_T c14_i;
  int32_T c14_localMin;
  real_T c14_d1;
  int32_T c14_i1;
  int32_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_d = muDoubleScalarFloor(c14_b_table[0U].SimMin * 131072.0);
    if (c14_d < 131072.0) {
      if (c14_d >= -131072.0) {
        c14_i = (int32_T)c14_d;
      } else {
        c14_i = -131072;
      }
    } else if (c14_d >= 131072.0) {
      c14_i = 131071;
    } else {
      c14_i = 0;
    }

    c14_localMin = c14_i;
    c14_d1 = muDoubleScalarFloor(c14_b_table[0U].SimMax * 131072.0);
    if (c14_d1 < 131072.0) {
      if (c14_d1 >= -131072.0) {
        c14_i1 = (int32_T)c14_d1;
      } else {
        c14_i1 = -131072;
      }
    } else if (c14_d1 >= 131072.0) {
      c14_i1 = 131071;
    } else {
      c14_i1 = 0;
    }

    c14_localMax = c14_i1;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in * 7.62939453125E-6;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin * 7.62939453125E-6;
    c14_b_table[0U].SimMax = (real_T)c14_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c14_in & 131071U) != 0U) {
      c14_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c14_in;
}

static int32_T c14_emlrt_update_log_2
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_d;
  int32_T c14_i;
  int32_T c14_localMin;
  real_T c14_d1;
  int32_T c14_i1;
  int32_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_d = muDoubleScalarFloor(c14_b_table[0U].SimMin * 131072.0);
    if (c14_d < 8.388608E+6) {
      if (c14_d >= -8.388608E+6) {
        c14_i = (int32_T)c14_d;
      } else {
        c14_i = -8388608;
      }
    } else if (c14_d >= 8.388608E+6) {
      c14_i = 8388607;
    } else {
      c14_i = 0;
    }

    c14_localMin = c14_i;
    c14_d1 = muDoubleScalarFloor(c14_b_table[0U].SimMax * 131072.0);
    if (c14_d1 < 8.388608E+6) {
      if (c14_d1 >= -8.388608E+6) {
        c14_i1 = (int32_T)c14_d1;
      } else {
        c14_i1 = -8388608;
      }
    } else if (c14_d1 >= 8.388608E+6) {
      c14_i1 = 8388607;
    } else {
      c14_i1 = 0;
    }

    c14_localMax = c14_i1;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in * 7.62939453125E-6;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin * 7.62939453125E-6;
    c14_b_table[0U].SimMax = (real_T)c14_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c14_in & 131071U) != 0U) {
      c14_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c14_in;
}

static uint8_T c14_emlrt_update_log_3
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_d;
  uint8_T c14_b_u;
  uint8_T c14_localMin;
  real_T c14_d1;
  uint8_T c14_u1;
  uint8_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_d = c14_b_table[0U].SimMin;
    if (c14_d < 128.0) {
      if (c14_d >= 0.0) {
        c14_b_u = (uint8_T)c14_d;
      } else {
        c14_b_u = 0U;
      }
    } else if (c14_d >= 128.0) {
      c14_b_u = 127U;
    } else {
      c14_b_u = 0U;
    }

    c14_localMin = c14_b_u;
    c14_d1 = c14_b_table[0U].SimMax;
    if (c14_d1 < 128.0) {
      if (c14_d1 >= 0.0) {
        c14_u1 = (uint8_T)c14_d1;
      } else {
        c14_u1 = 0U;
      }
    } else if (c14_d1 >= 128.0) {
      c14_u1 = 127U;
    } else {
      c14_u1 = 0U;
    }

    c14_localMax = c14_u1;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin;
    c14_b_table[0U].SimMax = (real_T)c14_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c14_in;
}

static int32_T c14_emlrt_update_log_4
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_d;
  int32_T c14_i;
  int32_T c14_localMin;
  real_T c14_d1;
  int32_T c14_i1;
  int32_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_d = muDoubleScalarFloor(c14_b_table[0U].SimMin * 131072.0);
    if (c14_d < 1.6777216E+7) {
      if (c14_d >= -1.6777216E+7) {
        c14_i = (int32_T)c14_d;
      } else {
        c14_i = -16777216;
      }
    } else if (c14_d >= 1.6777216E+7) {
      c14_i = 16777215;
    } else {
      c14_i = 0;
    }

    c14_localMin = c14_i;
    c14_d1 = muDoubleScalarFloor(c14_b_table[0U].SimMax * 131072.0);
    if (c14_d1 < 1.6777216E+7) {
      if (c14_d1 >= -1.6777216E+7) {
        c14_i1 = (int32_T)c14_d1;
      } else {
        c14_i1 = -16777216;
      }
    } else if (c14_d1 >= 1.6777216E+7) {
      c14_i1 = 16777215;
    } else {
      c14_i1 = 0;
    }

    c14_localMax = c14_i1;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in * 7.62939453125E-6;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin * 7.62939453125E-6;
    c14_b_table[0U].SimMax = (real_T)c14_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c14_in & 131071U) != 0U) {
      c14_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c14_in;
}

static uint8_T c14_emlrt_update_log_5
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_d;
  uint8_T c14_b_u;
  uint8_T c14_localMin;
  real_T c14_d1;
  uint8_T c14_u1;
  uint8_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_d = c14_b_table[0U].SimMin;
    if (c14_d < 256.0) {
      if (c14_d >= 0.0) {
        c14_b_u = (uint8_T)c14_d;
      } else {
        c14_b_u = 0U;
      }
    } else if (c14_d >= 256.0) {
      c14_b_u = MAX_uint8_T;
    } else {
      c14_b_u = 0U;
    }

    c14_localMin = c14_b_u;
    c14_d1 = c14_b_table[0U].SimMax;
    if (c14_d1 < 256.0) {
      if (c14_d1 >= 0.0) {
        c14_u1 = (uint8_T)c14_d1;
      } else {
        c14_u1 = 0U;
      }
    } else if (c14_d1 >= 256.0) {
      c14_u1 = MAX_uint8_T;
    } else {
      c14_u1 = 0U;
    }

    c14_localMax = c14_u1;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin;
    c14_b_table[0U].SimMax = (real_T)c14_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c14_in;
}

static boolean_T c14_emlrt_update_log_6
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c14_in, emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  boolean_T c14_localMin;
  boolean_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_localMin = (c14_b_table[0U].SimMin > 0.0);
    c14_localMax = (c14_b_table[0U].SimMax > 0.0);
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c14_in < (int32_T)c14_localMin) {
      c14_localMin = c14_in;
    }

    if ((int32_T)c14_in > (int32_T)c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin;
    c14_b_table[0U].SimMax = (real_T)c14_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c14_in;
}

static int32_T c14_emlrt_update_log_7
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_d;
  int32_T c14_i;
  int32_T c14_localMin;
  real_T c14_d1;
  int32_T c14_i1;
  int32_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_d = muDoubleScalarFloor(c14_b_table[0U].SimMin * 8.388608E+6);
    if (c14_d < 5.36870912E+8) {
      if (c14_d >= -5.36870912E+8) {
        c14_i = (int32_T)c14_d;
      } else {
        c14_i = -536870912;
      }
    } else if (c14_d >= 5.36870912E+8) {
      c14_i = 536870911;
    } else {
      c14_i = 0;
    }

    c14_localMin = c14_i;
    c14_d1 = muDoubleScalarFloor(c14_b_table[0U].SimMax * 8.388608E+6);
    if (c14_d1 < 5.36870912E+8) {
      if (c14_d1 >= -5.36870912E+8) {
        c14_i1 = (int32_T)c14_d1;
      } else {
        c14_i1 = -536870912;
      }
    } else if (c14_d1 >= 5.36870912E+8) {
      c14_i1 = 536870911;
    } else {
      c14_i1 = 0;
    }

    c14_localMax = c14_i1;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = (real_T)c14_in * 1.1920928955078125E-7;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = (real_T)c14_localMin * 1.1920928955078125E-7;
    c14_b_table[0U].SimMax = (real_T)c14_localMax * 1.1920928955078125E-7;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c14_in & 8388607U) != 0U) {
      c14_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c14_in;
}

static real_T c14_emlrt_update_log_8
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, real_T c14_in,
   emlrtLocationLoggingDataType c14_table[], int32_T c14_index)
{
  boolean_T c14_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c14_b_table;
  real_T c14_localMin;
  real_T c14_localMax;
  emlrtLocationLoggingHistogramType *c14_histTable;
  real_T c14_inDouble;
  real_T c14_significand;
  int32_T c14_exponent;
  (void)chartInstance;
  c14_isLoggingEnabledHere = (c14_index >= 0);
  if (c14_isLoggingEnabledHere) {
    c14_b_table = (emlrtLocationLoggingDataType *)&c14_table[c14_index];
    c14_localMin = c14_b_table[0U].SimMin;
    c14_localMax = c14_b_table[0U].SimMax;
    c14_histTable = c14_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c14_in < c14_localMin) {
      c14_localMin = c14_in;
    }

    if (c14_in > c14_localMax) {
      c14_localMax = c14_in;
    }

    /* Histogram logging. */
    c14_inDouble = c14_in;
    c14_histTable->TotalNumberOfValues++;
    if (c14_inDouble == 0.0) {
      c14_histTable->NumberOfZeros++;
    } else {
      c14_histTable->SimSum += c14_inDouble;
      if ((!muDoubleScalarIsInf(c14_inDouble)) && (!muDoubleScalarIsNaN
           (c14_inDouble))) {
        c14_significand = frexp(c14_inDouble, &c14_exponent);
        if (c14_exponent > 128) {
          c14_exponent = 128;
        }

        if (c14_exponent < -127) {
          c14_exponent = -127;
        }

        if (c14_significand < 0.0) {
          c14_histTable->NumberOfNegativeValues++;
          c14_histTable->HistogramOfNegativeValues[127 + c14_exponent]++;
        } else {
          c14_histTable->NumberOfPositiveValues++;
          c14_histTable->HistogramOfPositiveValues[127 + c14_exponent]++;
        }
      }
    }

    c14_b_table[0U].SimMin = c14_localMin;
    c14_b_table[0U].SimMax = c14_localMax;

    /* IsAlwaysInteger logging. */
    if (c14_in != muDoubleScalarFloor(c14_in)) {
      c14_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c14_in;
}

static void c14_emlrtInitVarDataTables
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c14_dataTables[18],
   emlrtLocationLoggingHistogramType c14_histTables[18])
{
  int32_T c14_i;
  int32_T c14_iH;
  (void)chartInstance;
  for (c14_i = 0; c14_i < 18; c14_i++) {
    c14_dataTables[c14_i].SimMin = rtInf;
    c14_dataTables[c14_i].SimMax = rtMinusInf;
    c14_dataTables[c14_i].OverflowWraps = 0;
    c14_dataTables[c14_i].Saturations = 0;
    c14_dataTables[c14_i].IsAlwaysInteger = true;
    c14_dataTables[c14_i].HistogramTable = &c14_histTables[c14_i];
    c14_histTables[c14_i].NumberOfZeros = 0.0;
    c14_histTables[c14_i].NumberOfPositiveValues = 0.0;
    c14_histTables[c14_i].NumberOfNegativeValues = 0.0;
    c14_histTables[c14_i].TotalNumberOfValues = 0.0;
    c14_histTables[c14_i].SimSum = 0.0;
    for (c14_iH = 0; c14_iH < 256; c14_iH++) {
      c14_histTables[c14_i].HistogramOfPositiveValues[c14_iH] = 0.0;
      c14_histTables[c14_i].HistogramOfNegativeValues[c14_iH] = 0.0;
    }
  }
}

const mxArray *sf_c14_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c14_nameCaptureInfo = NULL;
  c14_nameCaptureInfo = NULL;
  sf_mex_assign(&c14_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c14_nameCaptureInfo;
}

static int32_T c14_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_y, const char_T *c14_identifier)
{
  int32_T c14_c_y;
  emlrtMsgIdentifier c14_thisId;
  c14_thisId.fIdentifier = (const char *)c14_identifier;
  c14_thisId.fParent = NULL;
  c14_thisId.bParentIsCell = false;
  c14_c_y = c14_b_emlrt_marshallIn(chartInstance, c14_sp, sf_mex_dup(c14_b_y),
    &c14_thisId);
  sf_mex_destroy(&c14_b_y);
  return c14_c_y;
}

static int32_T c14_b_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId)
{
  int32_T c14_b_y;
  const mxArray *c14_mxFi = NULL;
  const mxArray *c14_mxInt = NULL;
  int32_T c14_i;
  (void)chartInstance;
  sf_mex_check_fi(c14_parentId, c14_b_u, false, 0U, NULL, c14_eml_mx,
                  c14_b_eml_mx);
  sf_mex_assign(&c14_mxFi, sf_mex_dup(c14_b_u), false);
  sf_mex_assign(&c14_mxInt, sf_mex_call(c14_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c14_mxFi)), false);
  sf_mex_import(c14_parentId, sf_mex_dup(c14_mxInt), &c14_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c14_mxFi);
  sf_mex_destroy(&c14_mxInt);
  c14_b_y = c14_i;
  sf_mex_destroy(&c14_mxFi);
  sf_mex_destroy(&c14_b_u);
  return c14_b_y;
}

static int32_T c14_c_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_acc, const char_T *c14_identifier,
   boolean_T *c14_svPtr)
{
  int32_T c14_b_y;
  emlrtMsgIdentifier c14_thisId;
  c14_thisId.fIdentifier = (const char *)c14_identifier;
  c14_thisId.fParent = NULL;
  c14_thisId.bParentIsCell = false;
  c14_b_y = c14_d_emlrt_marshallIn(chartInstance, c14_sp, sf_mex_dup(c14_b_acc),
    &c14_thisId, c14_svPtr);
  sf_mex_destroy(&c14_b_acc);
  return c14_b_y;
}

static int32_T c14_d_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId, boolean_T *c14_svPtr)
{
  int32_T c14_b_y;
  const mxArray *c14_mxFi = NULL;
  const mxArray *c14_mxInt = NULL;
  int32_T c14_i;
  (void)chartInstance;
  if (mxIsEmpty(c14_b_u)) {
    *c14_svPtr = false;
  } else {
    *c14_svPtr = true;
    sf_mex_check_fi(c14_parentId, c14_b_u, false, 0U, NULL, c14_eml_mx,
                    c14_c_eml_mx);
    sf_mex_assign(&c14_mxFi, sf_mex_dup(c14_b_u), false);
    sf_mex_assign(&c14_mxInt, sf_mex_call(c14_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c14_mxFi)), false);
    sf_mex_import(c14_parentId, sf_mex_dup(c14_mxInt), &c14_i, 1, 6, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c14_mxFi);
    sf_mex_destroy(&c14_mxInt);
    c14_b_y = c14_i;
  }

  sf_mex_destroy(&c14_mxFi);
  sf_mex_destroy(&c14_b_u);
  return c14_b_y;
}

static int32_T c14_e_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_avg, const char_T *c14_identifier,
   boolean_T *c14_svPtr)
{
  int32_T c14_b_y;
  emlrtMsgIdentifier c14_thisId;
  c14_thisId.fIdentifier = (const char *)c14_identifier;
  c14_thisId.fParent = NULL;
  c14_thisId.bParentIsCell = false;
  c14_b_y = c14_f_emlrt_marshallIn(chartInstance, c14_sp, sf_mex_dup(c14_b_avg),
    &c14_thisId, c14_svPtr);
  sf_mex_destroy(&c14_b_avg);
  return c14_b_y;
}

static int32_T c14_f_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId, boolean_T *c14_svPtr)
{
  int32_T c14_b_y;
  const mxArray *c14_mxFi = NULL;
  const mxArray *c14_mxInt = NULL;
  int32_T c14_i;
  (void)chartInstance;
  if (mxIsEmpty(c14_b_u)) {
    *c14_svPtr = false;
  } else {
    *c14_svPtr = true;
    sf_mex_check_fi(c14_parentId, c14_b_u, false, 0U, NULL, c14_eml_mx,
                    c14_b_eml_mx);
    sf_mex_assign(&c14_mxFi, sf_mex_dup(c14_b_u), false);
    sf_mex_assign(&c14_mxInt, sf_mex_call(c14_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c14_mxFi)), false);
    sf_mex_import(c14_parentId, sf_mex_dup(c14_mxInt), &c14_i, 1, 6, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c14_mxFi);
    sf_mex_destroy(&c14_mxInt);
    c14_b_y = c14_i;
  }

  sf_mex_destroy(&c14_mxFi);
  sf_mex_destroy(&c14_b_u);
  return c14_b_y;
}

static uint8_T c14_g_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_counter, const char_T
   *c14_identifier, boolean_T *c14_svPtr)
{
  uint8_T c14_b_y;
  emlrtMsgIdentifier c14_thisId;
  c14_thisId.fIdentifier = (const char *)c14_identifier;
  c14_thisId.fParent = NULL;
  c14_thisId.bParentIsCell = false;
  c14_b_y = c14_h_emlrt_marshallIn(chartInstance, c14_sp, sf_mex_dup
    (c14_b_counter), &c14_thisId, c14_svPtr);
  sf_mex_destroy(&c14_b_counter);
  return c14_b_y;
}

static uint8_T c14_h_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c14_sp, const mxArray *c14_b_u, const emlrtMsgIdentifier
   *c14_parentId, boolean_T *c14_svPtr)
{
  uint8_T c14_b_y;
  const mxArray *c14_mxFi = NULL;
  const mxArray *c14_mxInt = NULL;
  uint8_T c14_c_u;
  (void)chartInstance;
  if (mxIsEmpty(c14_b_u)) {
    *c14_svPtr = false;
  } else {
    *c14_svPtr = true;
    sf_mex_check_fi(c14_parentId, c14_b_u, false, 0U, NULL, c14_eml_mx,
                    c14_d_eml_mx);
    sf_mex_assign(&c14_mxFi, sf_mex_dup(c14_b_u), false);
    sf_mex_assign(&c14_mxInt, sf_mex_call(c14_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c14_mxFi)), false);
    sf_mex_import(c14_parentId, sf_mex_dup(c14_mxInt), &c14_c_u, 1, 3, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c14_mxFi);
    sf_mex_destroy(&c14_mxInt);
    c14_b_y = c14_c_u;
  }

  sf_mex_destroy(&c14_mxFi);
  sf_mex_destroy(&c14_b_u);
  return c14_b_y;
}

static uint8_T c14_i_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c14_b_is_active_c14_zeabus_hydrophone_concrete, const char_T *c14_identifier)
{
  uint8_T c14_b_y;
  emlrtMsgIdentifier c14_thisId;
  c14_thisId.fIdentifier = (const char *)c14_identifier;
  c14_thisId.fParent = NULL;
  c14_thisId.bParentIsCell = false;
  c14_b_y = c14_j_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c14_b_is_active_c14_zeabus_hydrophone_concrete), &c14_thisId);
  sf_mex_destroy(&c14_b_is_active_c14_zeabus_hydrophone_concrete);
  return c14_b_y;
}

static uint8_T c14_j_emlrt_marshallIn
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c14_b_u, const emlrtMsgIdentifier *c14_parentId)
{
  uint8_T c14_b_y;
  uint8_T c14_c_u;
  (void)chartInstance;
  sf_mex_import(c14_parentId, sf_mex_dup(c14_b_u), &c14_c_u, 1, 3, 0U, 0, 0U, 0);
  c14_b_y = c14_c_u;
  sf_mex_destroy(&c14_b_u);
  return c14_b_y;
}

static const mxArray *c14_chart_data_browse_helper
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c14_ssIdNumber)
{
  const mxArray *c14_mxData = NULL;
  int32_T c14_i;
  int32_T c14_i1;
  real_T c14_d;
  real_T c14_d1;
  c14_mxData = NULL;
  switch (c14_ssIdNumber) {
   case 4U:
    c14_i = *chartInstance->c14_u;
    c14_d = (real_T)c14_i * 7.62939453125E-6;
    sf_mex_assign(&c14_mxData, sf_mex_create("mxData", &c14_d, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 5U:
    c14_i1 = *chartInstance->c14_y;
    c14_d1 = (real_T)c14_i1 * 7.62939453125E-6;
    sf_mex_assign(&c14_mxData, sf_mex_create("mxData", &c14_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c14_mxData;
}

static int32_T c14__s32_shl_s32_(SFc14_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c14_b, int32_T c14_c, int32_T c14_EMLOvCount_src_loc,
  uint32_T c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T
  c14_length_src_loc)
{
  int32_T c14_a;
  int32_T c14_PICOffset;
  real_T c14_d;
  observerLogReadPIC(&c14_PICOffset);
  c14_a = c14_b << c14_c;
  if ((c14_b != c14_a >> c14_c) || ((uint32_T)c14_c > 31U)) {
    sf_data_overflow_error(chartInstance->S, c14_ssid_src_loc,
      c14_offset_src_loc, c14_length_src_loc);
    c14_d = 1.0;
    observerLog(c14_EMLOvCount_src_loc + c14_PICOffset, &c14_d, 1);
  }

  return c14_a;
}

static uint32_T c14__u32_add__(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c14_b, uint32_T c14_c, int32_T c14_EMLOvCount_src_loc,
  uint32_T c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T
  c14_length_src_loc)
{
  uint32_T c14_a;
  int32_T c14_PICOffset;
  real_T c14_d;
  observerLogReadPIC(&c14_PICOffset);
  c14_a = c14_b + c14_c;
  if (c14_a < c14_b) {
    sf_data_overflow_error(chartInstance->S, c14_ssid_src_loc,
      c14_offset_src_loc, c14_length_src_loc);
    c14_d = 1.0;
    observerLog(c14_EMLOvCount_src_loc + c14_PICOffset, &c14_d, 1);
  }

  return c14_a;
}

static uint8_T c14__u8_u32_(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c14_b, int32_T c14_EMLOvCount_src_loc, uint32_T
  c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T c14_length_src_loc)
{
  uint8_T c14_a;
  int32_T c14_PICOffset;
  real_T c14_d;
  observerLogReadPIC(&c14_PICOffset);
  c14_a = (uint8_T)c14_b;
  if (c14_a != c14_b) {
    sf_data_overflow_error(chartInstance->S, c14_ssid_src_loc,
      c14_offset_src_loc, c14_length_src_loc);
    c14_d = 1.0;
    observerLog(c14_EMLOvCount_src_loc + c14_PICOffset, &c14_d, 1);
  }

  return c14_a;
}

static int32_T c14__s32_add__(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c14_b, int32_T c14_c, int32_T c14_EMLOvCount_src_loc,
  uint32_T c14_ssid_src_loc, int32_T c14_offset_src_loc, int32_T
  c14_length_src_loc)
{
  int32_T c14_a;
  int32_T c14_PICOffset;
  real_T c14_d;
  observerLogReadPIC(&c14_PICOffset);
  c14_a = c14_b + c14_c;
  if (((c14_a ^ c14_b) & (c14_a ^ c14_c)) < 0) {
    sf_data_overflow_error(chartInstance->S, c14_ssid_src_loc,
      c14_offset_src_loc, c14_length_src_loc);
    c14_d = 1.0;
    observerLog(c14_EMLOvCount_src_loc + c14_PICOffset, &c14_d, 1);
  }

  return c14_a;
}

static void init_dsm_address_info(SFc14_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c14_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c14_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c14_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c14_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c14_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1201767455U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3387158271U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3170754769U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1421900040U);
}

mxArray *sf_c14_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c14_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c14_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c14_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiDewcbAAEQMHEDMxAABrFA+I5TNCBdngYsrAHFJZUEqSLy4KNkzBUjnJeaC+Ym"
    "lFZ55aflg8y0YEOazYTGfEcl8Tqg4BHywp0y/iANIvwGSfhYC+gWArEpouMDCh3z7BRwo0w+xn5"
    "D7mVHcz8yQmJwM1neBAX+8MqLFKxOUD9KTw5DJUAC134GA+5nQ3C8Ac7xDjAOEEUuVcBiy8VGWP"
    "jjiY0ESND6Sh1V8WBCID3aU+IDwk/NL80pSiwZHvCgkQOMlcZDEiwJV3BFBIF400OIFxM8sjk9M"
    "LsksS41PNjSJr0pNTCotjs+oTCnKL8jIzwOK5uclF6WWpML8CQDUvzlj"
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c14_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "sfcoMQwMlai0BppVMY0GPPD";
}

static void sf_opaque_initialize_c14_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c14_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c14_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c14_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c14_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c14_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c14_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc14_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c14_zeabus_hydrophone_concrete
      ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc14_zeabus_hydrophone_concrete
    ((SFc14_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c14_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c14_zeabus_hydrophone_concrete
      ((SFc14_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc14_zeabus_hydrophone_concrete
      ((SFc14_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c14_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [18] = {
    "eNrtV0tvI0UQbnuzWVaCyIeV9sIhNyJxCQKJvWHiB1iKiRdnA0gg0+4pe1ru6R764SQc+RfcVto",
    "7ZzjujQsSJ/4Bd34Bono8Tsx4HmscVuEx0nimx199XVVfdU0PqfX6BI89PJsPCNnF6yt41sniuJ",
    "uOayvn4vkOeSMdP0OQdNGAahoZUnpIGsHHYJRwlivZkxOVC+NyAhokQ2ystC1iMzxygstZ10nm+",
    "cwnIWfhMFROBEdoS4MTKS6RLXZ2gDxtroHZLkBgQ63cNOwKOr3yWNvzVghsZlxUFoIBO3Sxd8v0",
    "nbA8FtC5ANaTxlL02Fz7NrTUQsteFIbpIzXDJVBFseBU5kYbUjOEGBNs4Ukc4O+JsxhUFsZCqu0",
    "RhHQO5pjPEk4lIcvJDf4x5pJapTkVnUi0vOG6bwOB/vRVAKIkIejbkQY6ixWXtlj/YRcj7Ug6Ft",
    "CGsZsWsw3hK+fFP+NwDrowb5OWmoOmUziRhZMmCelcJGpdVck6zPIIzqh+n6F+BoLC6sXKMUOKO",
    "sEpWhTBIAmyZ041n2N6C9lc1POVWbVkXLQQ21TBErbOHMpUuGLrMtmiQphC2KmKj2EOImFtU0vL",
    "YQvWfFysVUynWLUBJtmXeEvJgK9pwZyxKmphubWPjz/CTpHv3DWsJy3oCWWQt24NCyFwAjBQ7Ew",
    "2mS6HNODGq1WBSjWtQhEzcbJ9rvQMAy1Z9tcheA0KgZGZYvaxdp8YLPMymM9+JW7Z5w/JdZ9/9Q",
    "X6/NIuez1Y4anl8JCVa3be+/Xyeet4V1u+l1bsXsvMs5Ox87gGnr//2Pzul/G3F++++fztH3765",
    "tdt5g/vbfZe3EvHry8b0FV5zteqwmM/XPFrJ4f/4Qp/Ix2bCVP9x+d9QfnhURyf9T87/GAwaCd8",
    "3++W+3s34+/y+b7vhJdx0teMZr0gfWH7MXWL15jnf7Ti725FPu6nzxfHb+9tZ/+gmdVxp8K+gXe",
    "Xmbr96/M3mtvZr6+DPP/v/Mn/O4Qyltj9TDarw3o69jaCcBLnrKc8/+sZ/xtL55ufNxc3X9xIHv",
    "6xesynt0OPp+NUD/av0uNRhR73Mv3Qj5lyfjNwO3TZ/zLVhd4SXfZvxI9PK3Q5yOhykOzTRxR33",
    "XMYsbfeGX0NdOzMKLwMcEcY4pfJiCnJNFjYu4F9wqZ25H+7W2FX+w/G9yL77pdtR16y3bbxbfr9",
    "sc33SrbfkQy+scU8fzd+2++2TfB/ALNmf0M=",
    ""
  };

  static char newstr [1237] = "";
  newstr[0] = '\0';
  for (i = 0; i < 18; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c14_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c14_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(2923481342U));
  ssSetChecksum1(S,(2023318230U));
  ssSetChecksum2(S,(868297527U));
  ssSetChecksum3(S,(3850554809U));
}

static void mdlRTW_c14_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c14_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc14_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc14_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc14_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc14_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c14_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c14_zeabus_hydrophone_concrete;
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
    chartInstance->c14_JITStateAnimation,
    chartInstance->c14_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c14_zeabus_hydrophone_concrete(chartInstance);
}

void c14_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c14_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c14_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c14_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c14_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
