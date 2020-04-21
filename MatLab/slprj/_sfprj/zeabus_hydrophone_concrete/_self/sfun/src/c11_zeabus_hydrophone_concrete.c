/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c11_zeabus_hydrophone_concrete.h"
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
static const mxArray *c11_eml_mx;
static const mxArray *c11_b_eml_mx;
static const mxArray *c11_c_eml_mx;
static const mxArray *c11_d_eml_mx;
static emlrtRSInfo c11_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC1 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:571"    /* pathName */
};

static emlrtRSInfo c11_b_emlrtRSI = { 26,/* lineNo */
  "Hydrophone processing/ADC1 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:571"    /* pathName */
};

static emlrtRSInfo c11_c_emlrtRSI = { 41,/* lineNo */
  "Hydrophone processing/ADC1 Interface/HiRes Filter/HiRes Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:571"    /* pathName */
};

static emlrtRSInfo c11_d_emlrtRSI = { 14,/* lineNo */
  "bitsra",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\bitsra.m"/* pathName */
};

static emlrtRSInfo c11_e_emlrtRSI = { 75,/* lineNo */
  "eml_fi_bitshift",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\eml_fi_bitshift.m"/* pathName */
};

static emlrtRSInfo c11_f_emlrtRSI = { 236,/* lineNo */
  "eml_fi_bitshift",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\eml\\lib\\fixedpoint\\@embedded\\@fi\\eml_fi_bitshift.m"/* pathName */
};

/* Function Declarations */
static void initialize_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c11_update_jit_animation_state_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c11_do_animation_call_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c11_st);
static void finalize_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c11_emlrt_update_log_1
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static int32_T c11_emlrt_update_log_2
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static uint8_T c11_emlrt_update_log_3
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static int32_T c11_emlrt_update_log_4
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static uint8_T c11_emlrt_update_log_5
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static boolean_T c11_emlrt_update_log_6
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c11_in, emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static int32_T c11_emlrt_update_log_7
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static real_T c11_emlrt_update_log_8
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, real_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index);
static void c11_emlrtInitVarDataTables
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c11_dataTables[18],
   emlrtLocationLoggingHistogramType c11_histTables[18]);
static int32_T c11_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_y, const char_T *c11_identifier);
static int32_T c11_b_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId);
static int32_T c11_c_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_acc, const char_T *c11_identifier,
   boolean_T *c11_svPtr);
static int32_T c11_d_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId, boolean_T *c11_svPtr);
static int32_T c11_e_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_avg, const char_T *c11_identifier,
   boolean_T *c11_svPtr);
static int32_T c11_f_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId, boolean_T *c11_svPtr);
static uint8_T c11_g_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_counter, const char_T
   *c11_identifier, boolean_T *c11_svPtr);
static uint8_T c11_h_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId, boolean_T *c11_svPtr);
static uint8_T c11_i_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c11_b_is_active_c11_zeabus_hydrophone_concrete, const char_T *c11_identifier);
static uint8_T c11_j_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c11_b_u, const emlrtMsgIdentifier *c11_parentId);
static const mxArray *c11_chart_data_browse_helper
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c11_ssIdNumber);
static int32_T c11__s32_shl_s32_(SFc11_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c11_b, int32_T c11_c, int32_T c11_EMLOvCount_src_loc,
  uint32_T c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T
  c11_length_src_loc);
static uint32_T c11__u32_add__(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c11_b, uint32_T c11_c, int32_T c11_EMLOvCount_src_loc,
  uint32_T c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T
  c11_length_src_loc);
static uint8_T c11__u8_u32_(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c11_b, int32_T c11_EMLOvCount_src_loc, uint32_T
  c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T c11_length_src_loc);
static int32_T c11__s32_add__(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c11_b, int32_T c11_c, int32_T c11_EMLOvCount_src_loc,
  uint32_T c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T
  c11_length_src_loc);
