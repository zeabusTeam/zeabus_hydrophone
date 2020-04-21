/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c18_zeabus_hydrophone_concrete.h"
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
static const mxArray *c18_eml_mx;
static const mxArray *c18_b_eml_mx;
static emlrtRSInfo c18_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC4 Interface/Median Filter/Median Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:614"    /* pathName */
};

/* Function Declarations */
static void initialize_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c18_update_jit_animation_state_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c18_do_animation_call_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c18_st);
static void finalize_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c18_emlrt_update_log_1
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c18_in,
   emlrtLocationLoggingDataType c18_table[], int32_T c18_index);
static void c18_emlrt_update_log_2
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[5], emlrtLocationLoggingDataType c18_table[], int32_T c18_index,
   int32_T c18_out[5]);
static void c18_emlrt_update_log_3
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[4], emlrtLocationLoggingDataType c18_table[], int32_T c18_index,
   int32_T c18_out[4]);
static boolean_T c18_emlrt_update_log_4
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c18_in, emlrtLocationLoggingDataType c18_table[], int32_T c18_index);
static void c18_emlrtInitVarDataTables
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c18_dataTables[52],
   emlrtLocationLoggingHistogramType c18_histTables[52]);
static int32_T c18_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_y, const char_T *c18_identifier);
static int32_T c18_b_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_u, const emlrtMsgIdentifier
   *c18_parentId);
static void c18_c_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_d, const char_T *c18_identifier,
   boolean_T *c18_svPtr, int32_T c18_b_y[5]);
static void c18_d_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_u, const emlrtMsgIdentifier
   *c18_parentId, boolean_T *c18_svPtr, int32_T c18_b_y[5]);
static uint8_T c18_e_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c18_b_is_active_c18_zeabus_hydrophone_concrete, const char_T *c18_identifier);
static uint8_T c18_f_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c18_b_u, const emlrtMsgIdentifier *c18_parentId);
static const mxArray *c18_chart_data_browse_helper
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_ssIdNumber);
static void c18_b_emlrt_update_log_2
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[5], emlrtLocationLoggingDataType c18_table[], int32_T c18_index);
static void c18_b_emlrt_update_log_3
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[4], emlrtLocationLoggingDataType c18_table[], int32_T c18_index);
static void init_dsm_address_info(SFc18_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c18_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c18_st.tls = chartInstance->c18_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c18_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c18_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c18_d_not_empty = false;
  chartInstance->c18_is_active_c18_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c18_b_eml_mx, sf_mex_call(&c18_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c18_eml_mx, sf_mex_call(&c18_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c18_emlrtLocLogSimulated = false;
  c18_emlrtInitVarDataTables(chartInstance,
    chartInstance->c18_emlrtLocationLoggingDataTables,
    chartInstance->c18_emlrtLocLogHistTables);
}

static void initialize_params_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c18_update_jit_animation_state_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c18_do_animation_call_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c18_st;
  const mxArray *c18_b_y = NULL;
  const mxArray *c18_c_y = NULL;
  int32_T c18_b_u;
  const mxArray *c18_d_y = NULL;
  const mxArray *c18_e_y = NULL;
  int32_T c18_i;
  const mxArray *c18_f_y = NULL;
  int32_T c18_c_u[5];
  const mxArray *c18_g_y = NULL;
  c18_st = NULL;
  c18_st = NULL;
  c18_b_y = NULL;
  sf_mex_assign(&c18_b_y, sf_mex_createcellmatrix(3, 1), false);
  c18_c_y = NULL;
  c18_b_u = *chartInstance->c18_y;
  c18_d_y = NULL;
  sf_mex_assign(&c18_d_y, sf_mex_create("y", &c18_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c18_c_y, sf_mex_create_fi(sf_mex_dup(c18_eml_mx), sf_mex_dup
    (c18_b_eml_mx), "simulinkarray", c18_d_y, false, false), false);
  sf_mex_setcell(c18_b_y, 0, c18_c_y);
  c18_e_y = NULL;
  if (!chartInstance->c18_d_not_empty) {
    sf_mex_assign(&c18_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    for (c18_i = 0; c18_i < 5; c18_i++) {
      c18_c_u[c18_i] = chartInstance->c18_d[c18_i];
    }

    c18_f_y = NULL;
    sf_mex_assign(&c18_f_y, sf_mex_create("y", c18_c_u, 6, 0U, 1U, 0U, 2, 1, 5),
                  false);
    sf_mex_assign(&c18_e_y, sf_mex_create_fi(sf_mex_dup(c18_eml_mx), sf_mex_dup
      (c18_b_eml_mx), "simulinkarray", c18_f_y, true, false), false);
  }

  sf_mex_setcell(c18_b_y, 1, c18_e_y);
  c18_g_y = NULL;
  sf_mex_assign(&c18_g_y, sf_mex_create("y",
    &chartInstance->c18_is_active_c18_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c18_b_y, 2, c18_g_y);
  sf_mex_assign(&c18_st, c18_b_y, false);
  return c18_st;
}

static void set_sim_state_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c18_st)
{
  emlrtStack c18_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c18_b_u;
  int32_T c18_iv[5];
  int32_T c18_i;
  c18_b_st.tls = chartInstance->c18_fEmlrtCtx;
  chartInstance->c18_doneDoubleBufferReInit = true;
  c18_b_u = sf_mex_dup(c18_st);
  *chartInstance->c18_y = c18_emlrt_marshallIn(chartInstance, &c18_b_st,
    sf_mex_dup(sf_mex_getcell(c18_b_u, 0)), "y");
  c18_c_emlrt_marshallIn(chartInstance, &c18_b_st, sf_mex_dup(sf_mex_getcell
    (c18_b_u, 1)), "d", &chartInstance->c18_d_not_empty, c18_iv);
  for (c18_i = 0; c18_i < 5; c18_i++) {
    chartInstance->c18_d[c18_i] = c18_iv[c18_i];
  }

  chartInstance->c18_is_active_c18_zeabus_hydrophone_concrete =
    c18_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c18_b_u, 2)),
    "is_active_c18_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c18_b_u);
  sf_mex_destroy(&c18_st);
}

static void finalize_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c18_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:614", /* mexFileName */
    "Thu Apr 16 10:58:23 2020",        /* timestamp */
    "",                                /* buildDir */
    1,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c18_emlrtLocationLoggingFunctionInfoTable[1] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      52                               /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c18_emlrtLocationInfo[73] = { { 1,/* MxInfoID */
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
      137,                             /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 5,                            /* MxInfoID */
      199,                             /* TextStart */
      6,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      216,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      258,                             /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      262,                             /* TextStart */
      20,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      353,                             /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      410,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      417,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      447,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      454,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      487,                             /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      544,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      551,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      581,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      588,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      621,                             /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      678,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      685,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      715,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      722,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      755,                             /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      812,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      819,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      849,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      856,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      898,                             /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      956,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      963,                             /* TextStart */
      24,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      993,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1000,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1034,                            /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1093,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1100,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1131,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1138,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1172,                            /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1231,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1238,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1269,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1276,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1319,                            /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1378,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1385,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1416,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1423,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1457,                            /* TextStart */
      11,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1516,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1523,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1554,                            /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1561,                            /* TextStart */
      25,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1601,                            /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1605,                            /* TextStart */
      23,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      370,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      377,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      504,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      511,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      638,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      645,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      772,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      779,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      915,                             /* TextStart */
      5,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      922,                             /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1051,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1059,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1189,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1197,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1336,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1344,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1474,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    }, { 3,                            /* MxInfoID */
      1482,                            /* TextStart */
      6,                               /* TextLength */
      4,                               /* Reason */
      false                            /* MoreLocations */
    } };

  const int32_T c18_emlrtLocationLoggingFieldCounts[52] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c18_RuntimeVar);
  if (chartInstance->c18_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:614");
    emlrtLocationLoggingPushLog(&c18_emlrtLocationLoggingFileInfo,
      c18_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c18_emlrtLocationLoggingDataTables, c18_emlrtLocationInfo,
      NULL, 0U, c18_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:614");
  }

  sf_mex_destroy(&c18_eml_mx);
  sf_mex_destroy(&c18_b_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c18_covrtInstance);
}

