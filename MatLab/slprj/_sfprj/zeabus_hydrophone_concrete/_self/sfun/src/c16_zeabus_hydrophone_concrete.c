/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c16_zeabus_hydrophone_concrete.h"
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
static const mxArray *c16_eml_mx;
static const mxArray *c16_b_eml_mx;
static emlrtRSInfo c16_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC2 Interface/Median Filter/Median Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:604"    /* pathName */
};

/* Function Declarations */
static void initialize_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c16_update_jit_animation_state_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c16_do_animation_call_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c16_st);
static void finalize_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c16_emlrt_update_log_1
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c16_in,
   emlrtLocationLoggingDataType c16_table[], int32_T c16_index);
static void c16_emlrt_update_log_2
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[5], emlrtLocationLoggingDataType c16_table[], int32_T c16_index,
   int32_T c16_out[5]);
static void c16_emlrt_update_log_3
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[4], emlrtLocationLoggingDataType c16_table[], int32_T c16_index,
   int32_T c16_out[4]);
static boolean_T c16_emlrt_update_log_4
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c16_in, emlrtLocationLoggingDataType c16_table[], int32_T c16_index);
static void c16_emlrtInitVarDataTables
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c16_dataTables[52],
   emlrtLocationLoggingHistogramType c16_histTables[52]);
static int32_T c16_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_y, const char_T *c16_identifier);
static int32_T c16_b_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_u, const emlrtMsgIdentifier
   *c16_parentId);
static void c16_c_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_d, const char_T *c16_identifier,
   boolean_T *c16_svPtr, int32_T c16_b_y[5]);
static void c16_d_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_u, const emlrtMsgIdentifier
   *c16_parentId, boolean_T *c16_svPtr, int32_T c16_b_y[5]);
