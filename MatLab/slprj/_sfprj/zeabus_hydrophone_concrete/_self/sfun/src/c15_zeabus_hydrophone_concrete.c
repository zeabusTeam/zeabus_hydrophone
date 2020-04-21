/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c15_zeabus_hydrophone_concrete.h"
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
static const mxArray *c15_eml_mx;
static const mxArray *c15_b_eml_mx;
static emlrtRSInfo c15_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC1 Interface/Median Filter/Median Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:599"    /* pathName */
};

/* Function Declarations */
static void initialize_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c15_update_jit_animation_state_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c15_do_animation_call_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c15_st);
static void finalize_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c15_emlrt_update_log_1
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c15_in,
   emlrtLocationLoggingDataType c15_table[], int32_T c15_index);
static void c15_emlrt_update_log_2
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[5], emlrtLocationLoggingDataType c15_table[], int32_T c15_index,
   int32_T c15_out[5]);
static void c15_emlrt_update_log_3
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[4], emlrtLocationLoggingDataType c15_table[], int32_T c15_index,
   int32_T c15_out[4]);
static boolean_T c15_emlrt_update_log_4
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c15_in, emlrtLocationLoggingDataType c15_table[], int32_T c15_index);
static void c15_emlrtInitVarDataTables
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c15_dataTables[52],
   emlrtLocationLoggingHistogramType c15_histTables[52]);
static int32_T c15_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_y, const char_T *c15_identifier);
static int32_T c15_b_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_u, const emlrtMsgIdentifier
   *c15_parentId);
static void c15_c_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_d, const char_T *c15_identifier,
   boolean_T *c15_svPtr, int32_T c15_b_y[5]);
static void c15_d_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_u, const emlrtMsgIdentifier
   *c15_parentId, boolean_T *c15_svPtr, int32_T c15_b_y[5]);