static void init_dsm_address_info(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c11_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c11_st.tls = chartInstance->c11_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c11_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c11_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c11_acc_not_empty = false;
  chartInstance->c11_counter_not_empty = false;
  chartInstance->c11_avg_not_empty = false;
  chartInstance->c11_is_active_c11_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c11_d_eml_mx, sf_mex_call(&c11_st, "numerictype", 1U, 14U, 15,
    "SignednessBool", 3, false, 15, "Signedness", 15, "Unsigned", 15,
    "WordLength", 6, 7.0, 15, "FractionLength", 6, 0.0, 15, "BinaryPoint", 6,
    0.0, 15, "Slope", 6, 1.0, 15, "FixedExponent", 6, 0.0), true);
  sf_mex_assign(&c11_c_eml_mx, sf_mex_call(&c11_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 24.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c11_b_eml_mx, sf_mex_call(&c11_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c11_eml_mx, sf_mex_call(&c11_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c11_emlrtLocLogSimulated = false;
  c11_emlrtInitVarDataTables(chartInstance,
    chartInstance->c11_emlrtLocationLoggingDataTables,
    chartInstance->c11_emlrtLocLogHistTables);
}

static void initialize_params_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c11_update_jit_animation_state_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c11_do_animation_call_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c11_st;
  const mxArray *c11_b_y = NULL;
  const mxArray *c11_c_y = NULL;
  int32_T c11_b_u;
  const mxArray *c11_d_y = NULL;
  const mxArray *c11_e_y = NULL;
  int32_T c11_c_u;
  const mxArray *c11_f_y = NULL;
  const mxArray *c11_g_y = NULL;
  int32_T c11_d_u;
  const mxArray *c11_h_y = NULL;
  const mxArray *c11_i_y = NULL;
  uint8_T c11_e_u;
  const mxArray *c11_j_y = NULL;
  const mxArray *c11_k_y = NULL;
  c11_st = NULL;
  c11_st = NULL;
  c11_b_y = NULL;
  sf_mex_assign(&c11_b_y, sf_mex_createcellmatrix(5, 1), false);
  c11_c_y = NULL;
  c11_b_u = *chartInstance->c11_y;
  c11_d_y = NULL;
  sf_mex_assign(&c11_d_y, sf_mex_create("y", &c11_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c11_c_y, sf_mex_create_fi(sf_mex_dup(c11_eml_mx), sf_mex_dup
    (c11_b_eml_mx), "simulinkarray", c11_d_y, false, false), false);
  sf_mex_setcell(c11_b_y, 0, c11_c_y);
  c11_e_y = NULL;
  if (!chartInstance->c11_acc_not_empty) {
    sf_mex_assign(&c11_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c11_c_u = chartInstance->c11_acc;
    c11_f_y = NULL;
    sf_mex_assign(&c11_f_y, sf_mex_create("y", &c11_c_u, 6, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c11_e_y, sf_mex_create_fi(sf_mex_dup(c11_eml_mx), sf_mex_dup
      (c11_c_eml_mx), "simulinkarray", c11_f_y, true, false), false);
  }

  sf_mex_setcell(c11_b_y, 1, c11_e_y);
  c11_g_y = NULL;
  if (!chartInstance->c11_avg_not_empty) {
    sf_mex_assign(&c11_g_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c11_d_u = chartInstance->c11_avg;
    c11_h_y = NULL;
    sf_mex_assign(&c11_h_y, sf_mex_create("y", &c11_d_u, 6, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c11_g_y, sf_mex_create_fi(sf_mex_dup(c11_eml_mx), sf_mex_dup
      (c11_b_eml_mx), "simulinkarray", c11_h_y, true, false), false);
  }

  sf_mex_setcell(c11_b_y, 2, c11_g_y);
  c11_i_y = NULL;
  if (!chartInstance->c11_counter_not_empty) {
    sf_mex_assign(&c11_i_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c11_e_u = chartInstance->c11_counter;
    c11_j_y = NULL;
    sf_mex_assign(&c11_j_y, sf_mex_create("y", &c11_e_u, 3, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c11_i_y, sf_mex_create_fi(sf_mex_dup(c11_eml_mx), sf_mex_dup
      (c11_d_eml_mx), "simulinkarray", c11_j_y, true, false), false);
  }

  sf_mex_setcell(c11_b_y, 3, c11_i_y);
  c11_k_y = NULL;
  sf_mex_assign(&c11_k_y, sf_mex_create("y",
    &chartInstance->c11_is_active_c11_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c11_b_y, 4, c11_k_y);
  sf_mex_assign(&c11_st, c11_b_y, false);
  return c11_st;
}

static void set_sim_state_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c11_st)
{
  emlrtStack c11_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c11_b_u;
  c11_b_st.tls = chartInstance->c11_fEmlrtCtx;
  chartInstance->c11_doneDoubleBufferReInit = true;
  c11_b_u = sf_mex_dup(c11_st);
  *chartInstance->c11_y = c11_emlrt_marshallIn(chartInstance, &c11_b_st,
    sf_mex_dup(sf_mex_getcell(c11_b_u, 0)), "y");
  chartInstance->c11_acc = c11_c_emlrt_marshallIn(chartInstance, &c11_b_st,
    sf_mex_dup(sf_mex_getcell(c11_b_u, 1)), "acc",
    &chartInstance->c11_acc_not_empty);
  chartInstance->c11_avg = c11_e_emlrt_marshallIn(chartInstance, &c11_b_st,
    sf_mex_dup(sf_mex_getcell(c11_b_u, 2)), "avg",
    &chartInstance->c11_avg_not_empty);
  chartInstance->c11_counter = c11_g_emlrt_marshallIn(chartInstance, &c11_b_st,
    sf_mex_dup(sf_mex_getcell(c11_b_u, 3)), "counter",
    &chartInstance->c11_counter_not_empty);
  chartInstance->c11_is_active_c11_zeabus_hydrophone_concrete =
    c11_i_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c11_b_u, 4)),
    "is_active_c11_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c11_b_u);
  sf_mex_destroy(&c11_st);
}

static void finalize_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c11_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:571", /* mexFileName */
    "Thu Apr 16 10:57:56 2020",        /* timestamp */
    "",                                /* buildDir */
    2,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c11_emlrtLocationLoggingFunctionInfoTable[2] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      15                               /* numInstrPoints */
    }, { "fi_div_by_shift",            /* fcnName */
      79,                              /* fcnId */
      3                                /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c11_emlrtLocationInfo[21] = { { 1,/* MxInfoID */
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

  const int32_T c11_emlrtLocationLoggingFieldCounts[18] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c11_RuntimeVar);
  if (chartInstance->c11_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:571");
    emlrtLocationLoggingPushLog(&c11_emlrtLocationLoggingFileInfo,
      c11_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c11_emlrtLocationLoggingDataTables, c11_emlrtLocationInfo,
      NULL, 0U, c11_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:571");
  }

  sf_mex_destroy(&c11_eml_mx);
  sf_mex_destroy(&c11_b_eml_mx);
  sf_mex_destroy(&c11_c_eml_mx);
  sf_mex_destroy(&c11_d_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c11_covrtInstance);
}

static void sf_gateway_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c11_PICOffset;
  int32_T c11_b_u;
  int32_T c11_varargin_1;
  int32_T c11_b_varargin_1;
  int32_T c11_var1;
  int32_T c11_hfi;
  int32_T c11_c_u;
  int32_T c11_a0;
  int32_T c11_b0;
  int32_T c11_i;
  real_T c11_d;
  int32_T c11_i1;
  real_T c11_d1;
  real_T c11_d2;
  real_T c11_d3;
  int32_T c11_i2;
  int32_T c11_i3;
  int32_T c11_i4;
  real_T c11_d4;
  real_T c11_d5;
  int32_T c11_c;
  int32_T c11_i5;
  real_T c11_d6;
  real_T c11_d7;
  int32_T c11_i6;
  uint8_T c11_b_a0;
  uint8_T c11_b_c;
  uint8_T c11_d_u;
  real_T c11_d8;
  uint8_T c11_c_a0;
  uint8_T c11_a;
  uint8_T c11_d_a0;
  uint8_T c11_a1;
  uint8_T c11_b_a1;
  boolean_T c11_c_c;
  int32_T c11_i7;
  int32_T c11_i8;
  real_T c11_d9;
  int32_T c11_c_varargin_1;
  int32_T c11_b_a;
  int32_T c11_d_varargin_1;
  int32_T c11_b_var1;
  int32_T c11_b_hfi;
  int32_T c11_b_y;
  int32_T c11_i9;
  real_T c11_d10;
  real_T c11_d11;
  int32_T c11_ain;
  int32_T c11_b_ain;
  int32_T c11_c_a;
  int32_T c11_e_varargin_1;
  int32_T c11_i10;
  int32_T c11_d_c;
  int32_T c11_cout;
  int32_T c11_c_y;
  int32_T c11_i11;
  real_T c11_d12;
  real_T c11_d13;
  int32_T c11_i12;
  observerLogReadPIC(&c11_PICOffset);
  chartInstance->c11_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c11_covrtInstance, 0U, (real_T)
                    *chartInstance->c11_u);
  chartInstance->c11_sfEvent = CALL_EVENT;
  c11_b_u = *chartInstance->c11_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c11_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c11_emlrt_update_log_1(chartInstance, c11_b_u,
    chartInstance->c11_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c11_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c11_covrtInstance, 4U, 0, 2);
  c11_varargin_1 = c11_b_u;
  c11_b_varargin_1 = c11_varargin_1;
  c11_var1 = c11_b_varargin_1;
  c11_hfi = c11_var1;
  c11_c_u = c11_emlrt_update_log_1(chartInstance, c11_hfi,
    chartInstance->c11_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c11_covrtInstance, 4U, 0, 0,
                     !chartInstance->c11_acc_not_empty)) {
    chartInstance->c11_acc = c11_emlrt_update_log_2(chartInstance, 0,
      chartInstance->c11_emlrtLocationLoggingDataTables, 2);
    chartInstance->c11_acc_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c11_covrtInstance, 4U, 0, 1,
                     !chartInstance->c11_counter_not_empty)) {
    chartInstance->c11_counter = c11_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c11_emlrtLocationLoggingDataTables, 3);
    chartInstance->c11_counter_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c11_covrtInstance, 4U, 0, 2,
                     !chartInstance->c11_avg_not_empty)) {
    chartInstance->c11_avg = c11_emlrt_update_log_1(chartInstance, 0,
      chartInstance->c11_emlrtLocationLoggingDataTables, 4);
    chartInstance->c11_avg_not_empty = true;
  }

  c11_a0 = chartInstance->c11_acc;
  c11_b0 = c11_c_u;
  c11_i = c11_a0;
  if (c11_i > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c11_d = 1.0;
    observerLog(39 + c11_PICOffset, &c11_d, 1);
  }

  if (c11_i < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c11_d1 = 1.0;
    observerLog(39 + c11_PICOffset, &c11_d1, 1);
  }

  c11_i1 = c11_b0;
  if (c11_i1 > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c11_d2 = 1.0;
    observerLog(42 + c11_PICOffset, &c11_d2, 1);
  }

  if (c11_i1 < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c11_d3 = 1.0;
    observerLog(42 + c11_PICOffset, &c11_d3, 1);
  }

  if ((c11_i & 16777216) != 0) {
    c11_i2 = c11_i | -16777216;
  } else {
    c11_i2 = c11_i & 16777215;
  }

  if ((c11_i1 & 16777216) != 0) {
    c11_i3 = c11_i1 | -16777216;
  } else {
    c11_i3 = c11_i1 & 16777215;
  }

  c11_i4 = c11__s32_add__(chartInstance, c11_i2, c11_i3, 41, 1U, 380, 7);
  if (c11_i4 > 16777215) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c11_d4 = 1.0;
    observerLog(67 + c11_PICOffset, &c11_d4, 1);
  }

  if (c11_i4 < -16777216) {
    sf_data_overflow_error(chartInstance->S, 1U, 380, 7);
    c11_d5 = 1.0;
    observerLog(67 + c11_PICOffset, &c11_d5, 1);
  }

  if ((c11_i4 & 16777216) != 0) {
    c11_c = c11_i4 | -16777216;
  } else {
    c11_c = c11_i4 & 16777215;
  }

  c11_i5 = c11_emlrt_update_log_4(chartInstance, c11_c,
    chartInstance->c11_emlrtLocationLoggingDataTables, 6);
  if (c11_i5 > 8388607) {
    sf_data_overflow_error(chartInstance->S, 1U, 371, 16);
    c11_d6 = 1.0;
    observerLog(47 + c11_PICOffset, &c11_d6, 1);
  }

  if (c11_i5 < -8388608) {
    sf_data_overflow_error(chartInstance->S, 1U, 371, 16);
    c11_d7 = 1.0;
    observerLog(47 + c11_PICOffset, &c11_d7, 1);
  }

  if ((c11_i5 & 8388608) != 0) {
    c11_i6 = c11_i5 | -8388608;
  } else {
    c11_i6 = c11_i5 & 8388607;
  }

  chartInstance->c11_acc = c11_emlrt_update_log_2(chartInstance, c11_i6,
    chartInstance->c11_emlrtLocationLoggingDataTables, 5);
  c11_b_a0 = chartInstance->c11_counter;
  c11_b_c = c11__u8_u32_(chartInstance, c11__u32_add__(chartInstance, (uint32_T)
    c11_b_a0, 1U, 49, 1U, 421, 28), 48, 1U, 421, 28);
  c11_d_u = c11_emlrt_update_log_5(chartInstance, c11_b_c,
    chartInstance->c11_emlrtLocationLoggingDataTables, 8);
  if (c11_d_u > 127) {
    sf_data_overflow_error(chartInstance->S, 1U, 408, 41);
    c11_d8 = 1.0;
    observerLog(51 + c11_PICOffset, &c11_d8, 1);
  }

  chartInstance->c11_counter = c11_emlrt_update_log_3(chartInstance, (uint8_T)
    (c11_d_u & 127), chartInstance->c11_emlrtLocationLoggingDataTables, 7);
  c11_c_a0 = chartInstance->c11_counter;
  c11_a = c11_c_a0;
  c11_d_a0 = c11_a;
  c11_a1 = c11_d_a0;
  c11_b_a1 = c11_a1;
  c11_c_c = (c11_b_a1 == 64);
  c11_i7 = 64 - (int8_T)chartInstance->c11_counter;
  if (c11_i7 > 127) {
    c11_i7 = 127;
  } else {
    if (c11_i7 < -128) {
      c11_i7 = -128;
    }
  }

  c11_i8 = (int8_T)chartInstance->c11_counter - 64;
  if (c11_i8 > 127) {
    c11_i8 = 127;
  } else {
    if (c11_i8 < -128) {
      c11_i8 = -128;
    }
  }

  if ((int8_T)chartInstance->c11_counter < 64) {
    c11_d9 = (real_T)((int8_T)c11_i7 <= 1);
  } else if ((int8_T)chartInstance->c11_counter > 64) {
    if ((int8_T)c11_i8 <= 1) {
      c11_d9 = 3.0;
    } else {
      c11_d9 = 0.0;
    }
  } else {
    c11_d9 = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c11_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c11_covrtInstance,
        4U, 0U, 0U, c11_d9, 0.0, -2, 0U, (int32_T)c11_emlrt_update_log_6
        (chartInstance, c11_c_c,
         chartInstance->c11_emlrtLocationLoggingDataTables, 9)))) {
    chartInstance->c11_counter = c11_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c11_emlrtLocationLoggingDataTables, 10);
    c11_b_a = chartInstance->c11_acc;
    c11_emlrt_update_log_8(chartInstance, 6.0,
      chartInstance->c11_emlrtLocationLoggingDataTables, 17);

    /* logging input variable 'a' for function 'fi_div_by_shift' */
    c11_emlrt_update_log_2(chartInstance, c11_b_a,
      chartInstance->c11_emlrtLocationLoggingDataTables, 15);
    covrtEmlFcnEval(chartInstance->c11_covrtInstance, 4U, 0, 1);
    covrtEmlIfEval(chartInstance->c11_covrtInstance, 4U, 0, 4, true);
    c11_i9 = c11__s32_shl_s32_(chartInstance, c11_b_a, 6, 56, 1U, 868, 18);
    if (c11_i9 > 536870911) {
      sf_data_overflow_error(chartInstance->S, 1U, 868, 18);
      c11_d10 = 1.0;
      observerLog(64 + c11_PICOffset, &c11_d10, 1);
    }

    if (c11_i9 < -536870912) {
      sf_data_overflow_error(chartInstance->S, 1U, 868, 18);
      c11_d11 = 1.0;
      observerLog(64 + c11_PICOffset, &c11_d11, 1);
    }

    if ((c11_i9 & 536870912) != 0) {
      c11_ain = c11_i9 | -536870912;
    } else {
      c11_ain = c11_i9 & 536870911;
    }

    c11_b_ain = c11_ain;
    c11_c_a = c11_b_ain;
    c11_e_varargin_1 = c11_c_a;
    c11_i10 = c11_e_varargin_1 >> 6;
    if ((c11_i10 & 536870912) != 0) {
      c11_d_c = c11_i10 | -536870912;
    } else {
      c11_d_c = c11_i10 & 536870911;
    }

    c11_cout = c11_d_c;
    c11_c_y = c11_emlrt_update_log_7(chartInstance, c11_cout,
      chartInstance->c11_emlrtLocationLoggingDataTables, 16);
    c11_i11 = c11_emlrt_update_log_7(chartInstance, c11_c_y,
      chartInstance->c11_emlrtLocationLoggingDataTables, 12) >> 6;
    if (c11_i11 > 131071) {
      sf_data_overflow_error(chartInstance->S, 1U, 512, 32);
      c11_d12 = 1.0;
      observerLog(62 + c11_PICOffset, &c11_d12, 1);
    }

    if (c11_i11 < -131072) {
      sf_data_overflow_error(chartInstance->S, 1U, 512, 32);
      c11_d13 = 1.0;
      observerLog(62 + c11_PICOffset, &c11_d13, 1);
    }

    if ((c11_i11 & 131072) != 0) {
      c11_i12 = c11_i11 | -131072;
    } else {
      c11_i12 = c11_i11 & 131071;
    }

    chartInstance->c11_avg = c11_emlrt_update_log_1(chartInstance, c11_i12,
      chartInstance->c11_emlrtLocationLoggingDataTables, 11);
    chartInstance->c11_acc = c11_emlrt_update_log_2(chartInstance, 0,
      chartInstance->c11_emlrtLocationLoggingDataTables, 13);
  }

  c11_c_varargin_1 = chartInstance->c11_avg;
  c11_d_varargin_1 = c11_c_varargin_1;
  c11_b_var1 = c11_d_varargin_1;
  c11_b_hfi = c11_b_var1;
  c11_b_y = c11_emlrt_update_log_1(chartInstance, c11_b_hfi,
    chartInstance->c11_emlrtLocationLoggingDataTables, 14);
  *chartInstance->c11_y = c11_b_y;
  c11_do_animation_call_c11_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c11_covrtInstance, 1U, (real_T)
                    *chartInstance->c11_y);
}