static void sf_gateway_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c18_b_u;
  int32_T c18_varargin_1;
  int32_T c18_b_varargin_1;
  int32_T c18_var1;
  int32_T c18_hfi;
  int32_T c18_c_u;
  int32_T c18_i;
  int32_T c18_i1;
  int32_T c18_i2;
  int32_T c18_iv[4];
  int32_T c18_i3;
  int32_T c18_t[5];
  int32_T c18_a0;
  int32_T c18_b0;
  int32_T c18_a;
  int32_T c18_b;
  int32_T c18_b_a0;
  int32_T c18_b_b0;
  int32_T c18_a1;
  int32_T c18_b1;
  int32_T c18_b_a1;
  int32_T c18_b_b1;
  boolean_T c18_c;
  int32_T c18_i4;
  int32_T c18_i5;
  real_T c18_b_t;
  int32_T c18_c_varargin_1;
  int32_T c18_c_a0;
  int32_T c18_varargin_2;
  int32_T c18_c_b0;
  int32_T c18_fmo_1;
  int32_T c18_b_a;
  int32_T c18_fmo_2;
  int32_T c18_b_b;
  int32_T c18_b_fmo_1;
  int32_T c18_d_a0;
  int32_T c18_b_fmo_2;
  int32_T c18_d_b0;
  int32_T c18_d_varargin_1;
  int32_T c18_c_a1;
  int32_T c18_e_varargin_1;
  int32_T c18_c_b1;
  int32_T c18_b_var1;
  int32_T c18_d_a1;
  int32_T c18_b_hfi;
  int32_T c18_d_b1;
  boolean_T c18_b_c;
  int32_T c18_f_varargin_1;
  int32_T c18_i6;
  int32_T c18_g_varargin_1;
  int32_T c18_c_var1;
  int32_T c18_c_hfi;
  int32_T c18_i7;
  real_T c18_c_t;
  int32_T c18_h_varargin_1;
  int32_T c18_e_a0;
  int32_T c18_b_varargin_2;
  int32_T c18_e_b0;
  int32_T c18_fmo_3;
  int32_T c18_c_a;
  int32_T c18_fmo_4;
  int32_T c18_c_b;
  int32_T c18_b_fmo_3;
  int32_T c18_f_a0;
  int32_T c18_b_fmo_4;
  int32_T c18_f_b0;
  int32_T c18_i_varargin_1;
  int32_T c18_e_a1;
  int32_T c18_j_varargin_1;
  int32_T c18_e_b1;
  int32_T c18_d_var1;
  int32_T c18_f_a1;
  int32_T c18_d_hfi;
  int32_T c18_f_b1;
  boolean_T c18_c_c;
  int32_T c18_k_varargin_1;
  int32_T c18_i8;
  int32_T c18_l_varargin_1;
  int32_T c18_e_var1;
  int32_T c18_e_hfi;
  int32_T c18_i9;
  real_T c18_d_t;
  int32_T c18_m_varargin_1;
  int32_T c18_g_a0;
  int32_T c18_c_varargin_2;
  int32_T c18_g_b0;
  int32_T c18_fmo_5;
  int32_T c18_d_a;
  int32_T c18_fmo_6;
  int32_T c18_d_b;
  int32_T c18_b_fmo_5;
  int32_T c18_h_a0;
  int32_T c18_b_fmo_6;
  int32_T c18_h_b0;
  int32_T c18_n_varargin_1;
  int32_T c18_g_a1;
  int32_T c18_o_varargin_1;
  int32_T c18_g_b1;
  int32_T c18_f_var1;
  int32_T c18_h_a1;
  int32_T c18_f_hfi;
  int32_T c18_h_b1;
  boolean_T c18_d_c;
  int32_T c18_p_varargin_1;
  int32_T c18_i10;
  int32_T c18_q_varargin_1;
  int32_T c18_g_var1;
  int32_T c18_g_hfi;
  int32_T c18_i11;
  real_T c18_e_t;
  int32_T c18_r_varargin_1;
  int32_T c18_i_a0;
  int32_T c18_d_varargin_2;
  int32_T c18_i_b0;
  int32_T c18_fmo_7;
  int32_T c18_e_a;
  int32_T c18_fmo_8;
  int32_T c18_e_b;
  int32_T c18_b_fmo_7;
  int32_T c18_j_a0;
  int32_T c18_b_fmo_8;
  int32_T c18_j_b0;
  int32_T c18_s_varargin_1;
  int32_T c18_i_a1;
  int32_T c18_t_varargin_1;
  int32_T c18_i_b1;
  int32_T c18_h_var1;
  int32_T c18_j_a1;
  int32_T c18_h_hfi;
  int32_T c18_j_b1;
  boolean_T c18_e_c;
  int32_T c18_u_varargin_1;
  int32_T c18_i12;
  int32_T c18_v_varargin_1;
  int32_T c18_i_var1;
  int32_T c18_i_hfi;
  int32_T c18_i13;
  real_T c18_f_t;
  int32_T c18_w_varargin_1;
  int32_T c18_k_a0;
  int32_T c18_e_varargin_2;
  int32_T c18_k_b0;
  int32_T c18_fmo_9;
  int32_T c18_f_a;
  int32_T c18_fmo_10;
  int32_T c18_f_b;
  int32_T c18_b_fmo_9;
  int32_T c18_l_a0;
  int32_T c18_b_fmo_10;
  int32_T c18_l_b0;
  int32_T c18_x_varargin_1;
  int32_T c18_k_a1;
  int32_T c18_y_varargin_1;
  int32_T c18_k_b1;
  int32_T c18_j_var1;
  int32_T c18_l_a1;
  int32_T c18_j_hfi;
  int32_T c18_l_b1;
  boolean_T c18_f_c;
  int32_T c18_ab_varargin_1;
  int32_T c18_i14;
  int32_T c18_bb_varargin_1;
  int32_T c18_k_var1;
  int32_T c18_k_hfi;
  int32_T c18_i15;
  real_T c18_g_t;
  int32_T c18_cb_varargin_1;
  int32_T c18_m_a0;
  int32_T c18_f_varargin_2;
  int32_T c18_m_b0;
  int32_T c18_fmo_11;
  int32_T c18_g_a;
  int32_T c18_fmo_12;
  int32_T c18_g_b;
  int32_T c18_b_fmo_11;
  int32_T c18_n_a0;
  int32_T c18_b_fmo_12;
  int32_T c18_n_b0;
  int32_T c18_db_varargin_1;
  int32_T c18_m_a1;
  int32_T c18_eb_varargin_1;
  int32_T c18_m_b1;
  int32_T c18_l_var1;
  int32_T c18_n_a1;
  int32_T c18_l_hfi;
  int32_T c18_n_b1;
  boolean_T c18_g_c;
  int32_T c18_fb_varargin_1;
  int32_T c18_i16;
  int32_T c18_gb_varargin_1;
  int32_T c18_m_var1;
  int32_T c18_m_hfi;
  int32_T c18_i17;
  real_T c18_h_t;
  int32_T c18_hb_varargin_1;
  int32_T c18_o_a0;
  int32_T c18_g_varargin_2;
  int32_T c18_o_b0;
  int32_T c18_fmo_13;
  int32_T c18_h_a;
  int32_T c18_fmo_14;
  int32_T c18_h_b;
  int32_T c18_b_fmo_13;
  int32_T c18_p_a0;
  int32_T c18_b_fmo_14;
  int32_T c18_p_b0;
  int32_T c18_ib_varargin_1;
  int32_T c18_o_a1;
  int32_T c18_jb_varargin_1;
  int32_T c18_o_b1;
  int32_T c18_n_var1;
  int32_T c18_p_a1;
  int32_T c18_n_hfi;
  int32_T c18_p_b1;
  boolean_T c18_h_c;
  int32_T c18_kb_varargin_1;
  int32_T c18_i18;
  int32_T c18_lb_varargin_1;
  int32_T c18_o_var1;
  int32_T c18_o_hfi;
  int32_T c18_i19;
  real_T c18_i_t;
  int32_T c18_mb_varargin_1;
  int32_T c18_q_a0;
  int32_T c18_h_varargin_2;
  int32_T c18_q_b0;
  int32_T c18_fmo_15;
  int32_T c18_i_a;
  int32_T c18_fmo_16;
  int32_T c18_i_b;
  int32_T c18_b_fmo_15;
  int32_T c18_r_a0;
  int32_T c18_b_fmo_16;
  int32_T c18_r_b0;
  int32_T c18_nb_varargin_1;
  int32_T c18_q_a1;
  int32_T c18_ob_varargin_1;
  int32_T c18_q_b1;
  int32_T c18_p_var1;
  int32_T c18_r_a1;
  int32_T c18_p_hfi;
  int32_T c18_r_b1;
  boolean_T c18_i_c;
  int32_T c18_pb_varargin_1;
  int32_T c18_i20;
  int32_T c18_qb_varargin_1;
  int32_T c18_q_var1;
  int32_T c18_q_hfi;
  int32_T c18_i21;
  real_T c18_j_t;
  int32_T c18_rb_varargin_1;
  int32_T c18_sb_varargin_1;
  int32_T c18_i_varargin_2;
  int32_T c18_tb_varargin_1;
  int32_T c18_fmo_17;
  int32_T c18_r_var1;
  int32_T c18_fmo_18;
  int32_T c18_r_hfi;
  int32_T c18_b_fmo_17;
  int32_T c18_b_y;
  int32_T c18_b_fmo_18;
  int32_T c18_ub_varargin_1;
  int32_T c18_vb_varargin_1;
  int32_T c18_s_var1;
  int32_T c18_s_hfi;
  int32_T c18_wb_varargin_1;
  int32_T c18_xb_varargin_1;
  int32_T c18_t_var1;
  int32_T c18_t_hfi;
  chartInstance->c18_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c18_covrtInstance, 0U, (real_T)
                    *chartInstance->c18_u);
  chartInstance->c18_sfEvent = CALL_EVENT;
  c18_b_u = *chartInstance->c18_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c18_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c18_emlrt_update_log_1(chartInstance, c18_b_u,
    chartInstance->c18_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c18_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c18_covrtInstance, 4U, 0, 1);
  c18_varargin_1 = c18_b_u;
  c18_b_varargin_1 = c18_varargin_1;
  c18_var1 = c18_b_varargin_1;
  c18_hfi = c18_var1;
  c18_c_u = c18_emlrt_update_log_1(chartInstance, c18_hfi,
    chartInstance->c18_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 0,
                     !chartInstance->c18_d_not_empty)) {
    for (c18_i = 0; c18_i < 5; c18_i++) {
      chartInstance->c18_d[c18_i] = 0;
    }

    c18_b_emlrt_update_log_2(chartInstance, chartInstance->c18_d,
      chartInstance->c18_emlrtLocationLoggingDataTables, 2);
    chartInstance->c18_d_not_empty = true;
  }

  for (c18_i1 = 0; c18_i1 < 4; c18_i1++) {
    c18_iv[c18_i1] = chartInstance->c18_d[c18_i1 + 1];
  }

  for (c18_i2 = 0; c18_i2 < 4; c18_i2++) {
    chartInstance->c18_d[c18_i2] = c18_iv[c18_i2];
  }

  c18_b_emlrt_update_log_3(chartInstance, *(int32_T (*)[4])&chartInstance->
    c18_d[0], chartInstance->c18_emlrtLocationLoggingDataTables, 3);
  chartInstance->c18_d[4] = c18_emlrt_update_log_1(chartInstance, c18_c_u,
    chartInstance->c18_emlrtLocationLoggingDataTables, 4);
  for (c18_i3 = 0; c18_i3 < 5; c18_i3++) {
    c18_t[c18_i3] = chartInstance->c18_d[c18_i3];
  }

  c18_b_emlrt_update_log_2(chartInstance, c18_t,
    chartInstance->c18_emlrtLocationLoggingDataTables, 5);
  c18_a0 = c18_t[0];
  c18_b0 = c18_t[1];
  c18_a = c18_a0;
  c18_b = c18_b0;
  c18_b_a0 = c18_a;
  c18_b_b0 = c18_b;
  c18_a1 = c18_b_a0;
  c18_b1 = c18_b_b0;
  c18_b_a1 = c18_a1;
  c18_b_b1 = c18_b1;
  c18_c = (c18_b_a1 > c18_b_b1);
  c18_i4 = c18_t[1] - c18_t[0];
  if (c18_i4 > 131071) {
    c18_i4 = 131071;
  } else {
    if (c18_i4 < -131072) {
      c18_i4 = -131072;
    }
  }

  c18_i5 = c18_t[0] - c18_t[1];
  if (c18_i5 > 131071) {
    c18_i5 = 131071;
  } else {
    if (c18_i5 < -131072) {
      c18_i5 = -131072;
    }
  }

  if (c18_t[0] < c18_t[1]) {
    c18_b_t = (real_T)(c18_i4 <= 1);
  } else if (c18_t[0] > c18_t[1]) {
    if (c18_i5 <= 1) {
      c18_b_t = 3.0;
    } else {
      c18_b_t = 0.0;
    }
  } else {
    c18_b_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 1,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 0U, c18_b_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_c, chartInstance->c18_emlrtLocationLoggingDataTables,
         6)))) {
    c18_c_varargin_1 = c18_t[0];
    c18_varargin_2 = c18_t[1];
    c18_fmo_1 = c18_c_varargin_1;
    c18_fmo_2 = c18_varargin_2;
    c18_b_fmo_1 = c18_emlrt_update_log_1(chartInstance, c18_fmo_1,
      chartInstance->c18_emlrtLocationLoggingDataTables, 34);
    c18_b_fmo_2 = c18_emlrt_update_log_1(chartInstance, c18_fmo_2,
      chartInstance->c18_emlrtLocationLoggingDataTables, 35);
    c18_d_varargin_1 = c18_b_fmo_1;
    c18_e_varargin_1 = c18_d_varargin_1;
    c18_b_var1 = c18_e_varargin_1;
    c18_b_hfi = c18_b_var1;
    c18_t[1] = c18_emlrt_update_log_1(chartInstance, c18_b_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 7);
    c18_f_varargin_1 = c18_b_fmo_2;
    c18_g_varargin_1 = c18_f_varargin_1;
    c18_c_var1 = c18_g_varargin_1;
    c18_c_hfi = c18_c_var1;
    c18_t[0] = c18_emlrt_update_log_1(chartInstance, c18_c_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 8);
  }

  c18_c_a0 = c18_t[1];
  c18_c_b0 = c18_t[2];
  c18_b_a = c18_c_a0;
  c18_b_b = c18_c_b0;
  c18_d_a0 = c18_b_a;
  c18_d_b0 = c18_b_b;
  c18_c_a1 = c18_d_a0;
  c18_c_b1 = c18_d_b0;
  c18_d_a1 = c18_c_a1;
  c18_d_b1 = c18_c_b1;
  c18_b_c = (c18_d_a1 > c18_d_b1);
  c18_i6 = c18_t[2] - c18_t[1];
  if (c18_i6 > 131071) {
    c18_i6 = 131071;
  } else {
    if (c18_i6 < -131072) {
      c18_i6 = -131072;
    }
  }

  c18_i7 = c18_t[1] - c18_t[2];
  if (c18_i7 > 131071) {
    c18_i7 = 131071;
  } else {
    if (c18_i7 < -131072) {
      c18_i7 = -131072;
    }
  }

  if (c18_t[1] < c18_t[2]) {
    c18_c_t = (real_T)(c18_i6 <= 1);
  } else if (c18_t[1] > c18_t[2]) {
    if (c18_i7 <= 1) {
      c18_c_t = 3.0;
    } else {
      c18_c_t = 0.0;
    }
  } else {
    c18_c_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 2,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 1U, c18_c_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_b_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 9)))) {
    c18_h_varargin_1 = c18_t[1];
    c18_b_varargin_2 = c18_t[2];
    c18_fmo_3 = c18_h_varargin_1;
    c18_fmo_4 = c18_b_varargin_2;
    c18_b_fmo_3 = c18_emlrt_update_log_1(chartInstance, c18_fmo_3,
      chartInstance->c18_emlrtLocationLoggingDataTables, 36);
    c18_b_fmo_4 = c18_emlrt_update_log_1(chartInstance, c18_fmo_4,
      chartInstance->c18_emlrtLocationLoggingDataTables, 37);
    c18_i_varargin_1 = c18_b_fmo_3;
    c18_j_varargin_1 = c18_i_varargin_1;
    c18_d_var1 = c18_j_varargin_1;
    c18_d_hfi = c18_d_var1;
    c18_t[2] = c18_emlrt_update_log_1(chartInstance, c18_d_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 10);
    c18_k_varargin_1 = c18_b_fmo_4;
    c18_l_varargin_1 = c18_k_varargin_1;
    c18_e_var1 = c18_l_varargin_1;
    c18_e_hfi = c18_e_var1;
    c18_t[1] = c18_emlrt_update_log_1(chartInstance, c18_e_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 11);
  }

  c18_e_a0 = c18_t[2];
  c18_e_b0 = c18_t[3];
  c18_c_a = c18_e_a0;
  c18_c_b = c18_e_b0;
  c18_f_a0 = c18_c_a;
  c18_f_b0 = c18_c_b;
  c18_e_a1 = c18_f_a0;
  c18_e_b1 = c18_f_b0;
  c18_f_a1 = c18_e_a1;
  c18_f_b1 = c18_e_b1;
  c18_c_c = (c18_f_a1 > c18_f_b1);
  c18_i8 = c18_t[3] - c18_t[2];
  if (c18_i8 > 131071) {
    c18_i8 = 131071;
  } else {
    if (c18_i8 < -131072) {
      c18_i8 = -131072;
    }
  }

  c18_i9 = c18_t[2] - c18_t[3];
  if (c18_i9 > 131071) {
    c18_i9 = 131071;
  } else {
    if (c18_i9 < -131072) {
      c18_i9 = -131072;
    }
  }

  if (c18_t[2] < c18_t[3]) {
    c18_d_t = (real_T)(c18_i8 <= 1);
  } else if (c18_t[2] > c18_t[3]) {
    if (c18_i9 <= 1) {
      c18_d_t = 3.0;
    } else {
      c18_d_t = 0.0;
    }
  } else {
    c18_d_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 2U, c18_d_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_c_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 12)))) {
    c18_m_varargin_1 = c18_t[2];
    c18_c_varargin_2 = c18_t[3];
    c18_fmo_5 = c18_m_varargin_1;
    c18_fmo_6 = c18_c_varargin_2;
    c18_b_fmo_5 = c18_emlrt_update_log_1(chartInstance, c18_fmo_5,
      chartInstance->c18_emlrtLocationLoggingDataTables, 38);
    c18_b_fmo_6 = c18_emlrt_update_log_1(chartInstance, c18_fmo_6,
      chartInstance->c18_emlrtLocationLoggingDataTables, 39);
    c18_n_varargin_1 = c18_b_fmo_5;
    c18_o_varargin_1 = c18_n_varargin_1;
    c18_f_var1 = c18_o_varargin_1;
    c18_f_hfi = c18_f_var1;
    c18_t[3] = c18_emlrt_update_log_1(chartInstance, c18_f_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 13);
    c18_p_varargin_1 = c18_b_fmo_6;
    c18_q_varargin_1 = c18_p_varargin_1;
    c18_g_var1 = c18_q_varargin_1;
    c18_g_hfi = c18_g_var1;
    c18_t[2] = c18_emlrt_update_log_1(chartInstance, c18_g_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 14);
  }

  c18_g_a0 = c18_t[3];
  c18_g_b0 = c18_t[4];
  c18_d_a = c18_g_a0;
  c18_d_b = c18_g_b0;
  c18_h_a0 = c18_d_a;
  c18_h_b0 = c18_d_b;
  c18_g_a1 = c18_h_a0;
  c18_g_b1 = c18_h_b0;
  c18_h_a1 = c18_g_a1;
  c18_h_b1 = c18_g_b1;
  c18_d_c = (c18_h_a1 > c18_h_b1);
  c18_i10 = c18_t[4] - c18_t[3];
  if (c18_i10 > 131071) {
    c18_i10 = 131071;
  } else {
    if (c18_i10 < -131072) {
      c18_i10 = -131072;
    }
  }

  c18_i11 = c18_t[3] - c18_t[4];
  if (c18_i11 > 131071) {
    c18_i11 = 131071;
  } else {
    if (c18_i11 < -131072) {
      c18_i11 = -131072;
    }
  }

  if (c18_t[3] < c18_t[4]) {
    c18_e_t = (real_T)(c18_i10 <= 1);
  } else if (c18_t[3] > c18_t[4]) {
    if (c18_i11 <= 1) {
      c18_e_t = 3.0;
    } else {
      c18_e_t = 0.0;
    }
  } else {
    c18_e_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 4,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 3U, c18_e_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_d_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 15)))) {
    c18_r_varargin_1 = c18_t[3];
    c18_d_varargin_2 = c18_t[4];
    c18_fmo_7 = c18_r_varargin_1;
    c18_fmo_8 = c18_d_varargin_2;
    c18_b_fmo_7 = c18_emlrt_update_log_1(chartInstance, c18_fmo_7,
      chartInstance->c18_emlrtLocationLoggingDataTables, 40);
    c18_b_fmo_8 = c18_emlrt_update_log_1(chartInstance, c18_fmo_8,
      chartInstance->c18_emlrtLocationLoggingDataTables, 41);
    c18_s_varargin_1 = c18_b_fmo_7;
    c18_t_varargin_1 = c18_s_varargin_1;
    c18_h_var1 = c18_t_varargin_1;
    c18_h_hfi = c18_h_var1;
    c18_emlrt_update_log_1(chartInstance, c18_h_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 16);
    c18_u_varargin_1 = c18_b_fmo_8;
    c18_v_varargin_1 = c18_u_varargin_1;
    c18_i_var1 = c18_v_varargin_1;
    c18_i_hfi = c18_i_var1;
    c18_t[3] = c18_emlrt_update_log_1(chartInstance, c18_i_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 17);
  }

  c18_i_a0 = c18_t[0];
  c18_i_b0 = c18_t[1];
  c18_e_a = c18_i_a0;
  c18_e_b = c18_i_b0;
  c18_j_a0 = c18_e_a;
  c18_j_b0 = c18_e_b;
  c18_i_a1 = c18_j_a0;
  c18_i_b1 = c18_j_b0;
  c18_j_a1 = c18_i_a1;
  c18_j_b1 = c18_i_b1;
  c18_e_c = (c18_j_a1 > c18_j_b1);
  c18_i12 = c18_t[1] - c18_t[0];
  if (c18_i12 > 131071) {
    c18_i12 = 131071;
  } else {
    if (c18_i12 < -131072) {
      c18_i12 = -131072;
    }
  }

  c18_i13 = c18_t[0] - c18_t[1];
  if (c18_i13 > 131071) {
    c18_i13 = 131071;
  } else {
    if (c18_i13 < -131072) {
      c18_i13 = -131072;
    }
  }

  if (c18_t[0] < c18_t[1]) {
    c18_f_t = (real_T)(c18_i12 <= 1);
  } else if (c18_t[0] > c18_t[1]) {
    if (c18_i13 <= 1) {
      c18_f_t = 3.0;
    } else {
      c18_f_t = 0.0;
    }
  } else {
    c18_f_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 5,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 4U, c18_f_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_e_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 18)))) {
    c18_w_varargin_1 = c18_t[0];
    c18_e_varargin_2 = c18_t[1];
    c18_fmo_9 = c18_w_varargin_1;
    c18_fmo_10 = c18_e_varargin_2;
    c18_b_fmo_9 = c18_emlrt_update_log_1(chartInstance, c18_fmo_9,
      chartInstance->c18_emlrtLocationLoggingDataTables, 42);
    c18_b_fmo_10 = c18_emlrt_update_log_1(chartInstance, c18_fmo_10,
      chartInstance->c18_emlrtLocationLoggingDataTables, 43);
    c18_x_varargin_1 = c18_b_fmo_9;
    c18_y_varargin_1 = c18_x_varargin_1;
    c18_j_var1 = c18_y_varargin_1;
    c18_j_hfi = c18_j_var1;
    c18_t[1] = c18_emlrt_update_log_1(chartInstance, c18_j_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 19);
    c18_ab_varargin_1 = c18_b_fmo_10;
    c18_bb_varargin_1 = c18_ab_varargin_1;
    c18_k_var1 = c18_bb_varargin_1;
    c18_k_hfi = c18_k_var1;
    c18_t[0] = c18_emlrt_update_log_1(chartInstance, c18_k_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 20);
  }

  c18_k_a0 = c18_t[1];
  c18_k_b0 = c18_t[2];
  c18_f_a = c18_k_a0;
  c18_f_b = c18_k_b0;
  c18_l_a0 = c18_f_a;
  c18_l_b0 = c18_f_b;
  c18_k_a1 = c18_l_a0;
  c18_k_b1 = c18_l_b0;
  c18_l_a1 = c18_k_a1;
  c18_l_b1 = c18_k_b1;
  c18_f_c = (c18_l_a1 > c18_l_b1);
  c18_i14 = c18_t[2] - c18_t[1];
  if (c18_i14 > 131071) {
    c18_i14 = 131071;
  } else {
    if (c18_i14 < -131072) {
      c18_i14 = -131072;
    }
  }

  c18_i15 = c18_t[1] - c18_t[2];
  if (c18_i15 > 131071) {
    c18_i15 = 131071;
  } else {
    if (c18_i15 < -131072) {
      c18_i15 = -131072;
    }
  }

  if (c18_t[1] < c18_t[2]) {
    c18_g_t = (real_T)(c18_i14 <= 1);
  } else if (c18_t[1] > c18_t[2]) {
    if (c18_i15 <= 1) {
      c18_g_t = 3.0;
    } else {
      c18_g_t = 0.0;
    }
  } else {
    c18_g_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 6,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 5U, c18_g_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_f_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 21)))) {
    c18_cb_varargin_1 = c18_t[1];
    c18_f_varargin_2 = c18_t[2];
    c18_fmo_11 = c18_cb_varargin_1;
    c18_fmo_12 = c18_f_varargin_2;
    c18_b_fmo_11 = c18_emlrt_update_log_1(chartInstance, c18_fmo_11,
      chartInstance->c18_emlrtLocationLoggingDataTables, 44);
    c18_b_fmo_12 = c18_emlrt_update_log_1(chartInstance, c18_fmo_12,
      chartInstance->c18_emlrtLocationLoggingDataTables, 45);
    c18_db_varargin_1 = c18_b_fmo_11;
    c18_eb_varargin_1 = c18_db_varargin_1;
    c18_l_var1 = c18_eb_varargin_1;
    c18_l_hfi = c18_l_var1;
    c18_t[2] = c18_emlrt_update_log_1(chartInstance, c18_l_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 22);
    c18_fb_varargin_1 = c18_b_fmo_12;
    c18_gb_varargin_1 = c18_fb_varargin_1;
    c18_m_var1 = c18_gb_varargin_1;
    c18_m_hfi = c18_m_var1;
    c18_t[1] = c18_emlrt_update_log_1(chartInstance, c18_m_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 23);
  }

  c18_m_a0 = c18_t[2];
  c18_m_b0 = c18_t[3];
  c18_g_a = c18_m_a0;
  c18_g_b = c18_m_b0;
  c18_n_a0 = c18_g_a;
  c18_n_b0 = c18_g_b;
  c18_m_a1 = c18_n_a0;
  c18_m_b1 = c18_n_b0;
  c18_n_a1 = c18_m_a1;
  c18_n_b1 = c18_m_b1;
  c18_g_c = (c18_n_a1 > c18_n_b1);
  c18_i16 = c18_t[3] - c18_t[2];
  if (c18_i16 > 131071) {
    c18_i16 = 131071;
  } else {
    if (c18_i16 < -131072) {
      c18_i16 = -131072;
    }
  }

  c18_i17 = c18_t[2] - c18_t[3];
  if (c18_i17 > 131071) {
    c18_i17 = 131071;
  } else {
    if (c18_i17 < -131072) {
      c18_i17 = -131072;
    }
  }

  if (c18_t[2] < c18_t[3]) {
    c18_h_t = (real_T)(c18_i16 <= 1);
  } else if (c18_t[2] > c18_t[3]) {
    if (c18_i17 <= 1) {
      c18_h_t = 3.0;
    } else {
      c18_h_t = 0.0;
    }
  } else {
    c18_h_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 7,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 6U, c18_h_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_g_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 24)))) {
    c18_hb_varargin_1 = c18_t[2];
    c18_g_varargin_2 = c18_t[3];
    c18_fmo_13 = c18_hb_varargin_1;
    c18_fmo_14 = c18_g_varargin_2;
    c18_b_fmo_13 = c18_emlrt_update_log_1(chartInstance, c18_fmo_13,
      chartInstance->c18_emlrtLocationLoggingDataTables, 46);
    c18_b_fmo_14 = c18_emlrt_update_log_1(chartInstance, c18_fmo_14,
      chartInstance->c18_emlrtLocationLoggingDataTables, 47);
    c18_ib_varargin_1 = c18_b_fmo_13;
    c18_jb_varargin_1 = c18_ib_varargin_1;
    c18_n_var1 = c18_jb_varargin_1;
    c18_n_hfi = c18_n_var1;
    c18_emlrt_update_log_1(chartInstance, c18_n_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 25);
    c18_kb_varargin_1 = c18_b_fmo_14;
    c18_lb_varargin_1 = c18_kb_varargin_1;
    c18_o_var1 = c18_lb_varargin_1;
    c18_o_hfi = c18_o_var1;
    c18_t[2] = c18_emlrt_update_log_1(chartInstance, c18_o_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 26);
  }

  c18_o_a0 = c18_t[0];
  c18_o_b0 = c18_t[1];
  c18_h_a = c18_o_a0;
  c18_h_b = c18_o_b0;
  c18_p_a0 = c18_h_a;
  c18_p_b0 = c18_h_b;
  c18_o_a1 = c18_p_a0;
  c18_o_b1 = c18_p_b0;
  c18_p_a1 = c18_o_a1;
  c18_p_b1 = c18_o_b1;
  c18_h_c = (c18_p_a1 > c18_p_b1);
  c18_i18 = c18_t[1] - c18_t[0];
  if (c18_i18 > 131071) {
    c18_i18 = 131071;
  } else {
    if (c18_i18 < -131072) {
      c18_i18 = -131072;
    }
  }

  c18_i19 = c18_t[0] - c18_t[1];
  if (c18_i19 > 131071) {
    c18_i19 = 131071;
  } else {
    if (c18_i19 < -131072) {
      c18_i19 = -131072;
    }
  }

  if (c18_t[0] < c18_t[1]) {
    c18_i_t = (real_T)(c18_i18 <= 1);
  } else if (c18_t[0] > c18_t[1]) {
    if (c18_i19 <= 1) {
      c18_i_t = 3.0;
    } else {
      c18_i_t = 0.0;
    }
  } else {
    c18_i_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 8,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 7U, c18_i_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_h_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 27)))) {
    c18_mb_varargin_1 = c18_t[0];
    c18_h_varargin_2 = c18_t[1];
    c18_fmo_15 = c18_mb_varargin_1;
    c18_fmo_16 = c18_h_varargin_2;
    c18_b_fmo_15 = c18_emlrt_update_log_1(chartInstance, c18_fmo_15,
      chartInstance->c18_emlrtLocationLoggingDataTables, 48);
    c18_b_fmo_16 = c18_emlrt_update_log_1(chartInstance, c18_fmo_16,
      chartInstance->c18_emlrtLocationLoggingDataTables, 49);
    c18_nb_varargin_1 = c18_b_fmo_15;
    c18_ob_varargin_1 = c18_nb_varargin_1;
    c18_p_var1 = c18_ob_varargin_1;
    c18_p_hfi = c18_p_var1;
    c18_t[1] = c18_emlrt_update_log_1(chartInstance, c18_p_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 28);
    c18_pb_varargin_1 = c18_b_fmo_16;
    c18_qb_varargin_1 = c18_pb_varargin_1;
    c18_q_var1 = c18_qb_varargin_1;
    c18_q_hfi = c18_q_var1;
    c18_emlrt_update_log_1(chartInstance, c18_q_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 29);
  }

  c18_q_a0 = c18_t[1];
  c18_q_b0 = c18_t[2];
  c18_i_a = c18_q_a0;
  c18_i_b = c18_q_b0;
  c18_r_a0 = c18_i_a;
  c18_r_b0 = c18_i_b;
  c18_q_a1 = c18_r_a0;
  c18_q_b1 = c18_r_b0;
  c18_r_a1 = c18_q_a1;
  c18_r_b1 = c18_q_b1;
  c18_i_c = (c18_r_a1 > c18_r_b1);
  c18_i20 = c18_t[2] - c18_t[1];
  if (c18_i20 > 131071) {
    c18_i20 = 131071;
  } else {
    if (c18_i20 < -131072) {
      c18_i20 = -131072;
    }
  }

  c18_i21 = c18_t[1] - c18_t[2];
  if (c18_i21 > 131071) {
    c18_i21 = 131071;
  } else {
    if (c18_i21 < -131072) {
      c18_i21 = -131072;
    }
  }

  if (c18_t[1] < c18_t[2]) {
    c18_j_t = (real_T)(c18_i20 <= 1);
  } else if (c18_t[1] > c18_t[2]) {
    if (c18_i21 <= 1) {
      c18_j_t = 3.0;
    } else {
      c18_j_t = 0.0;
    }
  } else {
    c18_j_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c18_covrtInstance, 4U, 0, 9,
                     covrtRelationalopUpdateFcn(chartInstance->c18_covrtInstance,
        4U, 0U, 8U, c18_j_t, 0.0, -2, 4U, (int32_T)c18_emlrt_update_log_4
        (chartInstance, c18_i_c,
         chartInstance->c18_emlrtLocationLoggingDataTables, 30)))) {
    c18_rb_varargin_1 = c18_t[1];
    c18_i_varargin_2 = c18_t[2];
    c18_fmo_17 = c18_rb_varargin_1;
    c18_fmo_18 = c18_i_varargin_2;
    c18_b_fmo_17 = c18_emlrt_update_log_1(chartInstance, c18_fmo_17,
      chartInstance->c18_emlrtLocationLoggingDataTables, 50);
    c18_b_fmo_18 = c18_emlrt_update_log_1(chartInstance, c18_fmo_18,
      chartInstance->c18_emlrtLocationLoggingDataTables, 51);
    c18_ub_varargin_1 = c18_b_fmo_17;
    c18_vb_varargin_1 = c18_ub_varargin_1;
    c18_s_var1 = c18_vb_varargin_1;
    c18_s_hfi = c18_s_var1;
    c18_t[2] = c18_emlrt_update_log_1(chartInstance, c18_s_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 31);
    c18_wb_varargin_1 = c18_b_fmo_18;
    c18_xb_varargin_1 = c18_wb_varargin_1;
    c18_t_var1 = c18_xb_varargin_1;
    c18_t_hfi = c18_t_var1;
    c18_emlrt_update_log_1(chartInstance, c18_t_hfi,
      chartInstance->c18_emlrtLocationLoggingDataTables, 32);
  }

  c18_sb_varargin_1 = c18_t[2];
  c18_tb_varargin_1 = c18_sb_varargin_1;
  c18_r_var1 = c18_tb_varargin_1;
  c18_r_hfi = c18_r_var1;
  c18_b_y = c18_emlrt_update_log_1(chartInstance, c18_r_hfi,
    chartInstance->c18_emlrtLocationLoggingDataTables, 33);
  *chartInstance->c18_y = c18_b_y;
  c18_do_animation_call_c18_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c18_covrtInstance, 1U, (real_T)
                    *chartInstance->c18_y);
}