static uint8_T c16_e_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c16_b_is_active_c16_zeabus_hydrophone_concrete, const char_T *c16_identifier);
static uint8_T c16_f_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c16_b_u, const emlrtMsgIdentifier *c16_parentId);
static const mxArray *c16_chart_data_browse_helper
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_ssIdNumber);
static void c16_b_emlrt_update_log_2
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[5], emlrtLocationLoggingDataType c16_table[], int32_T c16_index);
static void c16_b_emlrt_update_log_3
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[4], emlrtLocationLoggingDataType c16_table[], int32_T c16_index);
static void init_dsm_address_info(SFc16_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c16_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c16_st.tls = chartInstance->c16_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c16_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c16_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c16_d_not_empty = false;
  chartInstance->c16_is_active_c16_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c16_b_eml_mx, sf_mex_call(&c16_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c16_eml_mx, sf_mex_call(&c16_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c16_emlrtLocLogSimulated = false;
  c16_emlrtInitVarDataTables(chartInstance,
    chartInstance->c16_emlrtLocationLoggingDataTables,
    chartInstance->c16_emlrtLocLogHistTables);
}

static void initialize_params_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c16_update_jit_animation_state_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c16_do_animation_call_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c16_st;
  const mxArray *c16_b_y = NULL;
  const mxArray *c16_c_y = NULL;
  int32_T c16_b_u;
  const mxArray *c16_d_y = NULL;
  const mxArray *c16_e_y = NULL;
  int32_T c16_i;
  const mxArray *c16_f_y = NULL;
  int32_T c16_c_u[5];
  const mxArray *c16_g_y = NULL;
  c16_st = NULL;
  c16_st = NULL;
  c16_b_y = NULL;
  sf_mex_assign(&c16_b_y, sf_mex_createcellmatrix(3, 1), false);
  c16_c_y = NULL;
  c16_b_u = *chartInstance->c16_y;
  c16_d_y = NULL;
  sf_mex_assign(&c16_d_y, sf_mex_create("y", &c16_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c16_c_y, sf_mex_create_fi(sf_mex_dup(c16_eml_mx), sf_mex_dup
    (c16_b_eml_mx), "simulinkarray", c16_d_y, false, false), false);
  sf_mex_setcell(c16_b_y, 0, c16_c_y);
  c16_e_y = NULL;
  if (!chartInstance->c16_d_not_empty) {
    sf_mex_assign(&c16_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    for (c16_i = 0; c16_i < 5; c16_i++) {
      c16_c_u[c16_i] = chartInstance->c16_d[c16_i];
    }

    c16_f_y = NULL;
    sf_mex_assign(&c16_f_y, sf_mex_create("y", c16_c_u, 6, 0U, 1U, 0U, 2, 1, 5),
                  false);
    sf_mex_assign(&c16_e_y, sf_mex_create_fi(sf_mex_dup(c16_eml_mx), sf_mex_dup
      (c16_b_eml_mx), "simulinkarray", c16_f_y, true, false), false);
  }

  sf_mex_setcell(c16_b_y, 1, c16_e_y);
  c16_g_y = NULL;
  sf_mex_assign(&c16_g_y, sf_mex_create("y",
    &chartInstance->c16_is_active_c16_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c16_b_y, 2, c16_g_y);
  sf_mex_assign(&c16_st, c16_b_y, false);
  return c16_st;
}

static void set_sim_state_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c16_st)
{
  emlrtStack c16_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c16_b_u;
  int32_T c16_iv[5];
  int32_T c16_i;
  c16_b_st.tls = chartInstance->c16_fEmlrtCtx;
  chartInstance->c16_doneDoubleBufferReInit = true;
  c16_b_u = sf_mex_dup(c16_st);
  *chartInstance->c16_y = c16_emlrt_marshallIn(chartInstance, &c16_b_st,
    sf_mex_dup(sf_mex_getcell(c16_b_u, 0)), "y");
  c16_c_emlrt_marshallIn(chartInstance, &c16_b_st, sf_mex_dup(sf_mex_getcell
    (c16_b_u, 1)), "d", &chartInstance->c16_d_not_empty, c16_iv);
  for (c16_i = 0; c16_i < 5; c16_i++) {
    chartInstance->c16_d[c16_i] = c16_iv[c16_i];
  }

  chartInstance->c16_is_active_c16_zeabus_hydrophone_concrete =
    c16_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c16_b_u, 2)),
    "is_active_c16_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c16_b_u);
  sf_mex_destroy(&c16_st);
}

static void finalize_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c16_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:604", /* mexFileName */
    "Thu Apr 16 10:58:15 2020",        /* timestamp */
    "",                                /* buildDir */
    1,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c16_emlrtLocationLoggingFunctionInfoTable[1] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      52                               /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c16_emlrtLocationInfo[73] = { { 1,/* MxInfoID */
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

  const int32_T c16_emlrtLocationLoggingFieldCounts[52] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c16_RuntimeVar);
  if (chartInstance->c16_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:604");
    emlrtLocationLoggingPushLog(&c16_emlrtLocationLoggingFileInfo,
      c16_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c16_emlrtLocationLoggingDataTables, c16_emlrtLocationInfo,
      NULL, 0U, c16_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:604");
  }

  sf_mex_destroy(&c16_eml_mx);
  sf_mex_destroy(&c16_b_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c16_covrtInstance);
}

static void sf_gateway_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c16_b_u;
  int32_T c16_varargin_1;
  int32_T c16_b_varargin_1;
  int32_T c16_var1;
  int32_T c16_hfi;
  int32_T c16_c_u;
  int32_T c16_i;
  int32_T c16_i1;
  int32_T c16_i2;
  int32_T c16_iv[4];
  int32_T c16_i3;
  int32_T c16_t[5];
  int32_T c16_a0;
  int32_T c16_b0;
  int32_T c16_a;
  int32_T c16_b;
  int32_T c16_b_a0;
  int32_T c16_b_b0;
  int32_T c16_a1;
  int32_T c16_b1;
  int32_T c16_b_a1;
  int32_T c16_b_b1;
  boolean_T c16_c;
  int32_T c16_i4;
  int32_T c16_i5;
  real_T c16_b_t;
  int32_T c16_c_varargin_1;
  int32_T c16_c_a0;
  int32_T c16_varargin_2;
  int32_T c16_c_b0;
  int32_T c16_fmo_1;
  int32_T c16_b_a;
  int32_T c16_fmo_2;
  int32_T c16_b_b;
  int32_T c16_b_fmo_1;
  int32_T c16_d_a0;
  int32_T c16_b_fmo_2;
  int32_T c16_d_b0;
  int32_T c16_d_varargin_1;
  int32_T c16_c_a1;
  int32_T c16_e_varargin_1;
  int32_T c16_c_b1;
  int32_T c16_b_var1;
  int32_T c16_d_a1;
  int32_T c16_b_hfi;
  int32_T c16_d_b1;
  boolean_T c16_b_c;
  int32_T c16_f_varargin_1;
  int32_T c16_i6;
  int32_T c16_g_varargin_1;
  int32_T c16_c_var1;
  int32_T c16_c_hfi;
  int32_T c16_i7;
  real_T c16_c_t;
  int32_T c16_h_varargin_1;
  int32_T c16_e_a0;
  int32_T c16_b_varargin_2;
  int32_T c16_e_b0;
  int32_T c16_fmo_3;
  int32_T c16_c_a;
  int32_T c16_fmo_4;
  int32_T c16_c_b;
  int32_T c16_b_fmo_3;
  int32_T c16_f_a0;
  int32_T c16_b_fmo_4;
  int32_T c16_f_b0;
  int32_T c16_i_varargin_1;
  int32_T c16_e_a1;
  int32_T c16_j_varargin_1;
  int32_T c16_e_b1;
  int32_T c16_d_var1;
  int32_T c16_f_a1;
  int32_T c16_d_hfi;
  int32_T c16_f_b1;
  boolean_T c16_c_c;
  int32_T c16_k_varargin_1;
  int32_T c16_i8;
  int32_T c16_l_varargin_1;
  int32_T c16_e_var1;
  int32_T c16_e_hfi;
  int32_T c16_i9;
  real_T c16_d_t;
  int32_T c16_m_varargin_1;
  int32_T c16_g_a0;
  int32_T c16_c_varargin_2;
  int32_T c16_g_b0;
  int32_T c16_fmo_5;
  int32_T c16_d_a;
  int32_T c16_fmo_6;
  int32_T c16_d_b;
  int32_T c16_b_fmo_5;
  int32_T c16_h_a0;
  int32_T c16_b_fmo_6;
  int32_T c16_h_b0;
  int32_T c16_n_varargin_1;
  int32_T c16_g_a1;
  int32_T c16_o_varargin_1;
  int32_T c16_g_b1;
  int32_T c16_f_var1;
  int32_T c16_h_a1;
  int32_T c16_f_hfi;
  int32_T c16_h_b1;
  boolean_T c16_d_c;
  int32_T c16_p_varargin_1;
  int32_T c16_i10;
  int32_T c16_q_varargin_1;
  int32_T c16_g_var1;
  int32_T c16_g_hfi;
  int32_T c16_i11;
  real_T c16_e_t;
  int32_T c16_r_varargin_1;
  int32_T c16_i_a0;
  int32_T c16_d_varargin_2;
  int32_T c16_i_b0;
  int32_T c16_fmo_7;
  int32_T c16_e_a;
  int32_T c16_fmo_8;
  int32_T c16_e_b;
  int32_T c16_b_fmo_7;
  int32_T c16_j_a0;
  int32_T c16_b_fmo_8;
  int32_T c16_j_b0;
  int32_T c16_s_varargin_1;
  int32_T c16_i_a1;
  int32_T c16_t_varargin_1;
  int32_T c16_i_b1;
  int32_T c16_h_var1;
  int32_T c16_j_a1;
  int32_T c16_h_hfi;
  int32_T c16_j_b1;
  boolean_T c16_e_c;
  int32_T c16_u_varargin_1;
  int32_T c16_i12;
  int32_T c16_v_varargin_1;
  int32_T c16_i_var1;
  int32_T c16_i_hfi;
  int32_T c16_i13;
  real_T c16_f_t;
  int32_T c16_w_varargin_1;
  int32_T c16_k_a0;
  int32_T c16_e_varargin_2;
  int32_T c16_k_b0;
  int32_T c16_fmo_9;
  int32_T c16_f_a;
  int32_T c16_fmo_10;
  int32_T c16_f_b;
  int32_T c16_b_fmo_9;
  int32_T c16_l_a0;
  int32_T c16_b_fmo_10;
  int32_T c16_l_b0;
  int32_T c16_x_varargin_1;
  int32_T c16_k_a1;
  int32_T c16_y_varargin_1;
  int32_T c16_k_b1;
  int32_T c16_j_var1;
  int32_T c16_l_a1;
  int32_T c16_j_hfi;
  int32_T c16_l_b1;
  boolean_T c16_f_c;
  int32_T c16_ab_varargin_1;
  int32_T c16_i14;
  int32_T c16_bb_varargin_1;
  int32_T c16_k_var1;
  int32_T c16_k_hfi;
  int32_T c16_i15;
  real_T c16_g_t;
  int32_T c16_cb_varargin_1;
  int32_T c16_m_a0;
  int32_T c16_f_varargin_2;
  int32_T c16_m_b0;
  int32_T c16_fmo_11;
  int32_T c16_g_a;
  int32_T c16_fmo_12;
  int32_T c16_g_b;
  int32_T c16_b_fmo_11;
  int32_T c16_n_a0;
  int32_T c16_b_fmo_12;
  int32_T c16_n_b0;
  int32_T c16_db_varargin_1;
  int32_T c16_m_a1;
  int32_T c16_eb_varargin_1;
  int32_T c16_m_b1;
  int32_T c16_l_var1;
  int32_T c16_n_a1;
  int32_T c16_l_hfi;
  int32_T c16_n_b1;
  boolean_T c16_g_c;
  int32_T c16_fb_varargin_1;
  int32_T c16_i16;
  int32_T c16_gb_varargin_1;
  int32_T c16_m_var1;
  int32_T c16_m_hfi;
  int32_T c16_i17;
  real_T c16_h_t;
  int32_T c16_hb_varargin_1;
  int32_T c16_o_a0;
  int32_T c16_g_varargin_2;
  int32_T c16_o_b0;
  int32_T c16_fmo_13;
  int32_T c16_h_a;
  int32_T c16_fmo_14;
  int32_T c16_h_b;
  int32_T c16_b_fmo_13;
  int32_T c16_p_a0;
  int32_T c16_b_fmo_14;
  int32_T c16_p_b0;
  int32_T c16_ib_varargin_1;
  int32_T c16_o_a1;
  int32_T c16_jb_varargin_1;
  int32_T c16_o_b1;
  int32_T c16_n_var1;
  int32_T c16_p_a1;
  int32_T c16_n_hfi;
  int32_T c16_p_b1;
  boolean_T c16_h_c;
  int32_T c16_kb_varargin_1;
  int32_T c16_i18;
  int32_T c16_lb_varargin_1;
  int32_T c16_o_var1;
  int32_T c16_o_hfi;
  int32_T c16_i19;
  real_T c16_i_t;
  int32_T c16_mb_varargin_1;
  int32_T c16_q_a0;
  int32_T c16_h_varargin_2;
  int32_T c16_q_b0;
  int32_T c16_fmo_15;
  int32_T c16_i_a;
  int32_T c16_fmo_16;
  int32_T c16_i_b;
  int32_T c16_b_fmo_15;
  int32_T c16_r_a0;
  int32_T c16_b_fmo_16;
  int32_T c16_r_b0;
  int32_T c16_nb_varargin_1;
  int32_T c16_q_a1;
  int32_T c16_ob_varargin_1;
  int32_T c16_q_b1;
  int32_T c16_p_var1;
  int32_T c16_r_a1;
  int32_T c16_p_hfi;
  int32_T c16_r_b1;
  boolean_T c16_i_c;
  int32_T c16_pb_varargin_1;
  int32_T c16_i20;
  int32_T c16_qb_varargin_1;
  int32_T c16_q_var1;
  int32_T c16_q_hfi;
  int32_T c16_i21;
  real_T c16_j_t;
  int32_T c16_rb_varargin_1;
  int32_T c16_sb_varargin_1;
  int32_T c16_i_varargin_2;
  int32_T c16_tb_varargin_1;
  int32_T c16_fmo_17;
  int32_T c16_r_var1;
  int32_T c16_fmo_18;
  int32_T c16_r_hfi;
  int32_T c16_b_fmo_17;
  int32_T c16_b_y;
  int32_T c16_b_fmo_18;
  int32_T c16_ub_varargin_1;
  int32_T c16_vb_varargin_1;
  int32_T c16_s_var1;
  int32_T c16_s_hfi;
  int32_T c16_wb_varargin_1;
  int32_T c16_xb_varargin_1;
  int32_T c16_t_var1;
  int32_T c16_t_hfi;
  chartInstance->c16_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c16_covrtInstance, 0U, (real_T)
                    *chartInstance->c16_u);
  chartInstance->c16_sfEvent = CALL_EVENT;
  c16_b_u = *chartInstance->c16_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c16_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c16_emlrt_update_log_1(chartInstance, c16_b_u,
    chartInstance->c16_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c16_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c16_covrtInstance, 4U, 0, 1);
  c16_varargin_1 = c16_b_u;
  c16_b_varargin_1 = c16_varargin_1;
  c16_var1 = c16_b_varargin_1;
  c16_hfi = c16_var1;
  c16_c_u = c16_emlrt_update_log_1(chartInstance, c16_hfi,
    chartInstance->c16_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 0,
                     !chartInstance->c16_d_not_empty)) {
    for (c16_i = 0; c16_i < 5; c16_i++) {
      chartInstance->c16_d[c16_i] = 0;
    }

    c16_b_emlrt_update_log_2(chartInstance, chartInstance->c16_d,
      chartInstance->c16_emlrtLocationLoggingDataTables, 2);
    chartInstance->c16_d_not_empty = true;
  }

  for (c16_i1 = 0; c16_i1 < 4; c16_i1++) {
    c16_iv[c16_i1] = chartInstance->c16_d[c16_i1 + 1];
  }

  for (c16_i2 = 0; c16_i2 < 4; c16_i2++) {
    chartInstance->c16_d[c16_i2] = c16_iv[c16_i2];
  }

  c16_b_emlrt_update_log_3(chartInstance, *(int32_T (*)[4])&chartInstance->
    c16_d[0], chartInstance->c16_emlrtLocationLoggingDataTables, 3);
  chartInstance->c16_d[4] = c16_emlrt_update_log_1(chartInstance, c16_c_u,
    chartInstance->c16_emlrtLocationLoggingDataTables, 4);
  for (c16_i3 = 0; c16_i3 < 5; c16_i3++) {
    c16_t[c16_i3] = chartInstance->c16_d[c16_i3];
  }

  c16_b_emlrt_update_log_2(chartInstance, c16_t,
    chartInstance->c16_emlrtLocationLoggingDataTables, 5);
  c16_a0 = c16_t[0];
  c16_b0 = c16_t[1];
  c16_a = c16_a0;
  c16_b = c16_b0;
  c16_b_a0 = c16_a;
  c16_b_b0 = c16_b;
  c16_a1 = c16_b_a0;
  c16_b1 = c16_b_b0;
  c16_b_a1 = c16_a1;
  c16_b_b1 = c16_b1;
  c16_c = (c16_b_a1 > c16_b_b1);
  c16_i4 = c16_t[1] - c16_t[0];
  if (c16_i4 > 131071) {
    c16_i4 = 131071;
  } else {
    if (c16_i4 < -131072) {
      c16_i4 = -131072;
    }
  }

  c16_i5 = c16_t[0] - c16_t[1];
  if (c16_i5 > 131071) {
    c16_i5 = 131071;
  } else {
    if (c16_i5 < -131072) {
      c16_i5 = -131072;
    }
  }

  if (c16_t[0] < c16_t[1]) {
    c16_b_t = (real_T)(c16_i4 <= 1);
  } else if (c16_t[0] > c16_t[1]) {
    if (c16_i5 <= 1) {
      c16_b_t = 3.0;
    } else {
      c16_b_t = 0.0;
    }
  } else {
    c16_b_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 1,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 0U, c16_b_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_c, chartInstance->c16_emlrtLocationLoggingDataTables,
         6)))) {
    c16_c_varargin_1 = c16_t[0];
    c16_varargin_2 = c16_t[1];
    c16_fmo_1 = c16_c_varargin_1;
    c16_fmo_2 = c16_varargin_2;
    c16_b_fmo_1 = c16_emlrt_update_log_1(chartInstance, c16_fmo_1,
      chartInstance->c16_emlrtLocationLoggingDataTables, 34);
    c16_b_fmo_2 = c16_emlrt_update_log_1(chartInstance, c16_fmo_2,
      chartInstance->c16_emlrtLocationLoggingDataTables, 35);
    c16_d_varargin_1 = c16_b_fmo_1;
    c16_e_varargin_1 = c16_d_varargin_1;
    c16_b_var1 = c16_e_varargin_1;
    c16_b_hfi = c16_b_var1;
    c16_t[1] = c16_emlrt_update_log_1(chartInstance, c16_b_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 7);
    c16_f_varargin_1 = c16_b_fmo_2;
    c16_g_varargin_1 = c16_f_varargin_1;
    c16_c_var1 = c16_g_varargin_1;
    c16_c_hfi = c16_c_var1;
    c16_t[0] = c16_emlrt_update_log_1(chartInstance, c16_c_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 8);
  }

  c16_c_a0 = c16_t[1];
  c16_c_b0 = c16_t[2];
  c16_b_a = c16_c_a0;
  c16_b_b = c16_c_b0;
  c16_d_a0 = c16_b_a;
  c16_d_b0 = c16_b_b;
  c16_c_a1 = c16_d_a0;
  c16_c_b1 = c16_d_b0;
  c16_d_a1 = c16_c_a1;
  c16_d_b1 = c16_c_b1;
  c16_b_c = (c16_d_a1 > c16_d_b1);
  c16_i6 = c16_t[2] - c16_t[1];
  if (c16_i6 > 131071) {
    c16_i6 = 131071;
  } else {
    if (c16_i6 < -131072) {
      c16_i6 = -131072;
    }
  }

  c16_i7 = c16_t[1] - c16_t[2];
  if (c16_i7 > 131071) {
    c16_i7 = 131071;
  } else {
    if (c16_i7 < -131072) {
      c16_i7 = -131072;
    }
  }

  if (c16_t[1] < c16_t[2]) {
    c16_c_t = (real_T)(c16_i6 <= 1);
  } else if (c16_t[1] > c16_t[2]) {
    if (c16_i7 <= 1) {
      c16_c_t = 3.0;
    } else {
      c16_c_t = 0.0;
    }
  } else {
    c16_c_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 2,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 1U, c16_c_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_b_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 9)))) {
    c16_h_varargin_1 = c16_t[1];
    c16_b_varargin_2 = c16_t[2];
    c16_fmo_3 = c16_h_varargin_1;
    c16_fmo_4 = c16_b_varargin_2;
    c16_b_fmo_3 = c16_emlrt_update_log_1(chartInstance, c16_fmo_3,
      chartInstance->c16_emlrtLocationLoggingDataTables, 36);
    c16_b_fmo_4 = c16_emlrt_update_log_1(chartInstance, c16_fmo_4,
      chartInstance->c16_emlrtLocationLoggingDataTables, 37);
    c16_i_varargin_1 = c16_b_fmo_3;
    c16_j_varargin_1 = c16_i_varargin_1;
    c16_d_var1 = c16_j_varargin_1;
    c16_d_hfi = c16_d_var1;
    c16_t[2] = c16_emlrt_update_log_1(chartInstance, c16_d_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 10);
    c16_k_varargin_1 = c16_b_fmo_4;
    c16_l_varargin_1 = c16_k_varargin_1;
    c16_e_var1 = c16_l_varargin_1;
    c16_e_hfi = c16_e_var1;
    c16_t[1] = c16_emlrt_update_log_1(chartInstance, c16_e_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 11);
  }

  c16_e_a0 = c16_t[2];
  c16_e_b0 = c16_t[3];
  c16_c_a = c16_e_a0;
  c16_c_b = c16_e_b0;
  c16_f_a0 = c16_c_a;
  c16_f_b0 = c16_c_b;
  c16_e_a1 = c16_f_a0;
  c16_e_b1 = c16_f_b0;
  c16_f_a1 = c16_e_a1;
  c16_f_b1 = c16_e_b1;
  c16_c_c = (c16_f_a1 > c16_f_b1);
  c16_i8 = c16_t[3] - c16_t[2];
  if (c16_i8 > 131071) {
    c16_i8 = 131071;
  } else {
    if (c16_i8 < -131072) {
      c16_i8 = -131072;
    }
  }

  c16_i9 = c16_t[2] - c16_t[3];
  if (c16_i9 > 131071) {
    c16_i9 = 131071;
  } else {
    if (c16_i9 < -131072) {
      c16_i9 = -131072;
    }
  }

  if (c16_t[2] < c16_t[3]) {
    c16_d_t = (real_T)(c16_i8 <= 1);
  } else if (c16_t[2] > c16_t[3]) {
    if (c16_i9 <= 1) {
      c16_d_t = 3.0;
    } else {
      c16_d_t = 0.0;
    }
  } else {
    c16_d_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 2U, c16_d_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_c_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 12)))) {
    c16_m_varargin_1 = c16_t[2];
    c16_c_varargin_2 = c16_t[3];
    c16_fmo_5 = c16_m_varargin_1;
    c16_fmo_6 = c16_c_varargin_2;
    c16_b_fmo_5 = c16_emlrt_update_log_1(chartInstance, c16_fmo_5,
      chartInstance->c16_emlrtLocationLoggingDataTables, 38);
    c16_b_fmo_6 = c16_emlrt_update_log_1(chartInstance, c16_fmo_6,
      chartInstance->c16_emlrtLocationLoggingDataTables, 39);
    c16_n_varargin_1 = c16_b_fmo_5;
    c16_o_varargin_1 = c16_n_varargin_1;
    c16_f_var1 = c16_o_varargin_1;
    c16_f_hfi = c16_f_var1;
    c16_t[3] = c16_emlrt_update_log_1(chartInstance, c16_f_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 13);
    c16_p_varargin_1 = c16_b_fmo_6;
    c16_q_varargin_1 = c16_p_varargin_1;
    c16_g_var1 = c16_q_varargin_1;
    c16_g_hfi = c16_g_var1;
    c16_t[2] = c16_emlrt_update_log_1(chartInstance, c16_g_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 14);
  }

  c16_g_a0 = c16_t[3];
  c16_g_b0 = c16_t[4];
  c16_d_a = c16_g_a0;
  c16_d_b = c16_g_b0;
  c16_h_a0 = c16_d_a;
  c16_h_b0 = c16_d_b;
  c16_g_a1 = c16_h_a0;
  c16_g_b1 = c16_h_b0;
  c16_h_a1 = c16_g_a1;
  c16_h_b1 = c16_g_b1;
  c16_d_c = (c16_h_a1 > c16_h_b1);
  c16_i10 = c16_t[4] - c16_t[3];
  if (c16_i10 > 131071) {
    c16_i10 = 131071;
  } else {
    if (c16_i10 < -131072) {
      c16_i10 = -131072;
    }
  }

  c16_i11 = c16_t[3] - c16_t[4];
  if (c16_i11 > 131071) {
    c16_i11 = 131071;
  } else {
    if (c16_i11 < -131072) {
      c16_i11 = -131072;
    }
  }

  if (c16_t[3] < c16_t[4]) {
    c16_e_t = (real_T)(c16_i10 <= 1);
  } else if (c16_t[3] > c16_t[4]) {
    if (c16_i11 <= 1) {
      c16_e_t = 3.0;
    } else {
      c16_e_t = 0.0;
    }
  } else {
    c16_e_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 4,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 3U, c16_e_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_d_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 15)))) {
    c16_r_varargin_1 = c16_t[3];
    c16_d_varargin_2 = c16_t[4];
    c16_fmo_7 = c16_r_varargin_1;
    c16_fmo_8 = c16_d_varargin_2;
    c16_b_fmo_7 = c16_emlrt_update_log_1(chartInstance, c16_fmo_7,
      chartInstance->c16_emlrtLocationLoggingDataTables, 40);
    c16_b_fmo_8 = c16_emlrt_update_log_1(chartInstance, c16_fmo_8,
      chartInstance->c16_emlrtLocationLoggingDataTables, 41);
    c16_s_varargin_1 = c16_b_fmo_7;
    c16_t_varargin_1 = c16_s_varargin_1;
    c16_h_var1 = c16_t_varargin_1;
    c16_h_hfi = c16_h_var1;
    c16_emlrt_update_log_1(chartInstance, c16_h_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 16);
    c16_u_varargin_1 = c16_b_fmo_8;
    c16_v_varargin_1 = c16_u_varargin_1;
    c16_i_var1 = c16_v_varargin_1;
    c16_i_hfi = c16_i_var1;
    c16_t[3] = c16_emlrt_update_log_1(chartInstance, c16_i_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 17);
  }

  c16_i_a0 = c16_t[0];
  c16_i_b0 = c16_t[1];
  c16_e_a = c16_i_a0;
  c16_e_b = c16_i_b0;
  c16_j_a0 = c16_e_a;
  c16_j_b0 = c16_e_b;
  c16_i_a1 = c16_j_a0;
  c16_i_b1 = c16_j_b0;
  c16_j_a1 = c16_i_a1;
  c16_j_b1 = c16_i_b1;
  c16_e_c = (c16_j_a1 > c16_j_b1);
  c16_i12 = c16_t[1] - c16_t[0];
  if (c16_i12 > 131071) {
    c16_i12 = 131071;
  } else {
    if (c16_i12 < -131072) {
      c16_i12 = -131072;
    }
  }

  c16_i13 = c16_t[0] - c16_t[1];
  if (c16_i13 > 131071) {
    c16_i13 = 131071;
  } else {
    if (c16_i13 < -131072) {
      c16_i13 = -131072;
    }
  }

  if (c16_t[0] < c16_t[1]) {
    c16_f_t = (real_T)(c16_i12 <= 1);
  } else if (c16_t[0] > c16_t[1]) {
    if (c16_i13 <= 1) {
      c16_f_t = 3.0;
    } else {
      c16_f_t = 0.0;
    }
  } else {
    c16_f_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 5,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 4U, c16_f_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_e_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 18)))) {
    c16_w_varargin_1 = c16_t[0];
    c16_e_varargin_2 = c16_t[1];
    c16_fmo_9 = c16_w_varargin_1;
    c16_fmo_10 = c16_e_varargin_2;
    c16_b_fmo_9 = c16_emlrt_update_log_1(chartInstance, c16_fmo_9,
      chartInstance->c16_emlrtLocationLoggingDataTables, 42);
    c16_b_fmo_10 = c16_emlrt_update_log_1(chartInstance, c16_fmo_10,
      chartInstance->c16_emlrtLocationLoggingDataTables, 43);
    c16_x_varargin_1 = c16_b_fmo_9;
    c16_y_varargin_1 = c16_x_varargin_1;
    c16_j_var1 = c16_y_varargin_1;
    c16_j_hfi = c16_j_var1;
    c16_t[1] = c16_emlrt_update_log_1(chartInstance, c16_j_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 19);
    c16_ab_varargin_1 = c16_b_fmo_10;
    c16_bb_varargin_1 = c16_ab_varargin_1;
    c16_k_var1 = c16_bb_varargin_1;
    c16_k_hfi = c16_k_var1;
    c16_t[0] = c16_emlrt_update_log_1(chartInstance, c16_k_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 20);
  }

  c16_k_a0 = c16_t[1];
  c16_k_b0 = c16_t[2];
  c16_f_a = c16_k_a0;
  c16_f_b = c16_k_b0;
  c16_l_a0 = c16_f_a;
  c16_l_b0 = c16_f_b;
  c16_k_a1 = c16_l_a0;
  c16_k_b1 = c16_l_b0;
  c16_l_a1 = c16_k_a1;
  c16_l_b1 = c16_k_b1;
  c16_f_c = (c16_l_a1 > c16_l_b1);
  c16_i14 = c16_t[2] - c16_t[1];
  if (c16_i14 > 131071) {
    c16_i14 = 131071;
  } else {
    if (c16_i14 < -131072) {
      c16_i14 = -131072;
    }
  }

  c16_i15 = c16_t[1] - c16_t[2];
  if (c16_i15 > 131071) {
    c16_i15 = 131071;
  } else {
    if (c16_i15 < -131072) {
      c16_i15 = -131072;
    }
  }

  if (c16_t[1] < c16_t[2]) {
    c16_g_t = (real_T)(c16_i14 <= 1);
  } else if (c16_t[1] > c16_t[2]) {
    if (c16_i15 <= 1) {
      c16_g_t = 3.0;
    } else {
      c16_g_t = 0.0;
    }
  } else {
    c16_g_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 6,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 5U, c16_g_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_f_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 21)))) {
    c16_cb_varargin_1 = c16_t[1];
    c16_f_varargin_2 = c16_t[2];
    c16_fmo_11 = c16_cb_varargin_1;
    c16_fmo_12 = c16_f_varargin_2;
    c16_b_fmo_11 = c16_emlrt_update_log_1(chartInstance, c16_fmo_11,
      chartInstance->c16_emlrtLocationLoggingDataTables, 44);
    c16_b_fmo_12 = c16_emlrt_update_log_1(chartInstance, c16_fmo_12,
      chartInstance->c16_emlrtLocationLoggingDataTables, 45);
    c16_db_varargin_1 = c16_b_fmo_11;
    c16_eb_varargin_1 = c16_db_varargin_1;
    c16_l_var1 = c16_eb_varargin_1;
    c16_l_hfi = c16_l_var1;
    c16_t[2] = c16_emlrt_update_log_1(chartInstance, c16_l_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 22);
    c16_fb_varargin_1 = c16_b_fmo_12;
    c16_gb_varargin_1 = c16_fb_varargin_1;
    c16_m_var1 = c16_gb_varargin_1;
    c16_m_hfi = c16_m_var1;
    c16_t[1] = c16_emlrt_update_log_1(chartInstance, c16_m_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 23);
  }

  c16_m_a0 = c16_t[2];
  c16_m_b0 = c16_t[3];
  c16_g_a = c16_m_a0;
  c16_g_b = c16_m_b0;
  c16_n_a0 = c16_g_a;
  c16_n_b0 = c16_g_b;
  c16_m_a1 = c16_n_a0;
  c16_m_b1 = c16_n_b0;
  c16_n_a1 = c16_m_a1;
  c16_n_b1 = c16_m_b1;
  c16_g_c = (c16_n_a1 > c16_n_b1);
  c16_i16 = c16_t[3] - c16_t[2];
  if (c16_i16 > 131071) {
    c16_i16 = 131071;
  } else {
    if (c16_i16 < -131072) {
      c16_i16 = -131072;
    }
  }

  c16_i17 = c16_t[2] - c16_t[3];
  if (c16_i17 > 131071) {
    c16_i17 = 131071;
  } else {
    if (c16_i17 < -131072) {
      c16_i17 = -131072;
    }
  }

  if (c16_t[2] < c16_t[3]) {
    c16_h_t = (real_T)(c16_i16 <= 1);
  } else if (c16_t[2] > c16_t[3]) {
    if (c16_i17 <= 1) {
      c16_h_t = 3.0;
    } else {
      c16_h_t = 0.0;
    }
  } else {
    c16_h_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 7,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 6U, c16_h_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_g_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 24)))) {
    c16_hb_varargin_1 = c16_t[2];
    c16_g_varargin_2 = c16_t[3];
    c16_fmo_13 = c16_hb_varargin_1;
    c16_fmo_14 = c16_g_varargin_2;
    c16_b_fmo_13 = c16_emlrt_update_log_1(chartInstance, c16_fmo_13,
      chartInstance->c16_emlrtLocationLoggingDataTables, 46);
    c16_b_fmo_14 = c16_emlrt_update_log_1(chartInstance, c16_fmo_14,
      chartInstance->c16_emlrtLocationLoggingDataTables, 47);
    c16_ib_varargin_1 = c16_b_fmo_13;
    c16_jb_varargin_1 = c16_ib_varargin_1;
    c16_n_var1 = c16_jb_varargin_1;
    c16_n_hfi = c16_n_var1;
    c16_emlrt_update_log_1(chartInstance, c16_n_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 25);
    c16_kb_varargin_1 = c16_b_fmo_14;
    c16_lb_varargin_1 = c16_kb_varargin_1;
    c16_o_var1 = c16_lb_varargin_1;
    c16_o_hfi = c16_o_var1;
    c16_t[2] = c16_emlrt_update_log_1(chartInstance, c16_o_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 26);
  }

  c16_o_a0 = c16_t[0];
  c16_o_b0 = c16_t[1];
  c16_h_a = c16_o_a0;
  c16_h_b = c16_o_b0;
  c16_p_a0 = c16_h_a;
  c16_p_b0 = c16_h_b;
  c16_o_a1 = c16_p_a0;
  c16_o_b1 = c16_p_b0;
  c16_p_a1 = c16_o_a1;
  c16_p_b1 = c16_o_b1;
  c16_h_c = (c16_p_a1 > c16_p_b1);
  c16_i18 = c16_t[1] - c16_t[0];
  if (c16_i18 > 131071) {
    c16_i18 = 131071;
  } else {
    if (c16_i18 < -131072) {
      c16_i18 = -131072;
    }
  }

  c16_i19 = c16_t[0] - c16_t[1];
  if (c16_i19 > 131071) {
    c16_i19 = 131071;
  } else {
    if (c16_i19 < -131072) {
      c16_i19 = -131072;
    }
  }

  if (c16_t[0] < c16_t[1]) {
    c16_i_t = (real_T)(c16_i18 <= 1);
  } else if (c16_t[0] > c16_t[1]) {
    if (c16_i19 <= 1) {
      c16_i_t = 3.0;
    } else {
      c16_i_t = 0.0;
    }
  } else {
    c16_i_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 8,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 7U, c16_i_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_h_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 27)))) {
    c16_mb_varargin_1 = c16_t[0];
    c16_h_varargin_2 = c16_t[1];
    c16_fmo_15 = c16_mb_varargin_1;
    c16_fmo_16 = c16_h_varargin_2;
    c16_b_fmo_15 = c16_emlrt_update_log_1(chartInstance, c16_fmo_15,
      chartInstance->c16_emlrtLocationLoggingDataTables, 48);
    c16_b_fmo_16 = c16_emlrt_update_log_1(chartInstance, c16_fmo_16,
      chartInstance->c16_emlrtLocationLoggingDataTables, 49);
    c16_nb_varargin_1 = c16_b_fmo_15;
    c16_ob_varargin_1 = c16_nb_varargin_1;
    c16_p_var1 = c16_ob_varargin_1;
    c16_p_hfi = c16_p_var1;
    c16_t[1] = c16_emlrt_update_log_1(chartInstance, c16_p_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 28);
    c16_pb_varargin_1 = c16_b_fmo_16;
    c16_qb_varargin_1 = c16_pb_varargin_1;
    c16_q_var1 = c16_qb_varargin_1;
    c16_q_hfi = c16_q_var1;
    c16_emlrt_update_log_1(chartInstance, c16_q_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 29);
  }

  c16_q_a0 = c16_t[1];
  c16_q_b0 = c16_t[2];
  c16_i_a = c16_q_a0;
  c16_i_b = c16_q_b0;
  c16_r_a0 = c16_i_a;
  c16_r_b0 = c16_i_b;
  c16_q_a1 = c16_r_a0;
  c16_q_b1 = c16_r_b0;
  c16_r_a1 = c16_q_a1;
  c16_r_b1 = c16_q_b1;
  c16_i_c = (c16_r_a1 > c16_r_b1);
  c16_i20 = c16_t[2] - c16_t[1];
  if (c16_i20 > 131071) {
    c16_i20 = 131071;
  } else {
    if (c16_i20 < -131072) {
      c16_i20 = -131072;
    }
  }

  c16_i21 = c16_t[1] - c16_t[2];
  if (c16_i21 > 131071) {
    c16_i21 = 131071;
  } else {
    if (c16_i21 < -131072) {
      c16_i21 = -131072;
    }
  }

  if (c16_t[1] < c16_t[2]) {
    c16_j_t = (real_T)(c16_i20 <= 1);
  } else if (c16_t[1] > c16_t[2]) {
    if (c16_i21 <= 1) {
      c16_j_t = 3.0;
    } else {
      c16_j_t = 0.0;
    }
  } else {
    c16_j_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c16_covrtInstance, 4U, 0, 9,
                     covrtRelationalopUpdateFcn(chartInstance->c16_covrtInstance,
        4U, 0U, 8U, c16_j_t, 0.0, -2, 4U, (int32_T)c16_emlrt_update_log_4
        (chartInstance, c16_i_c,
         chartInstance->c16_emlrtLocationLoggingDataTables, 30)))) {
    c16_rb_varargin_1 = c16_t[1];
    c16_i_varargin_2 = c16_t[2];
    c16_fmo_17 = c16_rb_varargin_1;
    c16_fmo_18 = c16_i_varargin_2;
    c16_b_fmo_17 = c16_emlrt_update_log_1(chartInstance, c16_fmo_17,
      chartInstance->c16_emlrtLocationLoggingDataTables, 50);
    c16_b_fmo_18 = c16_emlrt_update_log_1(chartInstance, c16_fmo_18,
      chartInstance->c16_emlrtLocationLoggingDataTables, 51);
    c16_ub_varargin_1 = c16_b_fmo_17;
    c16_vb_varargin_1 = c16_ub_varargin_1;
    c16_s_var1 = c16_vb_varargin_1;
    c16_s_hfi = c16_s_var1;
    c16_t[2] = c16_emlrt_update_log_1(chartInstance, c16_s_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 31);
    c16_wb_varargin_1 = c16_b_fmo_18;
    c16_xb_varargin_1 = c16_wb_varargin_1;
    c16_t_var1 = c16_xb_varargin_1;
    c16_t_hfi = c16_t_var1;
    c16_emlrt_update_log_1(chartInstance, c16_t_hfi,
      chartInstance->c16_emlrtLocationLoggingDataTables, 32);
  }

  c16_sb_varargin_1 = c16_t[2];
  c16_tb_varargin_1 = c16_sb_varargin_1;
  c16_r_var1 = c16_tb_varargin_1;
  c16_r_hfi = c16_r_var1;
  c16_b_y = c16_emlrt_update_log_1(chartInstance, c16_r_hfi,
    chartInstance->c16_emlrtLocationLoggingDataTables, 33);
  *chartInstance->c16_y = c16_b_y;
  c16_do_animation_call_c16_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c16_covrtInstance, 1U, (real_T)
                    *chartInstance->c16_y);
}