static void mdl_start_c11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c11_decisionTxtStartIdx = 0U;
  static const uint32_T c11_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c11_chart_data_browse_helper);
  chartInstance->c11_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c11_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c11_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c11_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c11_decisionTxtStartIdx, &c11_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c11_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c11_covrtInstance, "", 4U, 0U, 3U, 0U, 5U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 598);
  covrtEmlFcnInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 1U,
                     "fi_div_by_shift", 602, -1, 952);
  covrtEmlFcnInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 2U, "get_fimath",
                     954, -1, 1208);
  covrtEmlIfInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 0U, 155, 171, -1,
                    209);
  covrtEmlIfInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 1U, 210, 230, -1,
                    270);
  covrtEmlIfInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 2U, 271, 287, -1,
                    325);
  covrtEmlIfInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 3U, 451, 485, -1,
                    565);
  covrtEmlIfInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 4U, 678, 690, 905,
                    948);
  covrtEmlRelationalInitFcn(chartInstance->c11_covrtInstance, 4U, 0U, 0U, 455,
    485, -2, 0U);
}

static void initSimStructsc11_zeabus_hydrophone_concrete
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c11_emlrt_update_log_1
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_d;
  int32_T c11_i;
  int32_T c11_localMin;
  real_T c11_d1;
  int32_T c11_i1;
  int32_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_d = muDoubleScalarFloor(c11_b_table[0U].SimMin * 131072.0);
    if (c11_d < 131072.0) {
      if (c11_d >= -131072.0) {
        c11_i = (int32_T)c11_d;
      } else {
        c11_i = -131072;
      }
    } else if (c11_d >= 131072.0) {
      c11_i = 131071;
    } else {
      c11_i = 0;
    }

    c11_localMin = c11_i;
    c11_d1 = muDoubleScalarFloor(c11_b_table[0U].SimMax * 131072.0);
    if (c11_d1 < 131072.0) {
      if (c11_d1 >= -131072.0) {
        c11_i1 = (int32_T)c11_d1;
      } else {
        c11_i1 = -131072;
      }
    } else if (c11_d1 >= 131072.0) {
      c11_i1 = 131071;
    } else {
      c11_i1 = 0;
    }

    c11_localMax = c11_i1;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in * 7.62939453125E-6;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin * 7.62939453125E-6;
    c11_b_table[0U].SimMax = (real_T)c11_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c11_in & 131071U) != 0U) {
      c11_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c11_in;
}