static void mdl_start_c18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c18_decisionTxtStartIdx = 0U;
  static const uint32_T c18_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c18_chart_data_browse_helper);
  chartInstance->c18_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c18_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c18_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c18_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c18_decisionTxtStartIdx, &c18_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c18_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c18_covrtInstance, "", 4U, 0U, 2U, 0U, 10U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 1633);
  covrtEmlFcnInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 1U, "get_fimath",
                     1636, -1, 1890);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 0U, 116, 130, -1,
                    178);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 1U, 350, 364, -1,
                    483);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 2U, 484, 498, -1,
                    617);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 3U, 618, 632, -1,
                    751);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 4U, 752, 766, -1,
                    885);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 5U, 895, 909, -1,
                    1030);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 6U, 1031, 1045, -1,
                    1168);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 7U, 1169, 1183, -1,
                    1306);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 8U, 1316, 1330, -1,
                    1453);
  covrtEmlIfInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 9U, 1454, 1468, -1,
                    1591);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 0U, 353,
    364, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 1U, 487,
    498, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 2U, 621,
    632, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 3U, 755,
    766, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 4U, 898,
    909, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 5U, 1034,
    1045, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 6U, 1172,
    1183, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 7U, 1319,
    1330, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c18_covrtInstance, 4U, 0U, 8U, 1457,
    1468, -2, 4U);
}