static void mdl_start_c16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c16_decisionTxtStartIdx = 0U;
  static const uint32_T c16_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c16_chart_data_browse_helper);
  chartInstance->c16_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c16_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c16_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c16_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c16_decisionTxtStartIdx, &c16_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c16_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c16_covrtInstance, "", 4U, 0U, 2U, 0U, 10U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 1633);
  covrtEmlFcnInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 1U, "get_fimath",
                     1636, -1, 1890);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 0U, 116, 130, -1,
                    178);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 1U, 350, 364, -1,
                    483);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 2U, 484, 498, -1,
                    617);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 3U, 618, 632, -1,
                    751);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 4U, 752, 766, -1,
                    885);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 5U, 895, 909, -1,
                    1030);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 6U, 1031, 1045, -1,
                    1168);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 7U, 1169, 1183, -1,
                    1306);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 8U, 1316, 1330, -1,
                    1453);
  covrtEmlIfInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 9U, 1454, 1468, -1,
                    1591);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 0U, 353,
    364, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 1U, 487,
    498, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 2U, 621,
    632, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 3U, 755,
    766, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 4U, 898,
    909, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 5U, 1034,
    1045, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 6U, 1172,
    1183, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 7U, 1319,
    1330, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c16_covrtInstance, 4U, 0U, 8U, 1457,
    1468, -2, 4U);
}