static uint8_T c15_e_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c15_b_is_active_c15_zeabus_hydrophone_concrete, const char_T *c15_identifier);
static uint8_T c15_f_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c15_b_u, const emlrtMsgIdentifier *c15_parentId);
static const mxArray *c15_chart_data_browse_helper
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_ssIdNumber);
static void c15_b_emlrt_update_log_2
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[5], emlrtLocationLoggingDataType c15_table[], int32_T c15_index);
static void c15_b_emlrt_update_log_3
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[4], emlrtLocationLoggingDataType c15_table[], int32_T c15_index);
static void init_dsm_address_info(SFc15_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c15_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c15_st.tls = chartInstance->c15_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c15_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c15_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c15_d_not_empty = false;
  chartInstance->c15_is_active_c15_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c15_b_eml_mx, sf_mex_call(&c15_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c15_eml_mx, sf_mex_call(&c15_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c15_emlrtLocLogSimulated = false;
  c15_emlrtInitVarDataTables(chartInstance,
    chartInstance->c15_emlrtLocationLoggingDataTables,
    chartInstance->c15_emlrtLocLogHistTables);
}

static void initialize_params_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c15_update_jit_animation_state_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c15_do_animation_call_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c15_st;
  const mxArray *c15_b_y = NULL;
  const mxArray *c15_c_y = NULL;
  int32_T c15_b_u;
  const mxArray *c15_d_y = NULL;
  const mxArray *c15_e_y = NULL;
  int32_T c15_i;
  const mxArray *c15_f_y = NULL;
  int32_T c15_c_u[5];
  const mxArray *c15_g_y = NULL;
  c15_st = NULL;
  c15_st = NULL;
  c15_b_y = NULL;
  sf_mex_assign(&c15_b_y, sf_mex_createcellmatrix(3, 1), false);
  c15_c_y = NULL;
  c15_b_u = *chartInstance->c15_y;
  c15_d_y = NULL;
  sf_mex_assign(&c15_d_y, sf_mex_create("y", &c15_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c15_c_y, sf_mex_create_fi(sf_mex_dup(c15_eml_mx), sf_mex_dup
    (c15_b_eml_mx), "simulinkarray", c15_d_y, false, false), false);
  sf_mex_setcell(c15_b_y, 0, c15_c_y);
  c15_e_y = NULL;
  if (!chartInstance->c15_d_not_empty) {
    sf_mex_assign(&c15_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    for (c15_i = 0; c15_i < 5; c15_i++) {
      c15_c_u[c15_i] = chartInstance->c15_d[c15_i];
    }

    c15_f_y = NULL;
    sf_mex_assign(&c15_f_y, sf_mex_create("y", c15_c_u, 6, 0U, 1U, 0U, 2, 1, 5),
                  false);
    sf_mex_assign(&c15_e_y, sf_mex_create_fi(sf_mex_dup(c15_eml_mx), sf_mex_dup
      (c15_b_eml_mx), "simulinkarray", c15_f_y, true, false), false);
  }

  sf_mex_setcell(c15_b_y, 1, c15_e_y);
  c15_g_y = NULL;
  sf_mex_assign(&c15_g_y, sf_mex_create("y",
    &chartInstance->c15_is_active_c15_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c15_b_y, 2, c15_g_y);
  sf_mex_assign(&c15_st, c15_b_y, false);
  return c15_st;
}

static void set_sim_state_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c15_st)
{
  emlrtStack c15_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c15_b_u;
  int32_T c15_iv[5];
  int32_T c15_i;
  c15_b_st.tls = chartInstance->c15_fEmlrtCtx;
  chartInstance->c15_doneDoubleBufferReInit = true;
  c15_b_u = sf_mex_dup(c15_st);
  *chartInstance->c15_y = c15_emlrt_marshallIn(chartInstance, &c15_b_st,
    sf_mex_dup(sf_mex_getcell(c15_b_u, 0)), "y");
  c15_c_emlrt_marshallIn(chartInstance, &c15_b_st, sf_mex_dup(sf_mex_getcell
    (c15_b_u, 1)), "d", &chartInstance->c15_d_not_empty, c15_iv);
  for (c15_i = 0; c15_i < 5; c15_i++) {
    chartInstance->c15_d[c15_i] = c15_iv[c15_i];
  }

  chartInstance->c15_is_active_c15_zeabus_hydrophone_concrete =
    c15_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c15_b_u, 2)),
    "is_active_c15_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c15_b_u);
  sf_mex_destroy(&c15_st);
}

static void finalize_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c15_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:599", /* mexFileName */
    "Thu Apr 16 10:58:12 2020",        /* timestamp */
    "",                                /* buildDir */
    1,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c15_emlrtLocationLoggingFunctionInfoTable[1] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      52                               /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c15_emlrtLocationInfo[73] = { { 1,/* MxInfoID */
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

  const int32_T c15_emlrtLocationLoggingFieldCounts[52] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c15_RuntimeVar);
  if (chartInstance->c15_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:599");
    emlrtLocationLoggingPushLog(&c15_emlrtLocationLoggingFileInfo,
      c15_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c15_emlrtLocationLoggingDataTables, c15_emlrtLocationInfo,
      NULL, 0U, c15_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:599");
  }

  sf_mex_destroy(&c15_eml_mx);
  sf_mex_destroy(&c15_b_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c15_covrtInstance);
}

static void sf_gateway_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c15_b_u;
  int32_T c15_varargin_1;
  int32_T c15_b_varargin_1;
  int32_T c15_var1;
  int32_T c15_hfi;
  int32_T c15_c_u;
  int32_T c15_i;
  int32_T c15_i1;
  int32_T c15_i2;
  int32_T c15_iv[4];
  int32_T c15_i3;
  int32_T c15_t[5];
  int32_T c15_a0;
  int32_T c15_b0;
  int32_T c15_a;
  int32_T c15_b;
  int32_T c15_b_a0;
  int32_T c15_b_b0;
  int32_T c15_a1;
  int32_T c15_b1;
  int32_T c15_b_a1;
  int32_T c15_b_b1;
  boolean_T c15_c;
  int32_T c15_i4;
  int32_T c15_i5;
  real_T c15_b_t;
  int32_T c15_c_varargin_1;
  int32_T c15_c_a0;
  int32_T c15_varargin_2;
  int32_T c15_c_b0;
  int32_T c15_fmo_1;
  int32_T c15_b_a;
  int32_T c15_fmo_2;
  int32_T c15_b_b;
  int32_T c15_b_fmo_1;
  int32_T c15_d_a0;
  int32_T c15_b_fmo_2;
  int32_T c15_d_b0;
  int32_T c15_d_varargin_1;
  int32_T c15_c_a1;
  int32_T c15_e_varargin_1;
  int32_T c15_c_b1;
  int32_T c15_b_var1;
  int32_T c15_d_a1;
  int32_T c15_b_hfi;
  int32_T c15_d_b1;
  boolean_T c15_b_c;
  int32_T c15_f_varargin_1;
  int32_T c15_i6;
  int32_T c15_g_varargin_1;
  int32_T c15_c_var1;
  int32_T c15_c_hfi;
  int32_T c15_i7;
  real_T c15_c_t;
  int32_T c15_h_varargin_1;
  int32_T c15_e_a0;
  int32_T c15_b_varargin_2;
  int32_T c15_e_b0;
  int32_T c15_fmo_3;
  int32_T c15_c_a;
  int32_T c15_fmo_4;
  int32_T c15_c_b;
  int32_T c15_b_fmo_3;
  int32_T c15_f_a0;
  int32_T c15_b_fmo_4;
  int32_T c15_f_b0;
  int32_T c15_i_varargin_1;
  int32_T c15_e_a1;
  int32_T c15_j_varargin_1;
  int32_T c15_e_b1;
  int32_T c15_d_var1;
  int32_T c15_f_a1;
  int32_T c15_d_hfi;
  int32_T c15_f_b1;
  boolean_T c15_c_c;
  int32_T c15_k_varargin_1;
  int32_T c15_i8;
  int32_T c15_l_varargin_1;
  int32_T c15_e_var1;
  int32_T c15_e_hfi;
  int32_T c15_i9;
  real_T c15_d_t;
  int32_T c15_m_varargin_1;
  int32_T c15_g_a0;
  int32_T c15_c_varargin_2;
  int32_T c15_g_b0;
  int32_T c15_fmo_5;
  int32_T c15_d_a;
  int32_T c15_fmo_6;
  int32_T c15_d_b;
  int32_T c15_b_fmo_5;
  int32_T c15_h_a0;
  int32_T c15_b_fmo_6;
  int32_T c15_h_b0;
  int32_T c15_n_varargin_1;
  int32_T c15_g_a1;
  int32_T c15_o_varargin_1;
  int32_T c15_g_b1;
  int32_T c15_f_var1;
  int32_T c15_h_a1;
  int32_T c15_f_hfi;
  int32_T c15_h_b1;
  boolean_T c15_d_c;
  int32_T c15_p_varargin_1;
  int32_T c15_i10;
  int32_T c15_q_varargin_1;
  int32_T c15_g_var1;
  int32_T c15_g_hfi;
  int32_T c15_i11;
  real_T c15_e_t;
  int32_T c15_r_varargin_1;
  int32_T c15_i_a0;
  int32_T c15_d_varargin_2;
  int32_T c15_i_b0;
  int32_T c15_fmo_7;
  int32_T c15_e_a;
  int32_T c15_fmo_8;
  int32_T c15_e_b;
  int32_T c15_b_fmo_7;
  int32_T c15_j_a0;
  int32_T c15_b_fmo_8;
  int32_T c15_j_b0;
  int32_T c15_s_varargin_1;
  int32_T c15_i_a1;
  int32_T c15_t_varargin_1;
  int32_T c15_i_b1;
  int32_T c15_h_var1;
  int32_T c15_j_a1;
  int32_T c15_h_hfi;
  int32_T c15_j_b1;
  boolean_T c15_e_c;
  int32_T c15_u_varargin_1;
  int32_T c15_i12;
  int32_T c15_v_varargin_1;
  int32_T c15_i_var1;
  int32_T c15_i_hfi;
  int32_T c15_i13;
  real_T c15_f_t;
  int32_T c15_w_varargin_1;
  int32_T c15_k_a0;
  int32_T c15_e_varargin_2;
  int32_T c15_k_b0;
  int32_T c15_fmo_9;
  int32_T c15_f_a;
  int32_T c15_fmo_10;
  int32_T c15_f_b;
  int32_T c15_b_fmo_9;
  int32_T c15_l_a0;
  int32_T c15_b_fmo_10;
  int32_T c15_l_b0;
  int32_T c15_x_varargin_1;
  int32_T c15_k_a1;
  int32_T c15_y_varargin_1;
  int32_T c15_k_b1;
  int32_T c15_j_var1;
  int32_T c15_l_a1;
  int32_T c15_j_hfi;
  int32_T c15_l_b1;
  boolean_T c15_f_c;
  int32_T c15_ab_varargin_1;
  int32_T c15_i14;
  int32_T c15_bb_varargin_1;
  int32_T c15_k_var1;
  int32_T c15_k_hfi;
  int32_T c15_i15;
  real_T c15_g_t;
  int32_T c15_cb_varargin_1;
  int32_T c15_m_a0;
  int32_T c15_f_varargin_2;
  int32_T c15_m_b0;
  int32_T c15_fmo_11;
  int32_T c15_g_a;
  int32_T c15_fmo_12;
  int32_T c15_g_b;
  int32_T c15_b_fmo_11;
  int32_T c15_n_a0;
  int32_T c15_b_fmo_12;
  int32_T c15_n_b0;
  int32_T c15_db_varargin_1;
  int32_T c15_m_a1;
  int32_T c15_eb_varargin_1;
  int32_T c15_m_b1;
  int32_T c15_l_var1;
  int32_T c15_n_a1;
  int32_T c15_l_hfi;
  int32_T c15_n_b1;
  boolean_T c15_g_c;
  int32_T c15_fb_varargin_1;
  int32_T c15_i16;
  int32_T c15_gb_varargin_1;
  int32_T c15_m_var1;
  int32_T c15_m_hfi;
  int32_T c15_i17;
  real_T c15_h_t;
  int32_T c15_hb_varargin_1;
  int32_T c15_o_a0;
  int32_T c15_g_varargin_2;
  int32_T c15_o_b0;
  int32_T c15_fmo_13;
  int32_T c15_h_a;
  int32_T c15_fmo_14;
  int32_T c15_h_b;
  int32_T c15_b_fmo_13;
  int32_T c15_p_a0;
  int32_T c15_b_fmo_14;
  int32_T c15_p_b0;
  int32_T c15_ib_varargin_1;
  int32_T c15_o_a1;
  int32_T c15_jb_varargin_1;
  int32_T c15_o_b1;
  int32_T c15_n_var1;
  int32_T c15_p_a1;
  int32_T c15_n_hfi;
  int32_T c15_p_b1;
  boolean_T c15_h_c;
  int32_T c15_kb_varargin_1;
  int32_T c15_i18;
  int32_T c15_lb_varargin_1;
  int32_T c15_o_var1;
  int32_T c15_o_hfi;
  int32_T c15_i19;
  real_T c15_i_t;
  int32_T c15_mb_varargin_1;
  int32_T c15_q_a0;
  int32_T c15_h_varargin_2;
  int32_T c15_q_b0;
  int32_T c15_fmo_15;
  int32_T c15_i_a;
  int32_T c15_fmo_16;
  int32_T c15_i_b;
  int32_T c15_b_fmo_15;
  int32_T c15_r_a0;
  int32_T c15_b_fmo_16;
  int32_T c15_r_b0;
  int32_T c15_nb_varargin_1;
  int32_T c15_q_a1;
  int32_T c15_ob_varargin_1;
  int32_T c15_q_b1;
  int32_T c15_p_var1;
  int32_T c15_r_a1;
  int32_T c15_p_hfi;
  int32_T c15_r_b1;
  boolean_T c15_i_c;
  int32_T c15_pb_varargin_1;
  int32_T c15_i20;
  int32_T c15_qb_varargin_1;
  int32_T c15_q_var1;
  int32_T c15_q_hfi;
  int32_T c15_i21;
  real_T c15_j_t;
  int32_T c15_rb_varargin_1;
  int32_T c15_sb_varargin_1;
  int32_T c15_i_varargin_2;
  int32_T c15_tb_varargin_1;
  int32_T c15_fmo_17;
  int32_T c15_r_var1;
  int32_T c15_fmo_18;
  int32_T c15_r_hfi;
  int32_T c15_b_fmo_17;
  int32_T c15_b_y;
  int32_T c15_b_fmo_18;
  int32_T c15_ub_varargin_1;
  int32_T c15_vb_varargin_1;
  int32_T c15_s_var1;
  int32_T c15_s_hfi;
  int32_T c15_wb_varargin_1;
  int32_T c15_xb_varargin_1;
  int32_T c15_t_var1;
  int32_T c15_t_hfi;
  chartInstance->c15_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c15_covrtInstance, 0U, (real_T)
                    *chartInstance->c15_u);
  chartInstance->c15_sfEvent = CALL_EVENT;
  c15_b_u = *chartInstance->c15_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c15_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c15_emlrt_update_log_1(chartInstance, c15_b_u,
    chartInstance->c15_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c15_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c15_covrtInstance, 4U, 0, 1);
  c15_varargin_1 = c15_b_u;
  c15_b_varargin_1 = c15_varargin_1;
  c15_var1 = c15_b_varargin_1;
  c15_hfi = c15_var1;
  c15_c_u = c15_emlrt_update_log_1(chartInstance, c15_hfi,
    chartInstance->c15_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 0,
                     !chartInstance->c15_d_not_empty)) {
    for (c15_i = 0; c15_i < 5; c15_i++) {
      chartInstance->c15_d[c15_i] = 0;
    }

    c15_b_emlrt_update_log_2(chartInstance, chartInstance->c15_d,
      chartInstance->c15_emlrtLocationLoggingDataTables, 2);
    chartInstance->c15_d_not_empty = true;
  }

  for (c15_i1 = 0; c15_i1 < 4; c15_i1++) {
    c15_iv[c15_i1] = chartInstance->c15_d[c15_i1 + 1];
  }

  for (c15_i2 = 0; c15_i2 < 4; c15_i2++) {
    chartInstance->c15_d[c15_i2] = c15_iv[c15_i2];
  }

  c15_b_emlrt_update_log_3(chartInstance, *(int32_T (*)[4])&chartInstance->
    c15_d[0], chartInstance->c15_emlrtLocationLoggingDataTables, 3);
  chartInstance->c15_d[4] = c15_emlrt_update_log_1(chartInstance, c15_c_u,
    chartInstance->c15_emlrtLocationLoggingDataTables, 4);
  for (c15_i3 = 0; c15_i3 < 5; c15_i3++) {
    c15_t[c15_i3] = chartInstance->c15_d[c15_i3];
  }

  c15_b_emlrt_update_log_2(chartInstance, c15_t,
    chartInstance->c15_emlrtLocationLoggingDataTables, 5);
  c15_a0 = c15_t[0];
  c15_b0 = c15_t[1];
  c15_a = c15_a0;
  c15_b = c15_b0;
  c15_b_a0 = c15_a;
  c15_b_b0 = c15_b;
  c15_a1 = c15_b_a0;
  c15_b1 = c15_b_b0;
  c15_b_a1 = c15_a1;
  c15_b_b1 = c15_b1;
  c15_c = (c15_b_a1 > c15_b_b1);
  c15_i4 = c15_t[1] - c15_t[0];
  if (c15_i4 > 131071) {
    c15_i4 = 131071;
  } else {
    if (c15_i4 < -131072) {
      c15_i4 = -131072;
    }
  }

  c15_i5 = c15_t[0] - c15_t[1];
  if (c15_i5 > 131071) {
    c15_i5 = 131071;
  } else {
    if (c15_i5 < -131072) {
      c15_i5 = -131072;
    }
  }

  if (c15_t[0] < c15_t[1]) {
    c15_b_t = (real_T)(c15_i4 <= 1);
  } else if (c15_t[0] > c15_t[1]) {
    if (c15_i5 <= 1) {
      c15_b_t = 3.0;
    } else {
      c15_b_t = 0.0;
    }
  } else {
    c15_b_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 1,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 0U, c15_b_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_c, chartInstance->c15_emlrtLocationLoggingDataTables,
         6)))) {
    c15_c_varargin_1 = c15_t[0];
    c15_varargin_2 = c15_t[1];
    c15_fmo_1 = c15_c_varargin_1;
    c15_fmo_2 = c15_varargin_2;
    c15_b_fmo_1 = c15_emlrt_update_log_1(chartInstance, c15_fmo_1,
      chartInstance->c15_emlrtLocationLoggingDataTables, 34);
    c15_b_fmo_2 = c15_emlrt_update_log_1(chartInstance, c15_fmo_2,
      chartInstance->c15_emlrtLocationLoggingDataTables, 35);
    c15_d_varargin_1 = c15_b_fmo_1;
    c15_e_varargin_1 = c15_d_varargin_1;
    c15_b_var1 = c15_e_varargin_1;
    c15_b_hfi = c15_b_var1;
    c15_t[1] = c15_emlrt_update_log_1(chartInstance, c15_b_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 7);
    c15_f_varargin_1 = c15_b_fmo_2;
    c15_g_varargin_1 = c15_f_varargin_1;
    c15_c_var1 = c15_g_varargin_1;
    c15_c_hfi = c15_c_var1;
    c15_t[0] = c15_emlrt_update_log_1(chartInstance, c15_c_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 8);
  }

  c15_c_a0 = c15_t[1];
  c15_c_b0 = c15_t[2];
  c15_b_a = c15_c_a0;
  c15_b_b = c15_c_b0;
  c15_d_a0 = c15_b_a;
  c15_d_b0 = c15_b_b;
  c15_c_a1 = c15_d_a0;
  c15_c_b1 = c15_d_b0;
  c15_d_a1 = c15_c_a1;
  c15_d_b1 = c15_c_b1;
  c15_b_c = (c15_d_a1 > c15_d_b1);
  c15_i6 = c15_t[2] - c15_t[1];
  if (c15_i6 > 131071) {
    c15_i6 = 131071;
  } else {
    if (c15_i6 < -131072) {
      c15_i6 = -131072;
    }
  }

  c15_i7 = c15_t[1] - c15_t[2];
  if (c15_i7 > 131071) {
    c15_i7 = 131071;
  } else {
    if (c15_i7 < -131072) {
      c15_i7 = -131072;
    }
  }

  if (c15_t[1] < c15_t[2]) {
    c15_c_t = (real_T)(c15_i6 <= 1);
  } else if (c15_t[1] > c15_t[2]) {
    if (c15_i7 <= 1) {
      c15_c_t = 3.0;
    } else {
      c15_c_t = 0.0;
    }
  } else {
    c15_c_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 2,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 1U, c15_c_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_b_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 9)))) {
    c15_h_varargin_1 = c15_t[1];
    c15_b_varargin_2 = c15_t[2];
    c15_fmo_3 = c15_h_varargin_1;
    c15_fmo_4 = c15_b_varargin_2;
    c15_b_fmo_3 = c15_emlrt_update_log_1(chartInstance, c15_fmo_3,
      chartInstance->c15_emlrtLocationLoggingDataTables, 36);
    c15_b_fmo_4 = c15_emlrt_update_log_1(chartInstance, c15_fmo_4,
      chartInstance->c15_emlrtLocationLoggingDataTables, 37);
    c15_i_varargin_1 = c15_b_fmo_3;
    c15_j_varargin_1 = c15_i_varargin_1;
    c15_d_var1 = c15_j_varargin_1;
    c15_d_hfi = c15_d_var1;
    c15_t[2] = c15_emlrt_update_log_1(chartInstance, c15_d_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 10);
    c15_k_varargin_1 = c15_b_fmo_4;
    c15_l_varargin_1 = c15_k_varargin_1;
    c15_e_var1 = c15_l_varargin_1;
    c15_e_hfi = c15_e_var1;
    c15_t[1] = c15_emlrt_update_log_1(chartInstance, c15_e_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 11);
  }

  c15_e_a0 = c15_t[2];
  c15_e_b0 = c15_t[3];
  c15_c_a = c15_e_a0;
  c15_c_b = c15_e_b0;
  c15_f_a0 = c15_c_a;
  c15_f_b0 = c15_c_b;
  c15_e_a1 = c15_f_a0;
  c15_e_b1 = c15_f_b0;
  c15_f_a1 = c15_e_a1;
  c15_f_b1 = c15_e_b1;
  c15_c_c = (c15_f_a1 > c15_f_b1);
  c15_i8 = c15_t[3] - c15_t[2];
  if (c15_i8 > 131071) {
    c15_i8 = 131071;
  } else {
    if (c15_i8 < -131072) {
      c15_i8 = -131072;
    }
  }

  c15_i9 = c15_t[2] - c15_t[3];
  if (c15_i9 > 131071) {
    c15_i9 = 131071;
  } else {
    if (c15_i9 < -131072) {
      c15_i9 = -131072;
    }
  }

  if (c15_t[2] < c15_t[3]) {
    c15_d_t = (real_T)(c15_i8 <= 1);
  } else if (c15_t[2] > c15_t[3]) {
    if (c15_i9 <= 1) {
      c15_d_t = 3.0;
    } else {
      c15_d_t = 0.0;
    }
  } else {
    c15_d_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 2U, c15_d_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_c_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 12)))) {
    c15_m_varargin_1 = c15_t[2];
    c15_c_varargin_2 = c15_t[3];
    c15_fmo_5 = c15_m_varargin_1;
    c15_fmo_6 = c15_c_varargin_2;
    c15_b_fmo_5 = c15_emlrt_update_log_1(chartInstance, c15_fmo_5,
      chartInstance->c15_emlrtLocationLoggingDataTables, 38);
    c15_b_fmo_6 = c15_emlrt_update_log_1(chartInstance, c15_fmo_6,
      chartInstance->c15_emlrtLocationLoggingDataTables, 39);
    c15_n_varargin_1 = c15_b_fmo_5;
    c15_o_varargin_1 = c15_n_varargin_1;
    c15_f_var1 = c15_o_varargin_1;
    c15_f_hfi = c15_f_var1;
    c15_t[3] = c15_emlrt_update_log_1(chartInstance, c15_f_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 13);
    c15_p_varargin_1 = c15_b_fmo_6;
    c15_q_varargin_1 = c15_p_varargin_1;
    c15_g_var1 = c15_q_varargin_1;
    c15_g_hfi = c15_g_var1;
    c15_t[2] = c15_emlrt_update_log_1(chartInstance, c15_g_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 14);
  }

  c15_g_a0 = c15_t[3];
  c15_g_b0 = c15_t[4];
  c15_d_a = c15_g_a0;
  c15_d_b = c15_g_b0;
  c15_h_a0 = c15_d_a;
  c15_h_b0 = c15_d_b;
  c15_g_a1 = c15_h_a0;
  c15_g_b1 = c15_h_b0;
  c15_h_a1 = c15_g_a1;
  c15_h_b1 = c15_g_b1;
  c15_d_c = (c15_h_a1 > c15_h_b1);
  c15_i10 = c15_t[4] - c15_t[3];
  if (c15_i10 > 131071) {
    c15_i10 = 131071;
  } else {
    if (c15_i10 < -131072) {
      c15_i10 = -131072;
    }
  }

  c15_i11 = c15_t[3] - c15_t[4];
  if (c15_i11 > 131071) {
    c15_i11 = 131071;
  } else {
    if (c15_i11 < -131072) {
      c15_i11 = -131072;
    }
  }

  if (c15_t[3] < c15_t[4]) {
    c15_e_t = (real_T)(c15_i10 <= 1);
  } else if (c15_t[3] > c15_t[4]) {
    if (c15_i11 <= 1) {
      c15_e_t = 3.0;
    } else {
      c15_e_t = 0.0;
    }
  } else {
    c15_e_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 4,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 3U, c15_e_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_d_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 15)))) {
    c15_r_varargin_1 = c15_t[3];
    c15_d_varargin_2 = c15_t[4];
    c15_fmo_7 = c15_r_varargin_1;
    c15_fmo_8 = c15_d_varargin_2;
    c15_b_fmo_7 = c15_emlrt_update_log_1(chartInstance, c15_fmo_7,
      chartInstance->c15_emlrtLocationLoggingDataTables, 40);
    c15_b_fmo_8 = c15_emlrt_update_log_1(chartInstance, c15_fmo_8,
      chartInstance->c15_emlrtLocationLoggingDataTables, 41);
    c15_s_varargin_1 = c15_b_fmo_7;
    c15_t_varargin_1 = c15_s_varargin_1;
    c15_h_var1 = c15_t_varargin_1;
    c15_h_hfi = c15_h_var1;
    c15_emlrt_update_log_1(chartInstance, c15_h_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 16);
    c15_u_varargin_1 = c15_b_fmo_8;
    c15_v_varargin_1 = c15_u_varargin_1;
    c15_i_var1 = c15_v_varargin_1;
    c15_i_hfi = c15_i_var1;
    c15_t[3] = c15_emlrt_update_log_1(chartInstance, c15_i_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 17);
  }

  c15_i_a0 = c15_t[0];
  c15_i_b0 = c15_t[1];
  c15_e_a = c15_i_a0;
  c15_e_b = c15_i_b0;
  c15_j_a0 = c15_e_a;
  c15_j_b0 = c15_e_b;
  c15_i_a1 = c15_j_a0;
  c15_i_b1 = c15_j_b0;
  c15_j_a1 = c15_i_a1;
  c15_j_b1 = c15_i_b1;
  c15_e_c = (c15_j_a1 > c15_j_b1);
  c15_i12 = c15_t[1] - c15_t[0];
  if (c15_i12 > 131071) {
    c15_i12 = 131071;
  } else {
    if (c15_i12 < -131072) {
      c15_i12 = -131072;
    }
  }

  c15_i13 = c15_t[0] - c15_t[1];
  if (c15_i13 > 131071) {
    c15_i13 = 131071;
  } else {
    if (c15_i13 < -131072) {
      c15_i13 = -131072;
    }
  }

  if (c15_t[0] < c15_t[1]) {
    c15_f_t = (real_T)(c15_i12 <= 1);
  } else if (c15_t[0] > c15_t[1]) {
    if (c15_i13 <= 1) {
      c15_f_t = 3.0;
    } else {
      c15_f_t = 0.0;
    }
  } else {
    c15_f_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 5,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 4U, c15_f_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_e_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 18)))) {
    c15_w_varargin_1 = c15_t[0];
    c15_e_varargin_2 = c15_t[1];
    c15_fmo_9 = c15_w_varargin_1;
    c15_fmo_10 = c15_e_varargin_2;
    c15_b_fmo_9 = c15_emlrt_update_log_1(chartInstance, c15_fmo_9,
      chartInstance->c15_emlrtLocationLoggingDataTables, 42);
    c15_b_fmo_10 = c15_emlrt_update_log_1(chartInstance, c15_fmo_10,
      chartInstance->c15_emlrtLocationLoggingDataTables, 43);
    c15_x_varargin_1 = c15_b_fmo_9;
    c15_y_varargin_1 = c15_x_varargin_1;
    c15_j_var1 = c15_y_varargin_1;
    c15_j_hfi = c15_j_var1;
    c15_t[1] = c15_emlrt_update_log_1(chartInstance, c15_j_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 19);
    c15_ab_varargin_1 = c15_b_fmo_10;
    c15_bb_varargin_1 = c15_ab_varargin_1;
    c15_k_var1 = c15_bb_varargin_1;
    c15_k_hfi = c15_k_var1;
    c15_t[0] = c15_emlrt_update_log_1(chartInstance, c15_k_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 20);
  }

  c15_k_a0 = c15_t[1];
  c15_k_b0 = c15_t[2];
  c15_f_a = c15_k_a0;
  c15_f_b = c15_k_b0;
  c15_l_a0 = c15_f_a;
  c15_l_b0 = c15_f_b;
  c15_k_a1 = c15_l_a0;
  c15_k_b1 = c15_l_b0;
  c15_l_a1 = c15_k_a1;
  c15_l_b1 = c15_k_b1;
  c15_f_c = (c15_l_a1 > c15_l_b1);
  c15_i14 = c15_t[2] - c15_t[1];
  if (c15_i14 > 131071) {
    c15_i14 = 131071;
  } else {
    if (c15_i14 < -131072) {
      c15_i14 = -131072;
    }
  }

  c15_i15 = c15_t[1] - c15_t[2];
  if (c15_i15 > 131071) {
    c15_i15 = 131071;
  } else {
    if (c15_i15 < -131072) {
      c15_i15 = -131072;
    }
  }

  if (c15_t[1] < c15_t[2]) {
    c15_g_t = (real_T)(c15_i14 <= 1);
  } else if (c15_t[1] > c15_t[2]) {
    if (c15_i15 <= 1) {
      c15_g_t = 3.0;
    } else {
      c15_g_t = 0.0;
    }
  } else {
    c15_g_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 6,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 5U, c15_g_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_f_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 21)))) {
    c15_cb_varargin_1 = c15_t[1];
    c15_f_varargin_2 = c15_t[2];
    c15_fmo_11 = c15_cb_varargin_1;
    c15_fmo_12 = c15_f_varargin_2;
    c15_b_fmo_11 = c15_emlrt_update_log_1(chartInstance, c15_fmo_11,
      chartInstance->c15_emlrtLocationLoggingDataTables, 44);
    c15_b_fmo_12 = c15_emlrt_update_log_1(chartInstance, c15_fmo_12,
      chartInstance->c15_emlrtLocationLoggingDataTables, 45);
    c15_db_varargin_1 = c15_b_fmo_11;
    c15_eb_varargin_1 = c15_db_varargin_1;
    c15_l_var1 = c15_eb_varargin_1;
    c15_l_hfi = c15_l_var1;
    c15_t[2] = c15_emlrt_update_log_1(chartInstance, c15_l_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 22);
    c15_fb_varargin_1 = c15_b_fmo_12;
    c15_gb_varargin_1 = c15_fb_varargin_1;
    c15_m_var1 = c15_gb_varargin_1;
    c15_m_hfi = c15_m_var1;
    c15_t[1] = c15_emlrt_update_log_1(chartInstance, c15_m_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 23);
  }

  c15_m_a0 = c15_t[2];
  c15_m_b0 = c15_t[3];
  c15_g_a = c15_m_a0;
  c15_g_b = c15_m_b0;
  c15_n_a0 = c15_g_a;
  c15_n_b0 = c15_g_b;
  c15_m_a1 = c15_n_a0;
  c15_m_b1 = c15_n_b0;
  c15_n_a1 = c15_m_a1;
  c15_n_b1 = c15_m_b1;
  c15_g_c = (c15_n_a1 > c15_n_b1);
  c15_i16 = c15_t[3] - c15_t[2];
  if (c15_i16 > 131071) {
    c15_i16 = 131071;
  } else {
    if (c15_i16 < -131072) {
      c15_i16 = -131072;
    }
  }

  c15_i17 = c15_t[2] - c15_t[3];
  if (c15_i17 > 131071) {
    c15_i17 = 131071;
  } else {
    if (c15_i17 < -131072) {
      c15_i17 = -131072;
    }
  }

  if (c15_t[2] < c15_t[3]) {
    c15_h_t = (real_T)(c15_i16 <= 1);
  } else if (c15_t[2] > c15_t[3]) {
    if (c15_i17 <= 1) {
      c15_h_t = 3.0;
    } else {
      c15_h_t = 0.0;
    }
  } else {
    c15_h_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 7,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 6U, c15_h_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_g_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 24)))) {
    c15_hb_varargin_1 = c15_t[2];
    c15_g_varargin_2 = c15_t[3];
    c15_fmo_13 = c15_hb_varargin_1;
    c15_fmo_14 = c15_g_varargin_2;
    c15_b_fmo_13 = c15_emlrt_update_log_1(chartInstance, c15_fmo_13,
      chartInstance->c15_emlrtLocationLoggingDataTables, 46);
    c15_b_fmo_14 = c15_emlrt_update_log_1(chartInstance, c15_fmo_14,
      chartInstance->c15_emlrtLocationLoggingDataTables, 47);
    c15_ib_varargin_1 = c15_b_fmo_13;
    c15_jb_varargin_1 = c15_ib_varargin_1;
    c15_n_var1 = c15_jb_varargin_1;
    c15_n_hfi = c15_n_var1;
    c15_emlrt_update_log_1(chartInstance, c15_n_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 25);
    c15_kb_varargin_1 = c15_b_fmo_14;
    c15_lb_varargin_1 = c15_kb_varargin_1;
    c15_o_var1 = c15_lb_varargin_1;
    c15_o_hfi = c15_o_var1;
    c15_t[2] = c15_emlrt_update_log_1(chartInstance, c15_o_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 26);
  }

  c15_o_a0 = c15_t[0];
  c15_o_b0 = c15_t[1];
  c15_h_a = c15_o_a0;
  c15_h_b = c15_o_b0;
  c15_p_a0 = c15_h_a;
  c15_p_b0 = c15_h_b;
  c15_o_a1 = c15_p_a0;
  c15_o_b1 = c15_p_b0;
  c15_p_a1 = c15_o_a1;
  c15_p_b1 = c15_o_b1;
  c15_h_c = (c15_p_a1 > c15_p_b1);
  c15_i18 = c15_t[1] - c15_t[0];
  if (c15_i18 > 131071) {
    c15_i18 = 131071;
  } else {
    if (c15_i18 < -131072) {
      c15_i18 = -131072;
    }
  }

  c15_i19 = c15_t[0] - c15_t[1];
  if (c15_i19 > 131071) {
    c15_i19 = 131071;
  } else {
    if (c15_i19 < -131072) {
      c15_i19 = -131072;
    }
  }

  if (c15_t[0] < c15_t[1]) {
    c15_i_t = (real_T)(c15_i18 <= 1);
  } else if (c15_t[0] > c15_t[1]) {
    if (c15_i19 <= 1) {
      c15_i_t = 3.0;
    } else {
      c15_i_t = 0.0;
    }
  } else {
    c15_i_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 8,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 7U, c15_i_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_h_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 27)))) {
    c15_mb_varargin_1 = c15_t[0];
    c15_h_varargin_2 = c15_t[1];
    c15_fmo_15 = c15_mb_varargin_1;
    c15_fmo_16 = c15_h_varargin_2;
    c15_b_fmo_15 = c15_emlrt_update_log_1(chartInstance, c15_fmo_15,
      chartInstance->c15_emlrtLocationLoggingDataTables, 48);
    c15_b_fmo_16 = c15_emlrt_update_log_1(chartInstance, c15_fmo_16,
      chartInstance->c15_emlrtLocationLoggingDataTables, 49);
    c15_nb_varargin_1 = c15_b_fmo_15;
    c15_ob_varargin_1 = c15_nb_varargin_1;
    c15_p_var1 = c15_ob_varargin_1;
    c15_p_hfi = c15_p_var1;
    c15_t[1] = c15_emlrt_update_log_1(chartInstance, c15_p_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 28);
    c15_pb_varargin_1 = c15_b_fmo_16;
    c15_qb_varargin_1 = c15_pb_varargin_1;
    c15_q_var1 = c15_qb_varargin_1;
    c15_q_hfi = c15_q_var1;
    c15_emlrt_update_log_1(chartInstance, c15_q_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 29);
  }

  c15_q_a0 = c15_t[1];
  c15_q_b0 = c15_t[2];
  c15_i_a = c15_q_a0;
  c15_i_b = c15_q_b0;
  c15_r_a0 = c15_i_a;
  c15_r_b0 = c15_i_b;
  c15_q_a1 = c15_r_a0;
  c15_q_b1 = c15_r_b0;
  c15_r_a1 = c15_q_a1;
  c15_r_b1 = c15_q_b1;
  c15_i_c = (c15_r_a1 > c15_r_b1);
  c15_i20 = c15_t[2] - c15_t[1];
  if (c15_i20 > 131071) {
    c15_i20 = 131071;
  } else {
    if (c15_i20 < -131072) {
      c15_i20 = -131072;
    }
  }

  c15_i21 = c15_t[1] - c15_t[2];
  if (c15_i21 > 131071) {
    c15_i21 = 131071;
  } else {
    if (c15_i21 < -131072) {
      c15_i21 = -131072;
    }
  }

  if (c15_t[1] < c15_t[2]) {
    c15_j_t = (real_T)(c15_i20 <= 1);
  } else if (c15_t[1] > c15_t[2]) {
    if (c15_i21 <= 1) {
      c15_j_t = 3.0;
    } else {
      c15_j_t = 0.0;
    }
  } else {
    c15_j_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c15_covrtInstance, 4U, 0, 9,
                     covrtRelationalopUpdateFcn(chartInstance->c15_covrtInstance,
        4U, 0U, 8U, c15_j_t, 0.0, -2, 4U, (int32_T)c15_emlrt_update_log_4
        (chartInstance, c15_i_c,
         chartInstance->c15_emlrtLocationLoggingDataTables, 30)))) {
    c15_rb_varargin_1 = c15_t[1];
    c15_i_varargin_2 = c15_t[2];
    c15_fmo_17 = c15_rb_varargin_1;
    c15_fmo_18 = c15_i_varargin_2;
    c15_b_fmo_17 = c15_emlrt_update_log_1(chartInstance, c15_fmo_17,
      chartInstance->c15_emlrtLocationLoggingDataTables, 50);
    c15_b_fmo_18 = c15_emlrt_update_log_1(chartInstance, c15_fmo_18,
      chartInstance->c15_emlrtLocationLoggingDataTables, 51);
    c15_ub_varargin_1 = c15_b_fmo_17;
    c15_vb_varargin_1 = c15_ub_varargin_1;
    c15_s_var1 = c15_vb_varargin_1;
    c15_s_hfi = c15_s_var1;
    c15_t[2] = c15_emlrt_update_log_1(chartInstance, c15_s_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 31);
    c15_wb_varargin_1 = c15_b_fmo_18;
    c15_xb_varargin_1 = c15_wb_varargin_1;
    c15_t_var1 = c15_xb_varargin_1;
    c15_t_hfi = c15_t_var1;
    c15_emlrt_update_log_1(chartInstance, c15_t_hfi,
      chartInstance->c15_emlrtLocationLoggingDataTables, 32);
  }

  c15_sb_varargin_1 = c15_t[2];
  c15_tb_varargin_1 = c15_sb_varargin_1;
  c15_r_var1 = c15_tb_varargin_1;
  c15_r_hfi = c15_r_var1;
  c15_b_y = c15_emlrt_update_log_1(chartInstance, c15_r_hfi,
    chartInstance->c15_emlrtLocationLoggingDataTables, 33);
  *chartInstance->c15_y = c15_b_y;
  c15_do_animation_call_c15_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c15_covrtInstance, 1U, (real_T)
                    *chartInstance->c15_y);
}