static int32_T c11_emlrt_update_log_2
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_d;
  int32_T c11_i;
  int32_T c11_localMin;
  real_T c11_d1;
  int32_T c11_i1;
  int32_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_d = muDoubleScalarFloor(c11_b_table[0U].SimMin * 131072.0);
    if (c11_d < 8.388608E+6) {
      if (c11_d >= -8.388608E+6) {
        c11_i = (int32_T)c11_d;
      } else {
        c11_i = -8388608;
      }
    } else if (c11_d >= 8.388608E+6) {
      c11_i = 8388607;
    } else {
      c11_i = 0;
    }

    c11_localMin = c11_i;
    c11_d1 = muDoubleScalarFloor(c11_b_table[0U].SimMax * 131072.0);
    if (c11_d1 < 8.388608E+6) {
      if (c11_d1 >= -8.388608E+6) {
        c11_i1 = (int32_T)c11_d1;
      } else {
        c11_i1 = -8388608;
      }
    } else if (c11_d1 >= 8.388608E+6) {
      c11_i1 = 8388607;
    } else {
      c11_i1 = 0;
    }

    c11_localMax = c11_i1;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in * 7.62939453125E-6;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin * 7.62939453125E-6;
    c11_b_table[0U].SimMax = (real_T)c11_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c11_in & 131071U) != 0U) {
      c11_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c11_in;
}