static void initSimStructsc18_zeabus_hydrophone_concrete
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c18_emlrt_update_log_1
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c18_in,
   emlrtLocationLoggingDataType c18_table[], int32_T c18_index)
{
  boolean_T c18_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c18_b_table;
  real_T c18_b_d;
  int32_T c18_i;
  int32_T c18_localMin;
  real_T c18_d1;
  int32_T c18_i1;
  int32_T c18_localMax;
  emlrtLocationLoggingHistogramType *c18_histTable;
  real_T c18_inDouble;
  real_T c18_significand;
  int32_T c18_exponent;
  (void)chartInstance;
  c18_isLoggingEnabledHere = (c18_index >= 0);
  if (c18_isLoggingEnabledHere) {
    c18_b_table = (emlrtLocationLoggingDataType *)&c18_table[c18_index];
    c18_b_d = muDoubleScalarFloor(c18_b_table[0U].SimMin * 131072.0);
    if (c18_b_d < 131072.0) {
      if (c18_b_d >= -131072.0) {
        c18_i = (int32_T)c18_b_d;
      } else {
        c18_i = -131072;
      }
    } else if (c18_b_d >= 131072.0) {
      c18_i = 131071;
    } else {
      c18_i = 0;
    }

    c18_localMin = c18_i;
    c18_d1 = muDoubleScalarFloor(c18_b_table[0U].SimMax * 131072.0);
    if (c18_d1 < 131072.0) {
      if (c18_d1 >= -131072.0) {
        c18_i1 = (int32_T)c18_d1;
      } else {
        c18_i1 = -131072;
      }
    } else if (c18_d1 >= 131072.0) {
      c18_i1 = 131071;
    } else {
      c18_i1 = 0;
    }

    c18_localMax = c18_i1;
    c18_histTable = c18_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c18_in < c18_localMin) {
      c18_localMin = c18_in;
    }

    if (c18_in > c18_localMax) {
      c18_localMax = c18_in;
    }

    /* Histogram logging. */
    c18_inDouble = (real_T)c18_in * 7.62939453125E-6;
    c18_histTable->TotalNumberOfValues++;
    if (c18_inDouble == 0.0) {
      c18_histTable->NumberOfZeros++;
    } else {
      c18_histTable->SimSum += c18_inDouble;
      if ((!muDoubleScalarIsInf(c18_inDouble)) && (!muDoubleScalarIsNaN
           (c18_inDouble))) {
        c18_significand = frexp(c18_inDouble, &c18_exponent);
        if (c18_exponent > 128) {
          c18_exponent = 128;
        }

        if (c18_exponent < -127) {
          c18_exponent = -127;
        }

        if (c18_significand < 0.0) {
          c18_histTable->NumberOfNegativeValues++;
          c18_histTable->HistogramOfNegativeValues[127 + c18_exponent]++;
        } else {
          c18_histTable->NumberOfPositiveValues++;
          c18_histTable->HistogramOfPositiveValues[127 + c18_exponent]++;
        }
      }
    }

    c18_b_table[0U].SimMin = (real_T)c18_localMin * 7.62939453125E-6;
    c18_b_table[0U].SimMax = (real_T)c18_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c18_in & 131071U) != 0U) {
      c18_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c18_in;
}