static void mdl_start_c15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c15_decisionTxtStartIdx = 0U;
  static const uint32_T c15_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c15_chart_data_browse_helper);
  chartInstance->c15_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c15_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c15_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c15_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c15_decisionTxtStartIdx, &c15_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c15_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c15_covrtInstance, "", 4U, 0U, 2U, 0U, 10U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 1633);
  covrtEmlFcnInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 1U, "get_fimath",
                     1636, -1, 1890);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 0U, 116, 130, -1,
                    178);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 1U, 350, 364, -1,
                    483);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 2U, 484, 498, -1,
                    617);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 3U, 618, 632, -1,
                    751);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 4U, 752, 766, -1,
                    885);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 5U, 895, 909, -1,
                    1030);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 6U, 1031, 1045, -1,
                    1168);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 7U, 1169, 1183, -1,
                    1306);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 8U, 1316, 1330, -1,
                    1453);
  covrtEmlIfInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 9U, 1454, 1468, -1,
                    1591);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 0U, 353,
    364, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 1U, 487,
    498, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 2U, 621,
    632, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 3U, 755,
    766, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 4U, 898,
    909, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 5U, 1034,
    1045, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 6U, 1172,
    1183, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 7U, 1319,
    1330, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c15_covrtInstance, 4U, 0U, 8U, 1457,
    1468, -2, 4U);
}