static uint8_T c11_emlrt_update_log_3
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_d;
  uint8_T c11_b_u;
  uint8_T c11_localMin;
  real_T c11_d1;
  uint8_T c11_u1;
  uint8_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_d = c11_b_table[0U].SimMin;
    if (c11_d < 128.0) {
      if (c11_d >= 0.0) {
        c11_b_u = (uint8_T)c11_d;
      } else {
        c11_b_u = 0U;
      }
    } else if (c11_d >= 128.0) {
      c11_b_u = 127U;
    } else {
      c11_b_u = 0U;
    }

    c11_localMin = c11_b_u;
    c11_d1 = c11_b_table[0U].SimMax;
    if (c11_d1 < 128.0) {
      if (c11_d1 >= 0.0) {
        c11_u1 = (uint8_T)c11_d1;
      } else {
        c11_u1 = 0U;
      }
    } else if (c11_d1 >= 128.0) {
      c11_u1 = 127U;
    } else {
      c11_u1 = 0U;
    }

    c11_localMax = c11_u1;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin;
    c11_b_table[0U].SimMax = (real_T)c11_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c11_in;
}

static int32_T c11_emlrt_update_log_4
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_d;
  int32_T c11_i;
  int32_T c11_localMin;
  real_T c11_d1;
  int32_T c11_i1;
  int32_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_d = muDoubleScalarFloor(c11_b_table[0U].SimMin * 131072.0);
    if (c11_d < 1.6777216E+7) {
      if (c11_d >= -1.6777216E+7) {
        c11_i = (int32_T)c11_d;
      } else {
        c11_i = -16777216;
      }
    } else if (c11_d >= 1.6777216E+7) {
      c11_i = 16777215;
    } else {
      c11_i = 0;
    }

    c11_localMin = c11_i;
    c11_d1 = muDoubleScalarFloor(c11_b_table[0U].SimMax * 131072.0);
    if (c11_d1 < 1.6777216E+7) {
      if (c11_d1 >= -1.6777216E+7) {
        c11_i1 = (int32_T)c11_d1;
      } else {
        c11_i1 = -16777216;
      }
    } else if (c11_d1 >= 1.6777216E+7) {
      c11_i1 = 16777215;
    } else {
      c11_i1 = 0;
    }

    c11_localMax = c11_i1;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in * 7.62939453125E-6;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin * 7.62939453125E-6;
    c11_b_table[0U].SimMax = (real_T)c11_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c11_in & 131071U) != 0U) {
      c11_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c11_in;
}

static uint8_T c11_emlrt_update_log_5
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_d;
  uint8_T c11_b_u;
  uint8_T c11_localMin;
  real_T c11_d1;
  uint8_T c11_u1;
  uint8_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_d = c11_b_table[0U].SimMin;
    if (c11_d < 256.0) {
      if (c11_d >= 0.0) {
        c11_b_u = (uint8_T)c11_d;
      } else {
        c11_b_u = 0U;
      }
    } else if (c11_d >= 256.0) {
      c11_b_u = MAX_uint8_T;
    } else {
      c11_b_u = 0U;
    }

    c11_localMin = c11_b_u;
    c11_d1 = c11_b_table[0U].SimMax;
    if (c11_d1 < 256.0) {
      if (c11_d1 >= 0.0) {
        c11_u1 = (uint8_T)c11_d1;
      } else {
        c11_u1 = 0U;
      }
    } else if (c11_d1 >= 256.0) {
      c11_u1 = MAX_uint8_T;
    } else {
      c11_u1 = 0U;
    }

    c11_localMax = c11_u1;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin;
    c11_b_table[0U].SimMax = (real_T)c11_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c11_in;
}

static boolean_T c11_emlrt_update_log_6
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c11_in, emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  boolean_T c11_localMin;
  boolean_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_localMin = (c11_b_table[0U].SimMin > 0.0);
    c11_localMax = (c11_b_table[0U].SimMax > 0.0);
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c11_in < (int32_T)c11_localMin) {
      c11_localMin = c11_in;
    }

    if ((int32_T)c11_in > (int32_T)c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin;
    c11_b_table[0U].SimMax = (real_T)c11_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c11_in;
}

static int32_T c11_emlrt_update_log_7
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_d;
  int32_T c11_i;
  int32_T c11_localMin;
  real_T c11_d1;
  int32_T c11_i1;
  int32_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_d = muDoubleScalarFloor(c11_b_table[0U].SimMin * 8.388608E+6);
    if (c11_d < 5.36870912E+8) {
      if (c11_d >= -5.36870912E+8) {
        c11_i = (int32_T)c11_d;
      } else {
        c11_i = -536870912;
      }
    } else if (c11_d >= 5.36870912E+8) {
      c11_i = 536870911;
    } else {
      c11_i = 0;
    }

    c11_localMin = c11_i;
    c11_d1 = muDoubleScalarFloor(c11_b_table[0U].SimMax * 8.388608E+6);
    if (c11_d1 < 5.36870912E+8) {
      if (c11_d1 >= -5.36870912E+8) {
        c11_i1 = (int32_T)c11_d1;
      } else {
        c11_i1 = -536870912;
      }
    } else if (c11_d1 >= 5.36870912E+8) {
      c11_i1 = 536870911;
    } else {
      c11_i1 = 0;
    }

    c11_localMax = c11_i1;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = (real_T)c11_in * 1.1920928955078125E-7;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = (real_T)c11_localMin * 1.1920928955078125E-7;
    c11_b_table[0U].SimMax = (real_T)c11_localMax * 1.1920928955078125E-7;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c11_in & 8388607U) != 0U) {
      c11_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c11_in;
}