static void initSimStructsc16_zeabus_hydrophone_concrete
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c16_emlrt_update_log_1
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c16_in,
   emlrtLocationLoggingDataType c16_table[], int32_T c16_index)
{
  boolean_T c16_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c16_b_table;
  real_T c16_b_d;
  int32_T c16_i;
  int32_T c16_localMin;
  real_T c16_d1;
  int32_T c16_i1;
  int32_T c16_localMax;
  emlrtLocationLoggingHistogramType *c16_histTable;
  real_T c16_inDouble;
  real_T c16_significand;
  int32_T c16_exponent;
  (void)chartInstance;
  c16_isLoggingEnabledHere = (c16_index >= 0);
  if (c16_isLoggingEnabledHere) {
    c16_b_table = (emlrtLocationLoggingDataType *)&c16_table[c16_index];
    c16_b_d = muDoubleScalarFloor(c16_b_table[0U].SimMin * 131072.0);
    if (c16_b_d < 131072.0) {
      if (c16_b_d >= -131072.0) {
        c16_i = (int32_T)c16_b_d;
      } else {
        c16_i = -131072;
      }
    } else if (c16_b_d >= 131072.0) {
      c16_i = 131071;
    } else {
      c16_i = 0;
    }

    c16_localMin = c16_i;
    c16_d1 = muDoubleScalarFloor(c16_b_table[0U].SimMax * 131072.0);
    if (c16_d1 < 131072.0) {
      if (c16_d1 >= -131072.0) {
        c16_i1 = (int32_T)c16_d1;
      } else {
        c16_i1 = -131072;
      }
    } else if (c16_d1 >= 131072.0) {
      c16_i1 = 131071;
    } else {
      c16_i1 = 0;
    }

    c16_localMax = c16_i1;
    c16_histTable = c16_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c16_in < c16_localMin) {
      c16_localMin = c16_in;
    }

    if (c16_in > c16_localMax) {
      c16_localMax = c16_in;
    }

    /* Histogram logging. */
    c16_inDouble = (real_T)c16_in * 7.62939453125E-6;
    c16_histTable->TotalNumberOfValues++;
    if (c16_inDouble == 0.0) {
      c16_histTable->NumberOfZeros++;
    } else {
      c16_histTable->SimSum += c16_inDouble;
      if ((!muDoubleScalarIsInf(c16_inDouble)) && (!muDoubleScalarIsNaN
           (c16_inDouble))) {
        c16_significand = frexp(c16_inDouble, &c16_exponent);
        if (c16_exponent > 128) {
          c16_exponent = 128;
        }

        if (c16_exponent < -127) {
          c16_exponent = -127;
        }

        if (c16_significand < 0.0) {
          c16_histTable->NumberOfNegativeValues++;
          c16_histTable->HistogramOfNegativeValues[127 + c16_exponent]++;
        } else {
          c16_histTable->NumberOfPositiveValues++;
          c16_histTable->HistogramOfPositiveValues[127 + c16_exponent]++;
        }
      }
    }

    c16_b_table[0U].SimMin = (real_T)c16_localMin * 7.62939453125E-6;
    c16_b_table[0U].SimMax = (real_T)c16_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c16_in & 131071U) != 0U) {
      c16_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c16_in;
}