static void initSimStructsc15_zeabus_hydrophone_concrete
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c15_emlrt_update_log_1
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c15_in,
   emlrtLocationLoggingDataType c15_table[], int32_T c15_index)
{
  boolean_T c15_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c15_b_table;
  real_T c15_b_d;
  int32_T c15_i;
  int32_T c15_localMin;
  real_T c15_d1;
  int32_T c15_i1;
  int32_T c15_localMax;
  emlrtLocationLoggingHistogramType *c15_histTable;
  real_T c15_inDouble;
  real_T c15_significand;
  int32_T c15_exponent;
  (void)chartInstance;
  c15_isLoggingEnabledHere = (c15_index >= 0);
  if (c15_isLoggingEnabledHere) {
    c15_b_table = (emlrtLocationLoggingDataType *)&c15_table[c15_index];
    c15_b_d = muDoubleScalarFloor(c15_b_table[0U].SimMin * 131072.0);
    if (c15_b_d < 131072.0) {
      if (c15_b_d >= -131072.0) {
        c15_i = (int32_T)c15_b_d;
      } else {
        c15_i = -131072;
      }
    } else if (c15_b_d >= 131072.0) {
      c15_i = 131071;
    } else {
      c15_i = 0;
    }

    c15_localMin = c15_i;
    c15_d1 = muDoubleScalarFloor(c15_b_table[0U].SimMax * 131072.0);
    if (c15_d1 < 131072.0) {
      if (c15_d1 >= -131072.0) {
        c15_i1 = (int32_T)c15_d1;
      } else {
        c15_i1 = -131072;
      }
    } else if (c15_d1 >= 131072.0) {
      c15_i1 = 131071;
    } else {
      c15_i1 = 0;
    }

    c15_localMax = c15_i1;
    c15_histTable = c15_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c15_in < c15_localMin) {
      c15_localMin = c15_in;
    }

    if (c15_in > c15_localMax) {
      c15_localMax = c15_in;
    }

    /* Histogram logging. */
    c15_inDouble = (real_T)c15_in * 7.62939453125E-6;
    c15_histTable->TotalNumberOfValues++;
    if (c15_inDouble == 0.0) {
      c15_histTable->NumberOfZeros++;
    } else {
      c15_histTable->SimSum += c15_inDouble;
      if ((!muDoubleScalarIsInf(c15_inDouble)) && (!muDoubleScalarIsNaN
           (c15_inDouble))) {
        c15_significand = frexp(c15_inDouble, &c15_exponent);
        if (c15_exponent > 128) {
          c15_exponent = 128;
        }

        if (c15_exponent < -127) {
          c15_exponent = -127;
        }

        if (c15_significand < 0.0) {
          c15_histTable->NumberOfNegativeValues++;
          c15_histTable->HistogramOfNegativeValues[127 + c15_exponent]++;
        } else {
          c15_histTable->NumberOfPositiveValues++;
          c15_histTable->HistogramOfPositiveValues[127 + c15_exponent]++;
        }
      }
    }

    c15_b_table[0U].SimMin = (real_T)c15_localMin * 7.62939453125E-6;
    c15_b_table[0U].SimMax = (real_T)c15_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c15_in & 131071U) != 0U) {
      c15_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c15_in;
}