static real_T c11_emlrt_update_log_8
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, real_T c11_in,
   emlrtLocationLoggingDataType c11_table[], int32_T c11_index)
{
  boolean_T c11_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c11_b_table;
  real_T c11_localMin;
  real_T c11_localMax;
  emlrtLocationLoggingHistogramType *c11_histTable;
  real_T c11_inDouble;
  real_T c11_significand;
  int32_T c11_exponent;
  (void)chartInstance;
  c11_isLoggingEnabledHere = (c11_index >= 0);
  if (c11_isLoggingEnabledHere) {
    c11_b_table = (emlrtLocationLoggingDataType *)&c11_table[c11_index];
    c11_localMin = c11_b_table[0U].SimMin;
    c11_localMax = c11_b_table[0U].SimMax;
    c11_histTable = c11_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c11_in < c11_localMin) {
      c11_localMin = c11_in;
    }

    if (c11_in > c11_localMax) {
      c11_localMax = c11_in;
    }

    /* Histogram logging. */
    c11_inDouble = c11_in;
    c11_histTable->TotalNumberOfValues++;
    if (c11_inDouble == 0.0) {
      c11_histTable->NumberOfZeros++;
    } else {
      c11_histTable->SimSum += c11_inDouble;
      if ((!muDoubleScalarIsInf(c11_inDouble)) && (!muDoubleScalarIsNaN
           (c11_inDouble))) {
        c11_significand = frexp(c11_inDouble, &c11_exponent);
        if (c11_exponent > 128) {
          c11_exponent = 128;
        }

        if (c11_exponent < -127) {
          c11_exponent = -127;
        }

        if (c11_significand < 0.0) {
          c11_histTable->NumberOfNegativeValues++;
          c11_histTable->HistogramOfNegativeValues[127 + c11_exponent]++;
        } else {
          c11_histTable->NumberOfPositiveValues++;
          c11_histTable->HistogramOfPositiveValues[127 + c11_exponent]++;
        }
      }
    }

    c11_b_table[0U].SimMin = c11_localMin;
    c11_b_table[0U].SimMax = c11_localMax;

    /* IsAlwaysInteger logging. */
    if (c11_in != muDoubleScalarFloor(c11_in)) {
      c11_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c11_in;
}

static void c11_emlrtInitVarDataTables
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c11_dataTables[18],
   emlrtLocationLoggingHistogramType c11_histTables[18])
{
  int32_T c11_i;
  int32_T c11_iH;
  (void)chartInstance;
  for (c11_i = 0; c11_i < 18; c11_i++) {
    c11_dataTables[c11_i].SimMin = rtInf;
    c11_dataTables[c11_i].SimMax = rtMinusInf;
    c11_dataTables[c11_i].OverflowWraps = 0;
    c11_dataTables[c11_i].Saturations = 0;
    c11_dataTables[c11_i].IsAlwaysInteger = true;
    c11_dataTables[c11_i].HistogramTable = &c11_histTables[c11_i];
    c11_histTables[c11_i].NumberOfZeros = 0.0;
    c11_histTables[c11_i].NumberOfPositiveValues = 0.0;
    c11_histTables[c11_i].NumberOfNegativeValues = 0.0;
    c11_histTables[c11_i].TotalNumberOfValues = 0.0;
    c11_histTables[c11_i].SimSum = 0.0;
    for (c11_iH = 0; c11_iH < 256; c11_iH++) {
      c11_histTables[c11_i].HistogramOfPositiveValues[c11_iH] = 0.0;
      c11_histTables[c11_i].HistogramOfNegativeValues[c11_iH] = 0.0;
    }
  }
}

const mxArray *sf_c11_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c11_nameCaptureInfo = NULL;
  c11_nameCaptureInfo = NULL;
  sf_mex_assign(&c11_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c11_nameCaptureInfo;
}

static int32_T c11_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_y, const char_T *c11_identifier)
{
  int32_T c11_c_y;
  emlrtMsgIdentifier c11_thisId;
  c11_thisId.fIdentifier = (const char *)c11_identifier;
  c11_thisId.fParent = NULL;
  c11_thisId.bParentIsCell = false;
  c11_c_y = c11_b_emlrt_marshallIn(chartInstance, c11_sp, sf_mex_dup(c11_b_y),
    &c11_thisId);
  sf_mex_destroy(&c11_b_y);
  return c11_c_y;
}

static int32_T c11_b_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId)
{
  int32_T c11_b_y;
  const mxArray *c11_mxFi = NULL;
  const mxArray *c11_mxInt = NULL;
  int32_T c11_i;
  (void)chartInstance;
  sf_mex_check_fi(c11_parentId, c11_b_u, false, 0U, NULL, c11_eml_mx,
                  c11_b_eml_mx);
  sf_mex_assign(&c11_mxFi, sf_mex_dup(c11_b_u), false);
  sf_mex_assign(&c11_mxInt, sf_mex_call(c11_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c11_mxFi)), false);
  sf_mex_import(c11_parentId, sf_mex_dup(c11_mxInt), &c11_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c11_mxFi);
  sf_mex_destroy(&c11_mxInt);
  c11_b_y = c11_i;
  sf_mex_destroy(&c11_mxFi);
  sf_mex_destroy(&c11_b_u);
  return c11_b_y;
}

static int32_T c11_c_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_acc, const char_T *c11_identifier,
   boolean_T *c11_svPtr)
{
  int32_T c11_b_y;
  emlrtMsgIdentifier c11_thisId;
  c11_thisId.fIdentifier = (const char *)c11_identifier;
  c11_thisId.fParent = NULL;
  c11_thisId.bParentIsCell = false;
  c11_b_y = c11_d_emlrt_marshallIn(chartInstance, c11_sp, sf_mex_dup(c11_b_acc),
    &c11_thisId, c11_svPtr);
  sf_mex_destroy(&c11_b_acc);
  return c11_b_y;
}

static int32_T c11_d_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId, boolean_T *c11_svPtr)
{
  int32_T c11_b_y;
  const mxArray *c11_mxFi = NULL;
  const mxArray *c11_mxInt = NULL;
  int32_T c11_i;
  (void)chartInstance;
  if (mxIsEmpty(c11_b_u)) {
    *c11_svPtr = false;
  } else {
    *c11_svPtr = true;
    sf_mex_check_fi(c11_parentId, c11_b_u, false, 0U, NULL, c11_eml_mx,
                    c11_c_eml_mx);
    sf_mex_assign(&c11_mxFi, sf_mex_dup(c11_b_u), false);
    sf_mex_assign(&c11_mxInt, sf_mex_call(c11_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c11_mxFi)), false);
    sf_mex_import(c11_parentId, sf_mex_dup(c11_mxInt), &c11_i, 1, 6, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c11_mxFi);
    sf_mex_destroy(&c11_mxInt);
    c11_b_y = c11_i;
  }

  sf_mex_destroy(&c11_mxFi);
  sf_mex_destroy(&c11_b_u);
  return c11_b_y;
}

static int32_T c11_e_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_avg, const char_T *c11_identifier,
   boolean_T *c11_svPtr)
{
  int32_T c11_b_y;
  emlrtMsgIdentifier c11_thisId;
  c11_thisId.fIdentifier = (const char *)c11_identifier;
  c11_thisId.fParent = NULL;
  c11_thisId.bParentIsCell = false;
  c11_b_y = c11_f_emlrt_marshallIn(chartInstance, c11_sp, sf_mex_dup(c11_b_avg),
    &c11_thisId, c11_svPtr);
  sf_mex_destroy(&c11_b_avg);
  return c11_b_y;
}