static void c18_emlrt_update_log_2
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[5], emlrtLocationLoggingDataType c18_table[], int32_T c18_index,
   int32_T c18_out[5])
{
  int32_T c18_i;
  for (c18_i = 0; c18_i < 5; c18_i++) {
    c18_out[c18_i] = c18_in[c18_i];
  }

  c18_b_emlrt_update_log_2(chartInstance, c18_out, c18_table, c18_index);
}

static void c18_emlrt_update_log_3
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[4], emlrtLocationLoggingDataType c18_table[], int32_T c18_index,
   int32_T c18_out[4])
{
  int32_T c18_i;
  for (c18_i = 0; c18_i < 4; c18_i++) {
    c18_out[c18_i] = c18_in[c18_i];
  }

  c18_b_emlrt_update_log_3(chartInstance, c18_out, c18_table, c18_index);
}

static boolean_T c18_emlrt_update_log_4
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c18_in, emlrtLocationLoggingDataType c18_table[], int32_T c18_index)
{
  boolean_T c18_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c18_b_table;
  boolean_T c18_localMin;
  boolean_T c18_localMax;
  emlrtLocationLoggingHistogramType *c18_histTable;
  real_T c18_inDouble;
  real_T c18_significand;
  int32_T c18_exponent;
  (void)chartInstance;
  c18_isLoggingEnabledHere = (c18_index >= 0);
  if (c18_isLoggingEnabledHere) {
    c18_b_table = (emlrtLocationLoggingDataType *)&c18_table[c18_index];
    c18_localMin = (c18_b_table[0U].SimMin > 0.0);
    c18_localMax = (c18_b_table[0U].SimMax > 0.0);
    c18_histTable = c18_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c18_in < (int32_T)c18_localMin) {
      c18_localMin = c18_in;
    }

    if ((int32_T)c18_in > (int32_T)c18_localMax) {
      c18_localMax = c18_in;
    }

    /* Histogram logging. */
    c18_inDouble = (real_T)c18_in;
    c18_histTable->TotalNumberOfValues++;
    if (c18_inDouble == 0.0) {
      c18_histTable->NumberOfZeros++;
    } else {
      c18_histTable->SimSum += c18_inDouble;
      if ((!muDoubleScalarIsInf(c18_inDouble)) && (!muDoubleScalarIsNaN
           (c18_inDouble))) {
        c18_significand = frexp(c18_inDouble, &c18_exponent);
        if (c18_exponent > 128) {
          c18_exponent = 128;
        }

        if (c18_exponent < -127) {
          c18_exponent = -127;
        }

        if (c18_significand < 0.0) {
          c18_histTable->NumberOfNegativeValues++;
          c18_histTable->HistogramOfNegativeValues[127 + c18_exponent]++;
        } else {
          c18_histTable->NumberOfPositiveValues++;
          c18_histTable->HistogramOfPositiveValues[127 + c18_exponent]++;
        }
      }
    }

    c18_b_table[0U].SimMin = (real_T)c18_localMin;
    c18_b_table[0U].SimMax = (real_T)c18_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c18_in;
}