static void c15_emlrt_update_log_2
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[5], emlrtLocationLoggingDataType c15_table[], int32_T c15_index,
   int32_T c15_out[5])
{
  int32_T c15_i;
  for (c15_i = 0; c15_i < 5; c15_i++) {
    c15_out[c15_i] = c15_in[c15_i];
  }

  c15_b_emlrt_update_log_2(chartInstance, c15_out, c15_table, c15_index);
}

static void c15_emlrt_update_log_3
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[4], emlrtLocationLoggingDataType c15_table[], int32_T c15_index,
   int32_T c15_out[4])
{
  int32_T c15_i;
  for (c15_i = 0; c15_i < 4; c15_i++) {
    c15_out[c15_i] = c15_in[c15_i];
  }

  c15_b_emlrt_update_log_3(chartInstance, c15_out, c15_table, c15_index);
}

static boolean_T c15_emlrt_update_log_4
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c15_in, emlrtLocationLoggingDataType c15_table[], int32_T c15_index)
{
  boolean_T c15_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c15_b_table;
  boolean_T c15_localMin;
  boolean_T c15_localMax;
  emlrtLocationLoggingHistogramType *c15_histTable;
  real_T c15_inDouble;
  real_T c15_significand;
  int32_T c15_exponent;
  (void)chartInstance;
  c15_isLoggingEnabledHere = (c15_index >= 0);
  if (c15_isLoggingEnabledHere) {
    c15_b_table = (emlrtLocationLoggingDataType *)&c15_table[c15_index];
    c15_localMin = (c15_b_table[0U].SimMin > 0.0);
    c15_localMax = (c15_b_table[0U].SimMax > 0.0);
    c15_histTable = c15_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c15_in < (int32_T)c15_localMin) {
      c15_localMin = c15_in;
    }

    if ((int32_T)c15_in > (int32_T)c15_localMax) {
      c15_localMax = c15_in;
    }

    /* Histogram logging. */
    c15_inDouble = (real_T)c15_in;
    c15_histTable->TotalNumberOfValues++;
    if (c15_inDouble == 0.0) {
      c15_histTable->NumberOfZeros++;
    } else {
      c15_histTable->SimSum += c15_inDouble;
      if ((!muDoubleScalarIsInf(c15_inDouble)) && (!muDoubleScalarIsNaN
           (c15_inDouble))) {
        c15_significand = frexp(c15_inDouble, &c15_exponent);
        if (c15_exponent > 128) {
          c15_exponent = 128;
        }

        if (c15_exponent < -127) {
          c15_exponent = -127;
        }

        if (c15_significand < 0.0) {
          c15_histTable->NumberOfNegativeValues++;
          c15_histTable->HistogramOfNegativeValues[127 + c15_exponent]++;
        } else {
          c15_histTable->NumberOfPositiveValues++;
          c15_histTable->HistogramOfPositiveValues[127 + c15_exponent]++;
        }
      }
    }

    c15_b_table[0U].SimMin = (real_T)c15_localMin;
    c15_b_table[0U].SimMax = (real_T)c15_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c15_in;
}