static int32_T c11_f_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId, boolean_T *c11_svPtr)
{
  int32_T c11_b_y;
  const mxArray *c11_mxFi = NULL;
  const mxArray *c11_mxInt = NULL;
  int32_T c11_i;
  (void)chartInstance;
  if (mxIsEmpty(c11_b_u)) {
    *c11_svPtr = false;
  } else {
    *c11_svPtr = true;
    sf_mex_check_fi(c11_parentId, c11_b_u, false, 0U, NULL, c11_eml_mx,
                    c11_b_eml_mx);
    sf_mex_assign(&c11_mxFi, sf_mex_dup(c11_b_u), false);
    sf_mex_assign(&c11_mxInt, sf_mex_call(c11_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c11_mxFi)), false);
    sf_mex_import(c11_parentId, sf_mex_dup(c11_mxInt), &c11_i, 1, 6, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c11_mxFi);
    sf_mex_destroy(&c11_mxInt);
    c11_b_y = c11_i;
  }

  sf_mex_destroy(&c11_mxFi);
  sf_mex_destroy(&c11_b_u);
  return c11_b_y;
}

static uint8_T c11_g_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_counter, const char_T
   *c11_identifier, boolean_T *c11_svPtr)
{
  uint8_T c11_b_y;
  emlrtMsgIdentifier c11_thisId;
  c11_thisId.fIdentifier = (const char *)c11_identifier;
  c11_thisId.fParent = NULL;
  c11_thisId.bParentIsCell = false;
  c11_b_y = c11_h_emlrt_marshallIn(chartInstance, c11_sp, sf_mex_dup
    (c11_b_counter), &c11_thisId, c11_svPtr);
  sf_mex_destroy(&c11_b_counter);
  return c11_b_y;
}

static uint8_T c11_h_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c11_sp, const mxArray *c11_b_u, const emlrtMsgIdentifier
   *c11_parentId, boolean_T *c11_svPtr)
{
  uint8_T c11_b_y;
  const mxArray *c11_mxFi = NULL;
  const mxArray *c11_mxInt = NULL;
  uint8_T c11_c_u;
  (void)chartInstance;
  if (mxIsEmpty(c11_b_u)) {
    *c11_svPtr = false;
  } else {
    *c11_svPtr = true;
    sf_mex_check_fi(c11_parentId, c11_b_u, false, 0U, NULL, c11_eml_mx,
                    c11_d_eml_mx);
    sf_mex_assign(&c11_mxFi, sf_mex_dup(c11_b_u), false);
    sf_mex_assign(&c11_mxInt, sf_mex_call(c11_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c11_mxFi)), false);
    sf_mex_import(c11_parentId, sf_mex_dup(c11_mxInt), &c11_c_u, 1, 3, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c11_mxFi);
    sf_mex_destroy(&c11_mxInt);
    c11_b_y = c11_c_u;
  }

  sf_mex_destroy(&c11_mxFi);
  sf_mex_destroy(&c11_b_u);
  return c11_b_y;
}

static uint8_T c11_i_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c11_b_is_active_c11_zeabus_hydrophone_concrete, const char_T *c11_identifier)
{
  uint8_T c11_b_y;
  emlrtMsgIdentifier c11_thisId;
  c11_thisId.fIdentifier = (const char *)c11_identifier;
  c11_thisId.fParent = NULL;
  c11_thisId.bParentIsCell = false;
  c11_b_y = c11_j_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c11_b_is_active_c11_zeabus_hydrophone_concrete), &c11_thisId);
  sf_mex_destroy(&c11_b_is_active_c11_zeabus_hydrophone_concrete);
  return c11_b_y;
}

static uint8_T c11_j_emlrt_marshallIn
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c11_b_u, const emlrtMsgIdentifier *c11_parentId)
{
  uint8_T c11_b_y;
  uint8_T c11_c_u;
  (void)chartInstance;
  sf_mex_import(c11_parentId, sf_mex_dup(c11_b_u), &c11_c_u, 1, 3, 0U, 0, 0U, 0);
  c11_b_y = c11_c_u;
  sf_mex_destroy(&c11_b_u);
  return c11_b_y;
}