static void c18_emlrtInitVarDataTables
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c18_dataTables[52],
   emlrtLocationLoggingHistogramType c18_histTables[52])
{
  int32_T c18_i;
  int32_T c18_iH;
  (void)chartInstance;
  for (c18_i = 0; c18_i < 52; c18_i++) {
    c18_dataTables[c18_i].SimMin = rtInf;
    c18_dataTables[c18_i].SimMax = rtMinusInf;
    c18_dataTables[c18_i].OverflowWraps = 0;
    c18_dataTables[c18_i].Saturations = 0;
    c18_dataTables[c18_i].IsAlwaysInteger = true;
    c18_dataTables[c18_i].HistogramTable = &c18_histTables[c18_i];
    c18_histTables[c18_i].NumberOfZeros = 0.0;
    c18_histTables[c18_i].NumberOfPositiveValues = 0.0;
    c18_histTables[c18_i].NumberOfNegativeValues = 0.0;
    c18_histTables[c18_i].TotalNumberOfValues = 0.0;
    c18_histTables[c18_i].SimSum = 0.0;
    for (c18_iH = 0; c18_iH < 256; c18_iH++) {
      c18_histTables[c18_i].HistogramOfPositiveValues[c18_iH] = 0.0;
      c18_histTables[c18_i].HistogramOfNegativeValues[c18_iH] = 0.0;
    }
  }
}

const mxArray *sf_c18_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c18_nameCaptureInfo = NULL;
  c18_nameCaptureInfo = NULL;
  sf_mex_assign(&c18_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c18_nameCaptureInfo;
}