static void c15_emlrtInitVarDataTables
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c15_dataTables[52],
   emlrtLocationLoggingHistogramType c15_histTables[52])
{
  int32_T c15_i;
  int32_T c15_iH;
  (void)chartInstance;
  for (c15_i = 0; c15_i < 52; c15_i++) {
    c15_dataTables[c15_i].SimMin = rtInf;
    c15_dataTables[c15_i].SimMax = rtMinusInf;
    c15_dataTables[c15_i].OverflowWraps = 0;
    c15_dataTables[c15_i].Saturations = 0;
    c15_dataTables[c15_i].IsAlwaysInteger = true;
    c15_dataTables[c15_i].HistogramTable = &c15_histTables[c15_i];
    c15_histTables[c15_i].NumberOfZeros = 0.0;
    c15_histTables[c15_i].NumberOfPositiveValues = 0.0;
    c15_histTables[c15_i].NumberOfNegativeValues = 0.0;
    c15_histTables[c15_i].TotalNumberOfValues = 0.0;
    c15_histTables[c15_i].SimSum = 0.0;
    for (c15_iH = 0; c15_iH < 256; c15_iH++) {
      c15_histTables[c15_i].HistogramOfPositiveValues[c15_iH] = 0.0;
      c15_histTables[c15_i].HistogramOfNegativeValues[c15_iH] = 0.0;
    }
  }
}

const mxArray *sf_c15_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c15_nameCaptureInfo = NULL;
  c15_nameCaptureInfo = NULL;
  sf_mex_assign(&c15_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c15_nameCaptureInfo;
}

static int32_T c15_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_y, const char_T *c15_identifier)
{
  int32_T c15_c_y;
  emlrtMsgIdentifier c15_thisId;
  c15_thisId.fIdentifier = (const char *)c15_identifier;
  c15_thisId.fParent = NULL;
  c15_thisId.bParentIsCell = false;
  c15_c_y = c15_b_emlrt_marshallIn(chartInstance, c15_sp, sf_mex_dup(c15_b_y),
    &c15_thisId);
  sf_mex_destroy(&c15_b_y);
  return c15_c_y;
}