static void c16_emlrt_update_log_2
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[5], emlrtLocationLoggingDataType c16_table[], int32_T c16_index,
   int32_T c16_out[5])
{
  int32_T c16_i;
  for (c16_i = 0; c16_i < 5; c16_i++) {
    c16_out[c16_i] = c16_in[c16_i];
  }

  c16_b_emlrt_update_log_2(chartInstance, c16_out, c16_table, c16_index);
}

static void c16_emlrt_update_log_3
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[4], emlrtLocationLoggingDataType c16_table[], int32_T c16_index,
   int32_T c16_out[4])
{
  int32_T c16_i;
  for (c16_i = 0; c16_i < 4; c16_i++) {
    c16_out[c16_i] = c16_in[c16_i];
  }

  c16_b_emlrt_update_log_3(chartInstance, c16_out, c16_table, c16_index);
}

static boolean_T c16_emlrt_update_log_4
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c16_in, emlrtLocationLoggingDataType c16_table[], int32_T c16_index)
{
  boolean_T c16_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c16_b_table;
  boolean_T c16_localMin;
  boolean_T c16_localMax;
  emlrtLocationLoggingHistogramType *c16_histTable;
  real_T c16_inDouble;
  real_T c16_significand;
  int32_T c16_exponent;
  (void)chartInstance;
  c16_isLoggingEnabledHere = (c16_index >= 0);
  if (c16_isLoggingEnabledHere) {
    c16_b_table = (emlrtLocationLoggingDataType *)&c16_table[c16_index];
    c16_localMin = (c16_b_table[0U].SimMin > 0.0);
    c16_localMax = (c16_b_table[0U].SimMax > 0.0);
    c16_histTable = c16_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c16_in < (int32_T)c16_localMin) {
      c16_localMin = c16_in;
    }

    if ((int32_T)c16_in > (int32_T)c16_localMax) {
      c16_localMax = c16_in;
    }

    /* Histogram logging. */
    c16_inDouble = (real_T)c16_in;
    c16_histTable->TotalNumberOfValues++;
    if (c16_inDouble == 0.0) {
      c16_histTable->NumberOfZeros++;
    } else {
      c16_histTable->SimSum += c16_inDouble;
      if ((!muDoubleScalarIsInf(c16_inDouble)) && (!muDoubleScalarIsNaN
           (c16_inDouble))) {
        c16_significand = frexp(c16_inDouble, &c16_exponent);
        if (c16_exponent > 128) {
          c16_exponent = 128;
        }

        if (c16_exponent < -127) {
          c16_exponent = -127;
        }

        if (c16_significand < 0.0) {
          c16_histTable->NumberOfNegativeValues++;
          c16_histTable->HistogramOfNegativeValues[127 + c16_exponent]++;
        } else {
          c16_histTable->NumberOfPositiveValues++;
          c16_histTable->HistogramOfPositiveValues[127 + c16_exponent]++;
        }
      }
    }

    c16_b_table[0U].SimMin = (real_T)c16_localMin;
    c16_b_table[0U].SimMax = (real_T)c16_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c16_in;
}