static const mxArray *c11_chart_data_browse_helper
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c11_ssIdNumber)
{
  const mxArray *c11_mxData = NULL;
  int32_T c11_i;
  int32_T c11_i1;
  real_T c11_d;
  real_T c11_d1;
  c11_mxData = NULL;
  switch (c11_ssIdNumber) {
   case 4U:
    c11_i = *chartInstance->c11_u;
    c11_d = (real_T)c11_i * 7.62939453125E-6;
    sf_mex_assign(&c11_mxData, sf_mex_create("mxData", &c11_d, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 5U:
    c11_i1 = *chartInstance->c11_y;
    c11_d1 = (real_T)c11_i1 * 7.62939453125E-6;
    sf_mex_assign(&c11_mxData, sf_mex_create("mxData", &c11_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c11_mxData;
}

static int32_T c11__s32_shl_s32_(SFc11_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c11_b, int32_T c11_c, int32_T c11_EMLOvCount_src_loc,
  uint32_T c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T
  c11_length_src_loc)
{
  int32_T c11_a;
  int32_T c11_PICOffset;
  real_T c11_d;
  observerLogReadPIC(&c11_PICOffset);
  c11_a = c11_b << c11_c;
  if ((c11_b != c11_a >> c11_c) || ((uint32_T)c11_c > 31U)) {
    sf_data_overflow_error(chartInstance->S, c11_ssid_src_loc,
      c11_offset_src_loc, c11_length_src_loc);
    c11_d = 1.0;
    observerLog(c11_EMLOvCount_src_loc + c11_PICOffset, &c11_d, 1);
  }

  return c11_a;
}

static uint32_T c11__u32_add__(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c11_b, uint32_T c11_c, int32_T c11_EMLOvCount_src_loc,
  uint32_T c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T
  c11_length_src_loc)
{
  uint32_T c11_a;
  int32_T c11_PICOffset;
  real_T c11_d;
  observerLogReadPIC(&c11_PICOffset);
  c11_a = c11_b + c11_c;
  if (c11_a < c11_b) {
    sf_data_overflow_error(chartInstance->S, c11_ssid_src_loc,
      c11_offset_src_loc, c11_length_src_loc);
    c11_d = 1.0;
    observerLog(c11_EMLOvCount_src_loc + c11_PICOffset, &c11_d, 1);
  }

  return c11_a;
}

static uint8_T c11__u8_u32_(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c11_b, int32_T c11_EMLOvCount_src_loc, uint32_T
  c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T c11_length_src_loc)
{
  uint8_T c11_a;
  int32_T c11_PICOffset;
  real_T c11_d;
  observerLogReadPIC(&c11_PICOffset);
  c11_a = (uint8_T)c11_b;
  if (c11_a != c11_b) {
    sf_data_overflow_error(chartInstance->S, c11_ssid_src_loc,
      c11_offset_src_loc, c11_length_src_loc);
    c11_d = 1.0;
    observerLog(c11_EMLOvCount_src_loc + c11_PICOffset, &c11_d, 1);
  }

  return c11_a;
}

static int32_T c11__s32_add__(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c11_b, int32_T c11_c, int32_T c11_EMLOvCount_src_loc,
  uint32_T c11_ssid_src_loc, int32_T c11_offset_src_loc, int32_T
  c11_length_src_loc)
{
  int32_T c11_a;
  int32_T c11_PICOffset;
  real_T c11_d;
  observerLogReadPIC(&c11_PICOffset);
  c11_a = c11_b + c11_c;
  if (((c11_a ^ c11_b) & (c11_a ^ c11_c)) < 0) {
    sf_data_overflow_error(chartInstance->S, c11_ssid_src_loc,
      c11_offset_src_loc, c11_length_src_loc);
    c11_d = 1.0;
    observerLog(c11_EMLOvCount_src_loc + c11_PICOffset, &c11_d, 1);
  }

  return c11_a;
}

static void init_dsm_address_info(SFc11_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c11_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c11_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c11_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c11_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c11_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1201767455U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3387158271U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3170754769U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1421900040U);
}

mxArray *sf_c11_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c11_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c11_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c11_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiDewcbAAEQMHEDMxAABrFA+I5TNCBdngYsrAHFJZUEqSLy4KNkzBUjnJeaC+Ym"
    "lFZ55aflg8y0YEOazYTGfEcl8Tqg4BHywp0y/iANIvwGSfhYC+gWArEpouMDCh3z7BRwo0w+xn5"
    "D7mVHcz8yQmJwM1neBAX+8MqLFKxOUD9KTw5DJUAC134GA+5nQ3C8Ac7xDjAOEEUuVcBiy8VGWP"
    "jjiY0ESND6Sh1V8WBCID3aU+IDwk/NL80pSiwZHvCgkQOMlcZDEiwJV3BFBIF400OIFxM8sjk9M"
    "LsksS41PNjSMr0pNTCotjs+oTCnKL8jIzwOK5uclF6WWpML8CQDUUzlg"
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c11_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "sfcoMQwMlai0BppVMY0GPPD";
}

static void sf_opaque_initialize_c11_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c11_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c11_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c11_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c11_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c11_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c11_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc11_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c11_zeabus_hydrophone_concrete
      ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc11_zeabus_hydrophone_concrete
    ((SFc11_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c11_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c11_zeabus_hydrophone_concrete
      ((SFc11_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc11_zeabus_hydrophone_concrete
      ((SFc11_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c11_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [18] = {
    "eNrtV0tvI0UQbnuzWVaCyIeV9sIhNyJxyYoDe8PED7AUEy/OBpBApt1T9rTc0z30w0k48i+4rbR",
    "3zuyRGxckTvwD7vwCRPV4nJjxPNY4rMJjpPFMj7/6uqq+6poeUuv1CR57eDYfELKL19fwrJPFcT",
    "cd11bOxfMd8lY6fo4g6aIB1TQypPSQNIKPwSjhLFeyJycqF8blBDRIhthYaVvEZnjkBJezrpPM8",
    "5lPQs7CYaicCI7QlgYnUlwiW+zsAHnaXAOzXYDAhlq5adgVdHrlsbbnrRDYzLioLAQDduhi75bp",
    "O2F5LKBzAawnjaXosbn2bWiphZa9KAzTR2qGS6CKYsGpzI02pGYIMSbYwtM4wN8TZzGoLIyFVNs",
    "jCOkczDGfJZxKQpaTG/xjzCW1SnMqOpFoecN13wYC/emrAERJQtC3Iw10FisubbH+wy5G2pF0LK",
    "ANYzctZhvCV86Lf8bhHHRh3iYtNQdNp3AiCydNEtK5SNS6qpJ1mOURnFH9PkP9DASF1YuVY4YUd",
    "YJTtCiCQRJkz5xqPsf0FrK5qOcrs2rJuGghtqmCJWydOZSpcMXWZbJFhTCFsFMVH8McRMLappaW",
    "wxas+bhYq5hOsWoDTLIv8ZaSAV/TgjljVdTCcmsfH3+EnSLfuWtYT1rQE8ogb90aFkLgBGCg2Jl",
    "sMl0OacCNV6sClWpahSJm4mT7XOkZBlqy7K9D8BoUAiMzxexj7T41WOZlMJ/9Styyzx+S6z7/+k",
    "v0+aVd9nqwwlPL4SEr1+y89+vl89bxrrZ8L63YvZGZZydj53ENPH//sfndL+NvL959+4d3Xvz0z",
    "a/bzB/e2+y9uJeO31w2oKvynK9Vhcd+uOLXTg7/wxX+Rjo2E6b6T877gvLDozg+6392+MFg0E74",
    "vt8t9/duxt/l833fCS/jpK8ZzXpB+sL2Y+oWrzHP/3jF392KfNxPny+O397bzv5BM6vjToV9A+8",
    "uM3X71+dvNLezX18Hef7f+ZP/dwhlLLH7mWxWh/V07G0E4STOWU95/tcz/jeWzjc/by5uvriRPP",
    "xj9ZhPb4cez8apHuxfpcfjCj3uZfqhHzPl/Gbgduiy/2WqC70luuzfiB+fVuhykNHlINmnjyjuu",
    "ucwYo8ejb4GOnZmFF4GuCMM8ctkxJRkGizs3cA+YVM78r/drbCr/Qfje5l996u2I6/Ybtv4Nv3+",
    "2OZ7JdvvSAbf2GKevxu/7XfbJvg/AKG6f0A=",
    ""
  };

  static char newstr [1237] = "";
  newstr[0] = '\0';
  for (i = 0; i < 18; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c11_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c11_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(2923481342U));
  ssSetChecksum1(S,(2023318230U));
  ssSetChecksum2(S,(868297527U));
  ssSetChecksum3(S,(3850554809U));
}

static void mdlRTW_c11_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c11_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc11_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc11_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc11_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc11_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c11_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c11_zeabus_hydrophone_concrete;
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
    chartInstance->c11_JITStateAnimation,
    chartInstance->c11_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c11_zeabus_hydrophone_concrete(chartInstance);
}

void c11_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c11_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c11_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c11_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c11_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