static int32_T c18_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_y, const char_T *c18_identifier)
{
  int32_T c18_c_y;
  emlrtMsgIdentifier c18_thisId;
  c18_thisId.fIdentifier = (const char *)c18_identifier;
  c18_thisId.fParent = NULL;
  c18_thisId.bParentIsCell = false;
  c18_c_y = c18_b_emlrt_marshallIn(chartInstance, c18_sp, sf_mex_dup(c18_b_y),
    &c18_thisId);
  sf_mex_destroy(&c18_b_y);
  return c18_c_y;
}

static int32_T c18_b_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_u, const emlrtMsgIdentifier
   *c18_parentId)
{
  int32_T c18_b_y;
  const mxArray *c18_mxFi = NULL;
  const mxArray *c18_mxInt = NULL;
  int32_T c18_i;
  (void)chartInstance;
  sf_mex_check_fi(c18_parentId, c18_b_u, false, 0U, NULL, c18_eml_mx,
                  c18_b_eml_mx);
  sf_mex_assign(&c18_mxFi, sf_mex_dup(c18_b_u), false);
  sf_mex_assign(&c18_mxInt, sf_mex_call(c18_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c18_mxFi)), false);
  sf_mex_import(c18_parentId, sf_mex_dup(c18_mxInt), &c18_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c18_mxFi);
  sf_mex_destroy(&c18_mxInt);
  c18_b_y = c18_i;
  sf_mex_destroy(&c18_mxFi);
  sf_mex_destroy(&c18_b_u);
  return c18_b_y;
}

static void c18_c_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_d, const char_T *c18_identifier,
   boolean_T *c18_svPtr, int32_T c18_b_y[5])
{
  emlrtMsgIdentifier c18_thisId;
  c18_thisId.fIdentifier = (const char *)c18_identifier;
  c18_thisId.fParent = NULL;
  c18_thisId.bParentIsCell = false;
  c18_d_emlrt_marshallIn(chartInstance, c18_sp, sf_mex_dup(c18_b_d), &c18_thisId,
    c18_svPtr, c18_b_y);
  sf_mex_destroy(&c18_b_d);
}

static void c18_d_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c18_sp, const mxArray *c18_b_u, const emlrtMsgIdentifier
   *c18_parentId, boolean_T *c18_svPtr, int32_T c18_b_y[5])
{
  int32_T c18_i;
  uint32_T c18_uv[2];
  const mxArray *c18_mxFi = NULL;
  const mxArray *c18_mxInt = NULL;
  int32_T c18_iv[5];
  int32_T c18_i1;
  (void)chartInstance;
  for (c18_i = 0; c18_i < 2; c18_i++) {
    c18_uv[c18_i] = 1U + ((uint32_T)c18_i << 2);
  }

  if (mxIsEmpty(c18_b_u)) {
    *c18_svPtr = false;
  } else {
    *c18_svPtr = true;
    sf_mex_check_fi(c18_parentId, c18_b_u, false, 2U, c18_uv, c18_eml_mx,
                    c18_b_eml_mx);
    sf_mex_assign(&c18_mxFi, sf_mex_dup(c18_b_u), false);
    sf_mex_assign(&c18_mxInt, sf_mex_call(c18_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c18_mxFi)), false);
    sf_mex_import(c18_parentId, sf_mex_dup(c18_mxInt), c18_iv, 1, 6, 0U, 1, 0U,
                  2, 1, 5);
    sf_mex_destroy(&c18_mxFi);
    sf_mex_destroy(&c18_mxInt);
    for (c18_i1 = 0; c18_i1 < 5; c18_i1++) {
      c18_b_y[c18_i1] = c18_iv[c18_i1];
    }
  }

  sf_mex_destroy(&c18_mxFi);
  sf_mex_destroy(&c18_b_u);
}

static uint8_T c18_e_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c18_b_is_active_c18_zeabus_hydrophone_concrete, const char_T *c18_identifier)
{
  uint8_T c18_b_y;
  emlrtMsgIdentifier c18_thisId;
  c18_thisId.fIdentifier = (const char *)c18_identifier;
  c18_thisId.fParent = NULL;
  c18_thisId.bParentIsCell = false;
  c18_b_y = c18_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c18_b_is_active_c18_zeabus_hydrophone_concrete), &c18_thisId);
  sf_mex_destroy(&c18_b_is_active_c18_zeabus_hydrophone_concrete);
  return c18_b_y;
}

static uint8_T c18_f_emlrt_marshallIn
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c18_b_u, const emlrtMsgIdentifier *c18_parentId)
{
  uint8_T c18_b_y;
  uint8_T c18_c_u;
  (void)chartInstance;
  sf_mex_import(c18_parentId, sf_mex_dup(c18_b_u), &c18_c_u, 1, 3, 0U, 0, 0U, 0);
  c18_b_y = c18_c_u;
  sf_mex_destroy(&c18_b_u);
  return c18_b_y;
}