static void c16_emlrtInitVarDataTables
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c16_dataTables[52],
   emlrtLocationLoggingHistogramType c16_histTables[52])
{
  int32_T c16_i;
  int32_T c16_iH;
  (void)chartInstance;
  for (c16_i = 0; c16_i < 52; c16_i++) {
    c16_dataTables[c16_i].SimMin = rtInf;
    c16_dataTables[c16_i].SimMax = rtMinusInf;
    c16_dataTables[c16_i].OverflowWraps = 0;
    c16_dataTables[c16_i].Saturations = 0;
    c16_dataTables[c16_i].IsAlwaysInteger = true;
    c16_dataTables[c16_i].HistogramTable = &c16_histTables[c16_i];
    c16_histTables[c16_i].NumberOfZeros = 0.0;
    c16_histTables[c16_i].NumberOfPositiveValues = 0.0;
    c16_histTables[c16_i].NumberOfNegativeValues = 0.0;
    c16_histTables[c16_i].TotalNumberOfValues = 0.0;
    c16_histTables[c16_i].SimSum = 0.0;
    for (c16_iH = 0; c16_iH < 256; c16_iH++) {
      c16_histTables[c16_i].HistogramOfPositiveValues[c16_iH] = 0.0;
      c16_histTables[c16_i].HistogramOfNegativeValues[c16_iH] = 0.0;
    }
  }
}

const mxArray *sf_c16_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c16_nameCaptureInfo = NULL;
  c16_nameCaptureInfo = NULL;
  sf_mex_assign(&c16_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c16_nameCaptureInfo;
}

static int32_T c16_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_y, const char_T *c16_identifier)
{
  int32_T c16_c_y;
  emlrtMsgIdentifier c16_thisId;
  c16_thisId.fIdentifier = (const char *)c16_identifier;
  c16_thisId.fParent = NULL;
  c16_thisId.bParentIsCell = false;
  c16_c_y = c16_b_emlrt_marshallIn(chartInstance, c16_sp, sf_mex_dup(c16_b_y),
    &c16_thisId);
  sf_mex_destroy(&c16_b_y);
  return c16_c_y;
}