static int32_T c15_b_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_u, const emlrtMsgIdentifier
   *c15_parentId)
{
  int32_T c15_b_y;
  const mxArray *c15_mxFi = NULL;
  const mxArray *c15_mxInt = NULL;
  int32_T c15_i;
  (void)chartInstance;
  sf_mex_check_fi(c15_parentId, c15_b_u, false, 0U, NULL, c15_eml_mx,
                  c15_b_eml_mx);
  sf_mex_assign(&c15_mxFi, sf_mex_dup(c15_b_u), false);
  sf_mex_assign(&c15_mxInt, sf_mex_call(c15_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c15_mxFi)), false);
  sf_mex_import(c15_parentId, sf_mex_dup(c15_mxInt), &c15_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c15_mxFi);
  sf_mex_destroy(&c15_mxInt);
  c15_b_y = c15_i;
  sf_mex_destroy(&c15_mxFi);
  sf_mex_destroy(&c15_b_u);
  return c15_b_y;
}

static void c15_c_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_d, const char_T *c15_identifier,
   boolean_T *c15_svPtr, int32_T c15_b_y[5])
{
  emlrtMsgIdentifier c15_thisId;
  c15_thisId.fIdentifier = (const char *)c15_identifier;
  c15_thisId.fParent = NULL;
  c15_thisId.bParentIsCell = false;
  c15_d_emlrt_marshallIn(chartInstance, c15_sp, sf_mex_dup(c15_b_d), &c15_thisId,
    c15_svPtr, c15_b_y);
  sf_mex_destroy(&c15_b_d);
}

static void c15_d_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c15_sp, const mxArray *c15_b_u, const emlrtMsgIdentifier
   *c15_parentId, boolean_T *c15_svPtr, int32_T c15_b_y[5])
{
  int32_T c15_i;
  uint32_T c15_uv[2];
  const mxArray *c15_mxFi = NULL;
  const mxArray *c15_mxInt = NULL;
  int32_T c15_iv[5];
  int32_T c15_i1;
  (void)chartInstance;
  for (c15_i = 0; c15_i < 2; c15_i++) {
    c15_uv[c15_i] = 1U + ((uint32_T)c15_i << 2);
  }

  if (mxIsEmpty(c15_b_u)) {
    *c15_svPtr = false;
  } else {
    *c15_svPtr = true;
    sf_mex_check_fi(c15_parentId, c15_b_u, false, 2U, c15_uv, c15_eml_mx,
                    c15_b_eml_mx);
    sf_mex_assign(&c15_mxFi, sf_mex_dup(c15_b_u), false);
    sf_mex_assign(&c15_mxInt, sf_mex_call(c15_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c15_mxFi)), false);
    sf_mex_import(c15_parentId, sf_mex_dup(c15_mxInt), c15_iv, 1, 6, 0U, 1, 0U,
                  2, 1, 5);
    sf_mex_destroy(&c15_mxFi);
    sf_mex_destroy(&c15_mxInt);
    for (c15_i1 = 0; c15_i1 < 5; c15_i1++) {
      c15_b_y[c15_i1] = c15_iv[c15_i1];
    }
  }

  sf_mex_destroy(&c15_mxFi);
  sf_mex_destroy(&c15_b_u);
}

static uint8_T c15_e_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c15_b_is_active_c15_zeabus_hydrophone_concrete, const char_T *c15_identifier)
{
  uint8_T c15_b_y;
  emlrtMsgIdentifier c15_thisId;
  c15_thisId.fIdentifier = (const char *)c15_identifier;
  c15_thisId.fParent = NULL;
  c15_thisId.bParentIsCell = false;
  c15_b_y = c15_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c15_b_is_active_c15_zeabus_hydrophone_concrete), &c15_thisId);
  sf_mex_destroy(&c15_b_is_active_c15_zeabus_hydrophone_concrete);
  return c15_b_y;
}

static uint8_T c15_f_emlrt_marshallIn
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c15_b_u, const emlrtMsgIdentifier *c15_parentId)
{
  uint8_T c15_b_y;
  uint8_T c15_c_u;
  (void)chartInstance;
  sf_mex_import(c15_parentId, sf_mex_dup(c15_b_u), &c15_c_u, 1, 3, 0U, 0, 0U, 0);
  c15_b_y = c15_c_u;
  sf_mex_destroy(&c15_b_u);
  return c15_b_y;
}