static const mxArray *c18_chart_data_browse_helper
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_ssIdNumber)
{
  const mxArray *c18_mxData = NULL;
  int32_T c18_i;
  int32_T c18_i1;
  real_T c18_b_d;
  real_T c18_d1;
  c18_mxData = NULL;
  switch (c18_ssIdNumber) {
   case 4U:
    c18_i = *chartInstance->c18_u;
    c18_b_d = (real_T)c18_i * 7.62939453125E-6;
    sf_mex_assign(&c18_mxData, sf_mex_create("mxData", &c18_b_d, 0, 0U, 0U, 0U,
      0), false);
    break;

   case 5U:
    c18_i1 = *chartInstance->c18_y;
    c18_d1 = (real_T)c18_i1 * 7.62939453125E-6;
    sf_mex_assign(&c18_mxData, sf_mex_create("mxData", &c18_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c18_mxData;
}

static void c18_b_emlrt_update_log_2
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[5], emlrtLocationLoggingDataType c18_table[], int32_T c18_index)
{
  boolean_T c18_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c18_b_table;
  real_T c18_b_d;
  int32_T c18_i;
  int32_T c18_localMin;
  real_T c18_d1;
  int32_T c18_i1;
  int32_T c18_localMax;
  emlrtLocationLoggingHistogramType *c18_histTable;
  int32_T c18_b_i;
  int32_T c18_c_i;
  real_T c18_inDouble;
  real_T c18_significand;
  int32_T c18_exponent;
  (void)chartInstance;
  c18_isLoggingEnabledHere = (c18_index >= 0);
  if (c18_isLoggingEnabledHere) {
    c18_b_table = (emlrtLocationLoggingDataType *)&c18_table[c18_index];
    c18_b_d = muDoubleScalarFloor(c18_b_table[0U].SimMin * 131072.0);
    if (c18_b_d < 131072.0) {
      if (c18_b_d >= -131072.0) {
        c18_i = (int32_T)c18_b_d;
      } else {
        c18_i = -131072;
      }
    } else if (c18_b_d >= 131072.0) {
      c18_i = 131071;
    } else {
      c18_i = 0;
    }

    c18_localMin = c18_i;
    c18_d1 = muDoubleScalarFloor(c18_b_table[0U].SimMax * 131072.0);
    if (c18_d1 < 131072.0) {
      if (c18_d1 >= -131072.0) {
        c18_i1 = (int32_T)c18_d1;
      } else {
        c18_i1 = -131072;
      }
    } else if (c18_d1 >= 131072.0) {
      c18_i1 = 131071;
    } else {
      c18_i1 = 0;
    }

    c18_localMax = c18_i1;
    c18_histTable = c18_b_table[0U].HistogramTable;
    for (c18_b_i = 0; c18_b_i < 5; c18_b_i++) {
      /* Simulation Min-Max logging. */
      if (c18_in[c18_b_i] < c18_localMin) {
        c18_localMin = c18_in[c18_b_i];
      }

      if (c18_in[c18_b_i] > c18_localMax) {
        c18_localMax = c18_in[c18_b_i];
      }

      /* Histogram logging. */
      c18_inDouble = (real_T)c18_in[c18_b_i] * 7.62939453125E-6;
      c18_histTable->TotalNumberOfValues++;
      if (c18_inDouble == 0.0) {
        c18_histTable->NumberOfZeros++;
      } else {
        c18_histTable->SimSum += c18_inDouble;
        if ((!muDoubleScalarIsInf(c18_inDouble)) && (!muDoubleScalarIsNaN
             (c18_inDouble))) {
          c18_significand = frexp(c18_inDouble, &c18_exponent);
          if (c18_exponent > 128) {
            c18_exponent = 128;
          }

          if (c18_exponent < -127) {
            c18_exponent = -127;
          }

          if (c18_significand < 0.0) {
            c18_histTable->NumberOfNegativeValues++;
            c18_histTable->HistogramOfNegativeValues[127 + c18_exponent]++;
          } else {
            c18_histTable->NumberOfPositiveValues++;
            c18_histTable->HistogramOfPositiveValues[127 + c18_exponent]++;
          }
        }
      }
    }

    c18_b_table[0U].SimMin = (real_T)c18_localMin * 7.62939453125E-6;
    c18_b_table[0U].SimMax = (real_T)c18_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c18_c_i = 0;
    while (c18_b_table[0U].IsAlwaysInteger && (c18_c_i < 5)) {
      if (((uint32_T)c18_in[c18_c_i] & 131071U) != 0U) {
        c18_b_table[0U].IsAlwaysInteger = false;
      }

      c18_c_i++;
    }
  }
}

static void c18_b_emlrt_update_log_3
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c18_in[4], emlrtLocationLoggingDataType c18_table[], int32_T c18_index)
{
  boolean_T c18_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c18_b_table;
  real_T c18_b_d;
  int32_T c18_i;
  int32_T c18_localMin;
  real_T c18_d1;
  int32_T c18_i1;
  int32_T c18_localMax;
  emlrtLocationLoggingHistogramType *c18_histTable;
  int32_T c18_b_i;
  int32_T c18_c_i;
  real_T c18_inDouble;
  real_T c18_significand;
  int32_T c18_exponent;
  (void)chartInstance;
  c18_isLoggingEnabledHere = (c18_index >= 0);
  if (c18_isLoggingEnabledHere) {
    c18_b_table = (emlrtLocationLoggingDataType *)&c18_table[c18_index];
    c18_b_d = muDoubleScalarFloor(c18_b_table[0U].SimMin * 131072.0);
    if (c18_b_d < 131072.0) {
      if (c18_b_d >= -131072.0) {
        c18_i = (int32_T)c18_b_d;
      } else {
        c18_i = -131072;
      }
    } else if (c18_b_d >= 131072.0) {
      c18_i = 131071;
    } else {
      c18_i = 0;
    }

    c18_localMin = c18_i;
    c18_d1 = muDoubleScalarFloor(c18_b_table[0U].SimMax * 131072.0);
    if (c18_d1 < 131072.0) {
      if (c18_d1 >= -131072.0) {
        c18_i1 = (int32_T)c18_d1;
      } else {
        c18_i1 = -131072;
      }
    } else if (c18_d1 >= 131072.0) {
      c18_i1 = 131071;
    } else {
      c18_i1 = 0;
    }

    c18_localMax = c18_i1;
    c18_histTable = c18_b_table[0U].HistogramTable;
    for (c18_b_i = 0; c18_b_i < 4; c18_b_i++) {
      /* Simulation Min-Max logging. */
      if (c18_in[c18_b_i] < c18_localMin) {
        c18_localMin = c18_in[c18_b_i];
      }

      if (c18_in[c18_b_i] > c18_localMax) {
        c18_localMax = c18_in[c18_b_i];
      }

      /* Histogram logging. */
      c18_inDouble = (real_T)c18_in[c18_b_i] * 7.62939453125E-6;
      c18_histTable->TotalNumberOfValues++;
      if (c18_inDouble == 0.0) {
        c18_histTable->NumberOfZeros++;
      } else {
        c18_histTable->SimSum += c18_inDouble;
        if ((!muDoubleScalarIsInf(c18_inDouble)) && (!muDoubleScalarIsNaN
             (c18_inDouble))) {
          c18_significand = frexp(c18_inDouble, &c18_exponent);
          if (c18_exponent > 128) {
            c18_exponent = 128;
          }

          if (c18_exponent < -127) {
            c18_exponent = -127;
          }

          if (c18_significand < 0.0) {
            c18_histTable->NumberOfNegativeValues++;
            c18_histTable->HistogramOfNegativeValues[127 + c18_exponent]++;
          } else {
            c18_histTable->NumberOfPositiveValues++;
            c18_histTable->HistogramOfPositiveValues[127 + c18_exponent]++;
          }
        }
      }
    }

    c18_b_table[0U].SimMin = (real_T)c18_localMin * 7.62939453125E-6;
    c18_b_table[0U].SimMax = (real_T)c18_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c18_c_i = 0;
    while (c18_b_table[0U].IsAlwaysInteger && (c18_c_i < 4)) {
      if (((uint32_T)c18_in[c18_c_i] & 131071U) != 0U) {
        c18_b_table[0U].IsAlwaysInteger = false;
      }

      c18_c_i++;
    }
  }
}

static void init_dsm_address_info(SFc18_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c18_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c18_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c18_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c18_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c18_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2929868855U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(436972284U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(707407755U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(719007121U);
}

mxArray *sf_c18_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c18_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c18_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c18_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiCewMzAwAakOYCYiQECWKF8RiBmhtIQcRa4uAIQl1QWpILEi4uSPVOAdF5iLpi"
    "fWFrhmZeWDzbfggFhPhsW8xmRzOeEikPAB3vK9Is4gPQbIOlnIaBfAMiqhIYLLHzIt1/AgTL9EP"
    "tJdX8KVN8FBvzxyogWr0xQPkhPDkMmQwHUHAcC7mdCc78AzPEOMQ5guiGGKuFAeXwoUMUdEQTiQ"
    "wMlPiD8zOL4xOSSzLLU+GRDi/iq1MSk0uL4jMqUovyCjPw8oGh+XnJRakkqzJ8ALEEnFA=="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c18_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "s2lfbEDUyQjWCMMTPbwPIdD";
}

static void sf_opaque_initialize_c18_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c18_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c18_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c18_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c18_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c18_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c18_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc18_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c18_zeabus_hydrophone_concrete
      ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc18_zeabus_hydrophone_concrete
    ((SFc18_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c18_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c18_zeabus_hydrophone_concrete
      ((SFc18_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc18_zeabus_hydrophone_concrete
      ((SFc18_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c18_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [17] = {
    "eNrtVstu00AUddKAWlGqIIFAgkV3dMECWHVHaB4iUkID6YNFpWhi38RDxjNmHknDih0bFnwAO36",
    "IH2DHB/AJXDtOGzm205BSIYElZzzOuWfOfcz1WLl608JrC+97tyzrOo7reOetyXUtmudm7sn7gv",
    "Uwmn9FEDdei0jiKSvz4sSD16AEM5oKXuc9kQijvAcSuI1YX0idxqaoZxjlg5rhdsCnjl1qu21XG",
    "ObsoS1x9jkbI5tvdAt5KlSCrWsAjnalMH23xkj/TLHUo7IL9kAZL8sFBbpt/ECWahqmqc+gegp2",
    "nStNULE619bWRENZn6a6GXiq2lOg8HxGCU/01iWqDT4GWMOh7+DvvtHoVBxmu0TqPXDJEFSDDkJ",
    "OwSHOSRX+0aWcaCEpYVWPlQPDeW0thnqawgGWERDUtieBDHxBuU7Pf7uGnlY56TKoQNf009na8M",
    "4EyT+iMAKZGrdeWQxBkj7s89RFw4BUT8NsnVXJPExTD46IfG5j/hQ4qdWLlaPaBPMEB2iRBoPQy",
    "bo6kHSI4U1lM149qMxFW8Z4k2SrRbCQrTqErCycsdVsXiaMqVTYgfAbMAQWslaIJtmwCWsyzpfC",
    "J32sWgeDHJR4WXCHzuXCNkoLr4zlVmk0XmKnSBZ3DqtzDbJHbEjat8p2wTEM0FHsTDpcLoHUoSr",
    "I1gJUlNNFKEv1DK+MhBygoxnb/tyFIAepQE/1MfpYu4cKyzwLFkR/IW7a5x9b531+8wJ9fmoXH3",
    "dmeHIJPNbMGF93I5+9bh6fcpFdacbuZmydQswuwBXx/lL99F3cX/94dGfzmP94dGOl9QvLfRe3o",
    "vmDaQM6K8/hXFUE2BczugoJ/Hdn+IvRXD1lvW61cjh+9fa43GwetLqjVt2phHyf17L1rsX0Tt9v",
    "B51w7Id9TUm77kQf7GBOzOQzFvDvzui9viAeG9H7yfXz2Wr2t0vxPBYW2BfxaRyr299fv1hazX5",
    "+H1xEvxPZfbOWq8N8NA9smEUtP2E/JenPx/QXp+JLJ6Vw/HByKXFYPR/bl6LjzYJ87MT23054/u",
    "gQPE0MoWM/2e28B9I1quOOHfzSuXji6tiC2xI0bF1C/1vWzvpv91fY5f5B/y5ynrhqO+uK7Vb1b",
    "9lz1SrnsHi/s2L44grr/Gn8qufRZfC/ADFtaQk=",
    ""
  };

  static char newstr [1165] = "";
  newstr[0] = '\0';
  for (i = 0; i < 17; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c18_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c18_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(3716957596U));
  ssSetChecksum1(S,(2265455471U));
  ssSetChecksum2(S,(1460409686U));
  ssSetChecksum3(S,(187491438U));
}

static void mdlRTW_c18_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c18_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc18_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc18_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc18_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc18_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c18_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c18_zeabus_hydrophone_concrete;
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
    chartInstance->c18_JITStateAnimation,
    chartInstance->c18_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c18_zeabus_hydrophone_concrete(chartInstance);
}

void c18_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c18_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c18_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c18_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c18_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