static int32_T c16_b_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_u, const emlrtMsgIdentifier
   *c16_parentId)
{
  int32_T c16_b_y;
  const mxArray *c16_mxFi = NULL;
  const mxArray *c16_mxInt = NULL;
  int32_T c16_i;
  (void)chartInstance;
  sf_mex_check_fi(c16_parentId, c16_b_u, false, 0U, NULL, c16_eml_mx,
                  c16_b_eml_mx);
  sf_mex_assign(&c16_mxFi, sf_mex_dup(c16_b_u), false);
  sf_mex_assign(&c16_mxInt, sf_mex_call(c16_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c16_mxFi)), false);
  sf_mex_import(c16_parentId, sf_mex_dup(c16_mxInt), &c16_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c16_mxFi);
  sf_mex_destroy(&c16_mxInt);
  c16_b_y = c16_i;
  sf_mex_destroy(&c16_mxFi);
  sf_mex_destroy(&c16_b_u);
  return c16_b_y;
}

static void c16_c_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_d, const char_T *c16_identifier,
   boolean_T *c16_svPtr, int32_T c16_b_y[5])
{
  emlrtMsgIdentifier c16_thisId;
  c16_thisId.fIdentifier = (const char *)c16_identifier;
  c16_thisId.fParent = NULL;
  c16_thisId.bParentIsCell = false;
  c16_d_emlrt_marshallIn(chartInstance, c16_sp, sf_mex_dup(c16_b_d), &c16_thisId,
    c16_svPtr, c16_b_y);
  sf_mex_destroy(&c16_b_d);
}

static void c16_d_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c16_sp, const mxArray *c16_b_u, const emlrtMsgIdentifier
   *c16_parentId, boolean_T *c16_svPtr, int32_T c16_b_y[5])
{
  int32_T c16_i;
  uint32_T c16_uv[2];
  const mxArray *c16_mxFi = NULL;
  const mxArray *c16_mxInt = NULL;
  int32_T c16_iv[5];
  int32_T c16_i1;
  (void)chartInstance;
  for (c16_i = 0; c16_i < 2; c16_i++) {
    c16_uv[c16_i] = 1U + ((uint32_T)c16_i << 2);
  }

  if (mxIsEmpty(c16_b_u)) {
    *c16_svPtr = false;
  } else {
    *c16_svPtr = true;
    sf_mex_check_fi(c16_parentId, c16_b_u, false, 2U, c16_uv, c16_eml_mx,
                    c16_b_eml_mx);
    sf_mex_assign(&c16_mxFi, sf_mex_dup(c16_b_u), false);
    sf_mex_assign(&c16_mxInt, sf_mex_call(c16_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c16_mxFi)), false);
    sf_mex_import(c16_parentId, sf_mex_dup(c16_mxInt), c16_iv, 1, 6, 0U, 1, 0U,
                  2, 1, 5);
    sf_mex_destroy(&c16_mxFi);
    sf_mex_destroy(&c16_mxInt);
    for (c16_i1 = 0; c16_i1 < 5; c16_i1++) {
      c16_b_y[c16_i1] = c16_iv[c16_i1];
    }
  }

  sf_mex_destroy(&c16_mxFi);
  sf_mex_destroy(&c16_b_u);
}

static uint8_T c16_e_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c16_b_is_active_c16_zeabus_hydrophone_concrete, const char_T *c16_identifier)
{
  uint8_T c16_b_y;
  emlrtMsgIdentifier c16_thisId;
  c16_thisId.fIdentifier = (const char *)c16_identifier;
  c16_thisId.fParent = NULL;
  c16_thisId.bParentIsCell = false;
  c16_b_y = c16_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c16_b_is_active_c16_zeabus_hydrophone_concrete), &c16_thisId);
  sf_mex_destroy(&c16_b_is_active_c16_zeabus_hydrophone_concrete);
  return c16_b_y;
}

static uint8_T c16_f_emlrt_marshallIn
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c16_b_u, const emlrtMsgIdentifier *c16_parentId)
{
  uint8_T c16_b_y;
  uint8_T c16_c_u;
  (void)chartInstance;
  sf_mex_import(c16_parentId, sf_mex_dup(c16_b_u), &c16_c_u, 1, 3, 0U, 0, 0U, 0);
  c16_b_y = c16_c_u;
  sf_mex_destroy(&c16_b_u);
  return c16_b_y;
}