static const mxArray *c15_chart_data_browse_helper
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_ssIdNumber)
{
  const mxArray *c15_mxData = NULL;
  int32_T c15_i;
  int32_T c15_i1;
  real_T c15_b_d;
  real_T c15_d1;
  c15_mxData = NULL;
  switch (c15_ssIdNumber) {
   case 4U:
    c15_i = *chartInstance->c15_u;
    c15_b_d = (real_T)c15_i * 7.62939453125E-6;
    sf_mex_assign(&c15_mxData, sf_mex_create("mxData", &c15_b_d, 0, 0U, 0U, 0U,
      0), false);
    break;

   case 5U:
    c15_i1 = *chartInstance->c15_y;
    c15_d1 = (real_T)c15_i1 * 7.62939453125E-6;
    sf_mex_assign(&c15_mxData, sf_mex_create("mxData", &c15_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c15_mxData;
}

static void c15_b_emlrt_update_log_2
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[5], emlrtLocationLoggingDataType c15_table[], int32_T c15_index)
{
  boolean_T c15_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c15_b_table;
  real_T c15_b_d;
  int32_T c15_i;
  int32_T c15_localMin;
  real_T c15_d1;
  int32_T c15_i1;
  int32_T c15_localMax;
  emlrtLocationLoggingHistogramType *c15_histTable;
  int32_T c15_b_i;
  int32_T c15_c_i;
  real_T c15_inDouble;
  real_T c15_significand;
  int32_T c15_exponent;
  (void)chartInstance;
  c15_isLoggingEnabledHere = (c15_index >= 0);
  if (c15_isLoggingEnabledHere) {
    c15_b_table = (emlrtLocationLoggingDataType *)&c15_table[c15_index];
    c15_b_d = muDoubleScalarFloor(c15_b_table[0U].SimMin * 131072.0);
    if (c15_b_d < 131072.0) {
      if (c15_b_d >= -131072.0) {
        c15_i = (int32_T)c15_b_d;
      } else {
        c15_i = -131072;
      }
    } else if (c15_b_d >= 131072.0) {
      c15_i = 131071;
    } else {
      c15_i = 0;
    }

    c15_localMin = c15_i;
    c15_d1 = muDoubleScalarFloor(c15_b_table[0U].SimMax * 131072.0);
    if (c15_d1 < 131072.0) {
      if (c15_d1 >= -131072.0) {
        c15_i1 = (int32_T)c15_d1;
      } else {
        c15_i1 = -131072;
      }
    } else if (c15_d1 >= 131072.0) {
      c15_i1 = 131071;
    } else {
      c15_i1 = 0;
    }

    c15_localMax = c15_i1;
    c15_histTable = c15_b_table[0U].HistogramTable;
    for (c15_b_i = 0; c15_b_i < 5; c15_b_i++) {
      /* Simulation Min-Max logging. */
      if (c15_in[c15_b_i] < c15_localMin) {
        c15_localMin = c15_in[c15_b_i];
      }

      if (c15_in[c15_b_i] > c15_localMax) {
        c15_localMax = c15_in[c15_b_i];
      }

      /* Histogram logging. */
      c15_inDouble = (real_T)c15_in[c15_b_i] * 7.62939453125E-6;
      c15_histTable->TotalNumberOfValues++;
      if (c15_inDouble == 0.0) {
        c15_histTable->NumberOfZeros++;
      } else {
        c15_histTable->SimSum += c15_inDouble;
        if ((!muDoubleScalarIsInf(c15_inDouble)) && (!muDoubleScalarIsNaN
             (c15_inDouble))) {
          c15_significand = frexp(c15_inDouble, &c15_exponent);
          if (c15_exponent > 128) {
            c15_exponent = 128;
          }

          if (c15_exponent < -127) {
            c15_exponent = -127;
          }

          if (c15_significand < 0.0) {
            c15_histTable->NumberOfNegativeValues++;
            c15_histTable->HistogramOfNegativeValues[127 + c15_exponent]++;
          } else {
            c15_histTable->NumberOfPositiveValues++;
            c15_histTable->HistogramOfPositiveValues[127 + c15_exponent]++;
          }
        }
      }
    }

    c15_b_table[0U].SimMin = (real_T)c15_localMin * 7.62939453125E-6;
    c15_b_table[0U].SimMax = (real_T)c15_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c15_c_i = 0;
    while (c15_b_table[0U].IsAlwaysInteger && (c15_c_i < 5)) {
      if (((uint32_T)c15_in[c15_c_i] & 131071U) != 0U) {
        c15_b_table[0U].IsAlwaysInteger = false;
      }

      c15_c_i++;
    }
  }
}

static void c15_b_emlrt_update_log_3
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c15_in[4], emlrtLocationLoggingDataType c15_table[], int32_T c15_index)
{
  boolean_T c15_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c15_b_table;
  real_T c15_b_d;
  int32_T c15_i;
  int32_T c15_localMin;
  real_T c15_d1;
  int32_T c15_i1;
  int32_T c15_localMax;
  emlrtLocationLoggingHistogramType *c15_histTable;
  int32_T c15_b_i;
  int32_T c15_c_i;
  real_T c15_inDouble;
  real_T c15_significand;
  int32_T c15_exponent;
  (void)chartInstance;
  c15_isLoggingEnabledHere = (c15_index >= 0);
  if (c15_isLoggingEnabledHere) {
    c15_b_table = (emlrtLocationLoggingDataType *)&c15_table[c15_index];
    c15_b_d = muDoubleScalarFloor(c15_b_table[0U].SimMin * 131072.0);
    if (c15_b_d < 131072.0) {
      if (c15_b_d >= -131072.0) {
        c15_i = (int32_T)c15_b_d;
      } else {
        c15_i = -131072;
      }
    } else if (c15_b_d >= 131072.0) {
      c15_i = 131071;
    } else {
      c15_i = 0;
    }

    c15_localMin = c15_i;
    c15_d1 = muDoubleScalarFloor(c15_b_table[0U].SimMax * 131072.0);
    if (c15_d1 < 131072.0) {
      if (c15_d1 >= -131072.0) {
        c15_i1 = (int32_T)c15_d1;
      } else {
        c15_i1 = -131072;
      }
    } else if (c15_d1 >= 131072.0) {
      c15_i1 = 131071;
    } else {
      c15_i1 = 0;
    }

    c15_localMax = c15_i1;
    c15_histTable = c15_b_table[0U].HistogramTable;
    for (c15_b_i = 0; c15_b_i < 4; c15_b_i++) {
      /* Simulation Min-Max logging. */
      if (c15_in[c15_b_i] < c15_localMin) {
        c15_localMin = c15_in[c15_b_i];
      }

      if (c15_in[c15_b_i] > c15_localMax) {
        c15_localMax = c15_in[c15_b_i];
      }

      /* Histogram logging. */
      c15_inDouble = (real_T)c15_in[c15_b_i] * 7.62939453125E-6;
      c15_histTable->TotalNumberOfValues++;
      if (c15_inDouble == 0.0) {
        c15_histTable->NumberOfZeros++;
      } else {
        c15_histTable->SimSum += c15_inDouble;
        if ((!muDoubleScalarIsInf(c15_inDouble)) && (!muDoubleScalarIsNaN
             (c15_inDouble))) {
          c15_significand = frexp(c15_inDouble, &c15_exponent);
          if (c15_exponent > 128) {
            c15_exponent = 128;
          }

          if (c15_exponent < -127) {
            c15_exponent = -127;
          }

          if (c15_significand < 0.0) {
            c15_histTable->NumberOfNegativeValues++;
            c15_histTable->HistogramOfNegativeValues[127 + c15_exponent]++;
          } else {
            c15_histTable->NumberOfPositiveValues++;
            c15_histTable->HistogramOfPositiveValues[127 + c15_exponent]++;
          }
        }
      }
    }

    c15_b_table[0U].SimMin = (real_T)c15_localMin * 7.62939453125E-6;
    c15_b_table[0U].SimMax = (real_T)c15_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c15_c_i = 0;
    while (c15_b_table[0U].IsAlwaysInteger && (c15_c_i < 4)) {
      if (((uint32_T)c15_in[c15_c_i] & 131071U) != 0U) {
        c15_b_table[0U].IsAlwaysInteger = false;
      }

      c15_c_i++;
    }
  }
}

static void init_dsm_address_info(SFc15_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c15_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c15_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c15_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c15_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c15_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2929868855U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(436972284U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(707407755U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(719007121U);
}

mxArray *sf_c15_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c15_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c15_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c15_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiCewMzAwAakOYCYiQECWKF8RiBmhtIQcRa4uAIQl1QWpILEi4uSPVOAdF5iLpi"
    "fWFrhmZeWDzbfggFhPhsW8xmRzOeEikPAB3vK9Is4gPQbIOlnIaBfAMiqhIYLLHzIt1/AgTL9EP"
    "tJdX8KVN8FBvzxyogWr0xQPkhPDkMmQwHUHAcC7mdCc78AzPEOMQ5guiGGKuFAeXwoUMUdEQTiQ"
    "wMlPiD8zOL4xOSSzLLU+GRD0/iq1MSk0uL4jMqUovyCjPw8oGh+XnJRakkqzJ8AK9UnEQ=="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c15_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "s2lfbEDUyQjWCMMTPbwPIdD";
}

static void sf_opaque_initialize_c15_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c15_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c15_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c15_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c15_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c15_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c15_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc15_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c15_zeabus_hydrophone_concrete
      ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc15_zeabus_hydrophone_concrete
    ((SFc15_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c15_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c15_zeabus_hydrophone_concrete
      ((SFc15_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc15_zeabus_hydrophone_concrete
      ((SFc15_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c15_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [17] = {
    "eNrtVstu00AUddKAWlGqIIFAgkV3dMECkJDYEZqHiJTQQPpgUSma2DfxkPGMmUfSsGLHhgUfwI4",
    "f4gfY8QF8AteO00aO7TSkVEhgyRmPc+6Zcx9zPVau3rTw2sL7zg3LuorjOt55a3Jdiea5mXvyvm",
    "Ddj+ZfEcSN1yKSeMrKvDjx4DUowYymgtd5TyTCKO+BBG4j1hdSp7Ep6hlG+aBmuB3wqSOX2m7bF",
    "YY5u2hLnD3OxsjmG91CngqVYOsagKNdKUzfrTHSP1Us9ajsgj1QxstyQYFuGz+QpZqGaeozqJ6A",
    "XedKE1SszrS1NdFQ1iepbgaeqvYUKDyfUcITvXWJaoOPAdZw4Dv4u2c0OhWH2S6RehdcMgTVoIO",
    "QU3CIc1KFf3QpJ1pISljVY+XAcF5bi6GepnCAZQQEte1KIANfUK7T89+uoadVTroMKtA1/XS2Nr",
    "wzQfIPKYxApsatVxZDkKQPezx10TAg1ZMwW6dVMg/T1INDIp/bmD8FTmr1YuWoNsE8wT5apMEgd",
    "LKu9iUdYnhT2YxXDypz0ZYx3iTZahEsZKsOISsLp2w1m5cJYyoVti/8BgyBhawVokk2bMKajPOl",
    "8Ekfq9bBIAclXhbcoXO5sI3SwitjuVUajZfYKZLFncHqXIPsERuS9q2yXXAMA3QUO5MOl0sgdag",
    "KsrUAFeV0EcpSPcMrIyEH6GjGtj9zIchBKtBTfYw+1u6BwjLPggXRX4ib9vmH1lmf3zxHn5/axc",
    "edGZ5cAo81M8bX3chnr5vHp1xkV5qxux5bpxCzC3BFvL9UP30Xd9c/Ht7aPOI/Hlxbaf3Cct/Fr",
    "Wh+b9qATstzOFcVAfbFjK5CAv/tGf5iNFePWa9brRyMX709Kjeb+63uqFV3KiHf57VsvWsxvdP3",
    "20EnHPthX1PSrjvRBzuYEzP5jAX8T2f0Xl0Qj43o/eT6+Ww1+5uleB4LC+yL+DSO1e3vr18srWY",
    "/vw/Oo9+J7L5Zy9VhPpoHNsyilp+wn5L052P6i1PxpeNSOH44vpA4rJ6P7QvR8WZBPnZi+28nPH",
    "90CJ4mhtCxHz3pvAfSNarjjh380rl44urYgtsSNGxdQP9b1s76b/dX2OX+Qf/Oc564bDvrku1W9",
    "W/Zc9Uq57B4v7Ni+OIK6/xp/Krn0WXwvwAfwWkG",
    ""
  };

  static char newstr [1165] = "";
  newstr[0] = '\0';
  for (i = 0; i < 17; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c15_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c15_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(3716957596U));
  ssSetChecksum1(S,(2265455471U));
  ssSetChecksum2(S,(1460409686U));
  ssSetChecksum3(S,(187491438U));
}

static void mdlRTW_c15_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c15_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc15_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc15_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc15_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc15_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c15_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c15_zeabus_hydrophone_concrete;
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
    chartInstance->c15_JITStateAnimation,
    chartInstance->c15_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c15_zeabus_hydrophone_concrete(chartInstance);
}

void c15_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c15_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c15_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c15_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c15_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