static const mxArray *c16_chart_data_browse_helper
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_ssIdNumber)
{
  const mxArray *c16_mxData = NULL;
  int32_T c16_i;
  int32_T c16_i1;
  real_T c16_b_d;
  real_T c16_d1;
  c16_mxData = NULL;
  switch (c16_ssIdNumber) {
   case 4U:
    c16_i = *chartInstance->c16_u;
    c16_b_d = (real_T)c16_i * 7.62939453125E-6;
    sf_mex_assign(&c16_mxData, sf_mex_create("mxData", &c16_b_d, 0, 0U, 0U, 0U,
      0), false);
    break;

   case 5U:
    c16_i1 = *chartInstance->c16_y;
    c16_d1 = (real_T)c16_i1 * 7.62939453125E-6;
    sf_mex_assign(&c16_mxData, sf_mex_create("mxData", &c16_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c16_mxData;
}

static void c16_b_emlrt_update_log_2
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[5], emlrtLocationLoggingDataType c16_table[], int32_T c16_index)
{
  boolean_T c16_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c16_b_table;
  real_T c16_b_d;
  int32_T c16_i;
  int32_T c16_localMin;
  real_T c16_d1;
  int32_T c16_i1;
  int32_T c16_localMax;
  emlrtLocationLoggingHistogramType *c16_histTable;
  int32_T c16_b_i;
  int32_T c16_c_i;
  real_T c16_inDouble;
  real_T c16_significand;
  int32_T c16_exponent;
  (void)chartInstance;
  c16_isLoggingEnabledHere = (c16_index >= 0);
  if (c16_isLoggingEnabledHere) {
    c16_b_table = (emlrtLocationLoggingDataType *)&c16_table[c16_index];
    c16_b_d = muDoubleScalarFloor(c16_b_table[0U].SimMin * 131072.0);
    if (c16_b_d < 131072.0) {
      if (c16_b_d >= -131072.0) {
        c16_i = (int32_T)c16_b_d;
      } else {
        c16_i = -131072;
      }
    } else if (c16_b_d >= 131072.0) {
      c16_i = 131071;
    } else {
      c16_i = 0;
    }

    c16_localMin = c16_i;
    c16_d1 = muDoubleScalarFloor(c16_b_table[0U].SimMax * 131072.0);
    if (c16_d1 < 131072.0) {
      if (c16_d1 >= -131072.0) {
        c16_i1 = (int32_T)c16_d1;
      } else {
        c16_i1 = -131072;
      }
    } else if (c16_d1 >= 131072.0) {
      c16_i1 = 131071;
    } else {
      c16_i1 = 0;
    }

    c16_localMax = c16_i1;
    c16_histTable = c16_b_table[0U].HistogramTable;
    for (c16_b_i = 0; c16_b_i < 5; c16_b_i++) {
      /* Simulation Min-Max logging. */
      if (c16_in[c16_b_i] < c16_localMin) {
        c16_localMin = c16_in[c16_b_i];
      }

      if (c16_in[c16_b_i] > c16_localMax) {
        c16_localMax = c16_in[c16_b_i];
      }

      /* Histogram logging. */
      c16_inDouble = (real_T)c16_in[c16_b_i] * 7.62939453125E-6;
      c16_histTable->TotalNumberOfValues++;
      if (c16_inDouble == 0.0) {
        c16_histTable->NumberOfZeros++;
      } else {
        c16_histTable->SimSum += c16_inDouble;
        if ((!muDoubleScalarIsInf(c16_inDouble)) && (!muDoubleScalarIsNaN
             (c16_inDouble))) {
          c16_significand = frexp(c16_inDouble, &c16_exponent);
          if (c16_exponent > 128) {
            c16_exponent = 128;
          }

          if (c16_exponent < -127) {
            c16_exponent = -127;
          }

          if (c16_significand < 0.0) {
            c16_histTable->NumberOfNegativeValues++;
            c16_histTable->HistogramOfNegativeValues[127 + c16_exponent]++;
          } else {
            c16_histTable->NumberOfPositiveValues++;
            c16_histTable->HistogramOfPositiveValues[127 + c16_exponent]++;
          }
        }
      }
    }

    c16_b_table[0U].SimMin = (real_T)c16_localMin * 7.62939453125E-6;
    c16_b_table[0U].SimMax = (real_T)c16_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c16_c_i = 0;
    while (c16_b_table[0U].IsAlwaysInteger && (c16_c_i < 5)) {
      if (((uint32_T)c16_in[c16_c_i] & 131071U) != 0U) {
        c16_b_table[0U].IsAlwaysInteger = false;
      }

      c16_c_i++;
    }
  }
}

static void c16_b_emlrt_update_log_3
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c16_in[4], emlrtLocationLoggingDataType c16_table[], int32_T c16_index)
{
  boolean_T c16_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c16_b_table;
  real_T c16_b_d;
  int32_T c16_i;
  int32_T c16_localMin;
  real_T c16_d1;
  int32_T c16_i1;
  int32_T c16_localMax;
  emlrtLocationLoggingHistogramType *c16_histTable;
  int32_T c16_b_i;
  int32_T c16_c_i;
  real_T c16_inDouble;
  real_T c16_significand;
  int32_T c16_exponent;
  (void)chartInstance;
  c16_isLoggingEnabledHere = (c16_index >= 0);
  if (c16_isLoggingEnabledHere) {
    c16_b_table = (emlrtLocationLoggingDataType *)&c16_table[c16_index];
    c16_b_d = muDoubleScalarFloor(c16_b_table[0U].SimMin * 131072.0);
    if (c16_b_d < 131072.0) {
      if (c16_b_d >= -131072.0) {
        c16_i = (int32_T)c16_b_d;
      } else {
        c16_i = -131072;
      }
    } else if (c16_b_d >= 131072.0) {
      c16_i = 131071;
    } else {
      c16_i = 0;
    }

    c16_localMin = c16_i;
    c16_d1 = muDoubleScalarFloor(c16_b_table[0U].SimMax * 131072.0);
    if (c16_d1 < 131072.0) {
      if (c16_d1 >= -131072.0) {
        c16_i1 = (int32_T)c16_d1;
      } else {
        c16_i1 = -131072;
      }
    } else if (c16_d1 >= 131072.0) {
      c16_i1 = 131071;
    } else {
      c16_i1 = 0;
    }

    c16_localMax = c16_i1;
    c16_histTable = c16_b_table[0U].HistogramTable;
    for (c16_b_i = 0; c16_b_i < 4; c16_b_i++) {
      /* Simulation Min-Max logging. */
      if (c16_in[c16_b_i] < c16_localMin) {
        c16_localMin = c16_in[c16_b_i];
      }

      if (c16_in[c16_b_i] > c16_localMax) {
        c16_localMax = c16_in[c16_b_i];
      }

      /* Histogram logging. */
      c16_inDouble = (real_T)c16_in[c16_b_i] * 7.62939453125E-6;
      c16_histTable->TotalNumberOfValues++;
      if (c16_inDouble == 0.0) {
        c16_histTable->NumberOfZeros++;
      } else {
        c16_histTable->SimSum += c16_inDouble;
        if ((!muDoubleScalarIsInf(c16_inDouble)) && (!muDoubleScalarIsNaN
             (c16_inDouble))) {
          c16_significand = frexp(c16_inDouble, &c16_exponent);
          if (c16_exponent > 128) {
            c16_exponent = 128;
          }

          if (c16_exponent < -127) {
            c16_exponent = -127;
          }

          if (c16_significand < 0.0) {
            c16_histTable->NumberOfNegativeValues++;
            c16_histTable->HistogramOfNegativeValues[127 + c16_exponent]++;
          } else {
            c16_histTable->NumberOfPositiveValues++;
            c16_histTable->HistogramOfPositiveValues[127 + c16_exponent]++;
          }
        }
      }
    }

    c16_b_table[0U].SimMin = (real_T)c16_localMin * 7.62939453125E-6;
    c16_b_table[0U].SimMax = (real_T)c16_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c16_c_i = 0;
    while (c16_b_table[0U].IsAlwaysInteger && (c16_c_i < 4)) {
      if (((uint32_T)c16_in[c16_c_i] & 131071U) != 0U) {
        c16_b_table[0U].IsAlwaysInteger = false;
      }

      c16_c_i++;
    }
  }
}

static void init_dsm_address_info(SFc16_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c16_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c16_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c16_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c16_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c16_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2929868855U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(436972284U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(707407755U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(719007121U);
}

mxArray *sf_c16_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c16_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c16_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c16_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiCewMzAwAakOYCYiQECWKF8RiBmhtIQcRa4uAIQl1QWpILEi4uSPVOAdF5iLpi"
    "fWFrhmZeWDzbfggFhPhsW8xmRzOeEikPAB3vK9Is4gPQbIOlnIaBfAMiqhIYLLHzIt1/AgTL9EP"
    "tJdX8KVN8FBvzxyogWr0xQPkhPDkMmQwHUHAcC7mdCc78AzPEOMQ5guiGGKuFAeXwoUMUdEQTiQ"
    "wMlPiD8zOL4xOSSzLLU+GRDs/iq1MSk0uL4jMqUovyCjPw8oGh+XnJRakkqzJ8AK/knEg=="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c16_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "s2lfbEDUyQjWCMMTPbwPIdD";
}

static void sf_opaque_initialize_c16_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c16_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c16_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c16_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c16_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c16_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c16_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc16_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c16_zeabus_hydrophone_concrete
      ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc16_zeabus_hydrophone_concrete
    ((SFc16_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c16_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c16_zeabus_hydrophone_concrete
      ((SFc16_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc16_zeabus_hydrophone_concrete
      ((SFc16_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c16_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [17] = {
    "eNrtVstu00AUddKAWlGqIIFAgkV3dMECWCB2hOYhIiU0kD5YVIom9k08ZDxj5pE0rNixYcEHsOO",
    "H+AF2fACfwLXjtJFjOw0pFRJYcsbjnHvm3Mdcj5WrNy28tvC+c8OyruK4jnfemlxXonlu5p68L1",
    "j3o/lXBHHjtYgknrIyL048eA1KMKOp4HXeE4kwynsggduI9YXUaWyKeoZRPqgZbgd86silttt2h",
    "WHOLtoSZ4+zMbL5RreQp0Il2LoG4GhXCtN3a4z0TxVLPSq7YA+U8bJcUKDbxg9kqaZhmvoMqidg",
    "17nSBBWrM21tTTSU9Umqm4Gnqj0FCs9nlPBEb12i2uBjgDUc+A7+7hmNTsVhtkuk3gWXDEE16CD",
    "kFBzinFThH13KiRaSElb1WDkwnNfWYqinKRxgGQFBbbsSyMAXlOv0/Ldr6GmVky6DCnRNP52tDe",
    "9MkPxDCiOQqXHrlcUQJOnDHk9dNAxI9STM1mmVzMM09eCQyOc25k+Bk1q9WDmqTTBPsI8WaTAIn",
    "ayrfUmHGN5UNuPVg8pctGWMN0m2WgQL2apDyMrCKVvN5mXCmEqF7Qu/AUNgIWuFaJINm7Am43wp",
    "fNLHqnUwyEGJlwV36FwubKO08MpYbpVG4yV2imRxZ7A61yB7xIakfatsFxzDAB3FzqTD5RJIHaq",
    "CbC1ARTldhLJUz/DKSMgBOpqx7c9cCHKQCvRUH6OPtXugsMyzYEH0F+Kmff6hddbnN8/R56d28X",
    "FnhieXwGPNjPF1N/LZ6+bxKRfZlWbsrsfWKcTsAlwR7y/VT9/F3fWPh7c2j/iPB9dWWr+w3HdxK",
    "5rfmzag0/IczlVFgH0xo6uQwH97hr8YzdVj1utWKwfjV2+Pys3mfqs7atWdSsj3eS1b71pM7/T9",
    "dtAJx37Y15S06070wQ7mxEw+YwH/0xm9VxfEYyN6P7l+PlvN/mYpnsfCAvsiPo1jdfv76xdLq9n",
    "P74Pz6Hciu2/WcnWYj+aBDbOo5SfspyT9+Zj+4lR86bgUjh+OLyQOq+dj+0J0vFmQj53Y/tsJzx",
    "8dgqeJIXTsR08674F0jeq4Ywe/dC6euDq24LYEDVsX0P+WtbP+2/0Vdrl/0L/znCcu2866ZLtV/",
    "Vv2XLXKOSze76wYvrjCOn8av+p5dBn8LyWlaQc=",
    ""
  };

  static char newstr [1165] = "";
  newstr[0] = '\0';
  for (i = 0; i < 17; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c16_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c16_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(3716957596U));
  ssSetChecksum1(S,(2265455471U));
  ssSetChecksum2(S,(1460409686U));
  ssSetChecksum3(S,(187491438U));
}

static void mdlRTW_c16_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c16_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc16_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc16_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc16_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc16_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c16_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c16_zeabus_hydrophone_concrete;
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
    chartInstance->c16_JITStateAnimation,
    chartInstance->c16_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c16_zeabus_hydrophone_concrete(chartInstance);
}

void c16_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c16_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c16_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c16_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c16_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
