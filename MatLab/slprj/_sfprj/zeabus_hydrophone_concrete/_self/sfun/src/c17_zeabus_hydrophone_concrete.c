/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c17_zeabus_hydrophone_concrete.h"
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
static const mxArray *c17_eml_mx;
static const mxArray *c17_b_eml_mx;
static emlrtRSInfo c17_emlrtRSI = { 4, /* lineNo */
  "Hydrophone processing/ADC3 Interface/Median Filter/Median Filter_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:609"    /* pathName */
};

/* Function Declarations */
static void initialize_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c17_update_jit_animation_state_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c17_do_animation_call_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c17_st);
static void finalize_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initSimStructsc17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c17_emlrt_update_log_1
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c17_in,
   emlrtLocationLoggingDataType c17_table[], int32_T c17_index);
static void c17_emlrt_update_log_2
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[5], emlrtLocationLoggingDataType c17_table[], int32_T c17_index,
   int32_T c17_out[5]);
static void c17_emlrt_update_log_3
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[4], emlrtLocationLoggingDataType c17_table[], int32_T c17_index,
   int32_T c17_out[4]);
static boolean_T c17_emlrt_update_log_4
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c17_in, emlrtLocationLoggingDataType c17_table[], int32_T c17_index);
static void c17_emlrtInitVarDataTables
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c17_dataTables[52],
   emlrtLocationLoggingHistogramType c17_histTables[52]);
static int32_T c17_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_y, const char_T *c17_identifier);
static int32_T c17_b_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_u, const emlrtMsgIdentifier
   *c17_parentId);
static void c17_c_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_d, const char_T *c17_identifier,
   boolean_T *c17_svPtr, int32_T c17_b_y[5]);
static void c17_d_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_u, const emlrtMsgIdentifier
   *c17_parentId, boolean_T *c17_svPtr, int32_T c17_b_y[5]);
static uint8_T c17_e_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c17_b_is_active_c17_zeabus_hydrophone_concrete, const char_T *c17_identifier);
static uint8_T c17_f_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c17_b_u, const emlrtMsgIdentifier *c17_parentId);
static const mxArray *c17_chart_data_browse_helper
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_ssIdNumber);
static void c17_b_emlrt_update_log_2
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[5], emlrtLocationLoggingDataType c17_table[], int32_T c17_index);
static void c17_b_emlrt_update_log_3
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[4], emlrtLocationLoggingDataType c17_table[], int32_T c17_index);
static void init_dsm_address_info(SFc17_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c17_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c17_st.tls = chartInstance->c17_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c17_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c17_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c17_d_not_empty = false;
  chartInstance->c17_is_active_c17_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c17_b_eml_mx, sf_mex_call(&c17_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c17_eml_mx, sf_mex_call(&c17_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c17_emlrtLocLogSimulated = false;
  c17_emlrtInitVarDataTables(chartInstance,
    chartInstance->c17_emlrtLocationLoggingDataTables,
    chartInstance->c17_emlrtLocLogHistTables);
}

static void initialize_params_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c17_update_jit_animation_state_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c17_do_animation_call_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c17_st;
  const mxArray *c17_b_y = NULL;
  const mxArray *c17_c_y = NULL;
  int32_T c17_b_u;
  const mxArray *c17_d_y = NULL;
  const mxArray *c17_e_y = NULL;
  int32_T c17_i;
  const mxArray *c17_f_y = NULL;
  int32_T c17_c_u[5];
  const mxArray *c17_g_y = NULL;
  c17_st = NULL;
  c17_st = NULL;
  c17_b_y = NULL;
  sf_mex_assign(&c17_b_y, sf_mex_createcellmatrix(3, 1), false);
  c17_c_y = NULL;
  c17_b_u = *chartInstance->c17_y;
  c17_d_y = NULL;
  sf_mex_assign(&c17_d_y, sf_mex_create("y", &c17_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c17_c_y, sf_mex_create_fi(sf_mex_dup(c17_eml_mx), sf_mex_dup
    (c17_b_eml_mx), "simulinkarray", c17_d_y, false, false), false);
  sf_mex_setcell(c17_b_y, 0, c17_c_y);
  c17_e_y = NULL;
  if (!chartInstance->c17_d_not_empty) {
    sf_mex_assign(&c17_e_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    for (c17_i = 0; c17_i < 5; c17_i++) {
      c17_c_u[c17_i] = chartInstance->c17_d[c17_i];
    }

    c17_f_y = NULL;
    sf_mex_assign(&c17_f_y, sf_mex_create("y", c17_c_u, 6, 0U, 1U, 0U, 2, 1, 5),
                  false);
    sf_mex_assign(&c17_e_y, sf_mex_create_fi(sf_mex_dup(c17_eml_mx), sf_mex_dup
      (c17_b_eml_mx), "simulinkarray", c17_f_y, true, false), false);
  }

  sf_mex_setcell(c17_b_y, 1, c17_e_y);
  c17_g_y = NULL;
  sf_mex_assign(&c17_g_y, sf_mex_create("y",
    &chartInstance->c17_is_active_c17_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c17_b_y, 2, c17_g_y);
  sf_mex_assign(&c17_st, c17_b_y, false);
  return c17_st;
}

static void set_sim_state_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c17_st)
{
  emlrtStack c17_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c17_b_u;
  int32_T c17_iv[5];
  int32_T c17_i;
  c17_b_st.tls = chartInstance->c17_fEmlrtCtx;
  chartInstance->c17_doneDoubleBufferReInit = true;
  c17_b_u = sf_mex_dup(c17_st);
  *chartInstance->c17_y = c17_emlrt_marshallIn(chartInstance, &c17_b_st,
    sf_mex_dup(sf_mex_getcell(c17_b_u, 0)), "y");
  c17_c_emlrt_marshallIn(chartInstance, &c17_b_st, sf_mex_dup(sf_mex_getcell
    (c17_b_u, 1)), "d", &chartInstance->c17_d_not_empty, c17_iv);
  for (c17_i = 0; c17_i < 5; c17_i++) {
    chartInstance->c17_d[c17_i] = c17_iv[c17_i];
  }

  chartInstance->c17_is_active_c17_zeabus_hydrophone_concrete =
    c17_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c17_b_u, 2)),
    "is_active_c17_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c17_b_u);
  sf_mex_destroy(&c17_st);
}

static void finalize_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c17_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:609", /* mexFileName */
    "Thu Apr 16 10:58:19 2020",        /* timestamp */
    "",                                /* buildDir */
    1,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c17_emlrtLocationLoggingFunctionInfoTable[1] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      52                               /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c17_emlrtLocationInfo[73] = { { 1,/* MxInfoID */
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

  const int32_T c17_emlrtLocationLoggingFieldCounts[52] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

  sfListenerLightTerminate(chartInstance->c17_RuntimeVar);
  if (chartInstance->c17_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:609");
    emlrtLocationLoggingPushLog(&c17_emlrtLocationLoggingFileInfo,
      c17_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c17_emlrtLocationLoggingDataTables, c17_emlrtLocationInfo,
      NULL, 0U, c17_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:609");
  }

  sf_mex_destroy(&c17_eml_mx);
  sf_mex_destroy(&c17_b_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c17_covrtInstance);
}

static void sf_gateway_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  int32_T c17_b_u;
  int32_T c17_varargin_1;
  int32_T c17_b_varargin_1;
  int32_T c17_var1;
  int32_T c17_hfi;
  int32_T c17_c_u;
  int32_T c17_i;
  int32_T c17_i1;
  int32_T c17_i2;
  int32_T c17_iv[4];
  int32_T c17_i3;
  int32_T c17_t[5];
  int32_T c17_a0;
  int32_T c17_b0;
  int32_T c17_a;
  int32_T c17_b;
  int32_T c17_b_a0;
  int32_T c17_b_b0;
  int32_T c17_a1;
  int32_T c17_b1;
  int32_T c17_b_a1;
  int32_T c17_b_b1;
  boolean_T c17_c;
  int32_T c17_i4;
  int32_T c17_i5;
  real_T c17_b_t;
  int32_T c17_c_varargin_1;
  int32_T c17_c_a0;
  int32_T c17_varargin_2;
  int32_T c17_c_b0;
  int32_T c17_fmo_1;
  int32_T c17_b_a;
  int32_T c17_fmo_2;
  int32_T c17_b_b;
  int32_T c17_b_fmo_1;
  int32_T c17_d_a0;
  int32_T c17_b_fmo_2;
  int32_T c17_d_b0;
  int32_T c17_d_varargin_1;
  int32_T c17_c_a1;
  int32_T c17_e_varargin_1;
  int32_T c17_c_b1;
  int32_T c17_b_var1;
  int32_T c17_d_a1;
  int32_T c17_b_hfi;
  int32_T c17_d_b1;
  boolean_T c17_b_c;
  int32_T c17_f_varargin_1;
  int32_T c17_i6;
  int32_T c17_g_varargin_1;
  int32_T c17_c_var1;
  int32_T c17_c_hfi;
  int32_T c17_i7;
  real_T c17_c_t;
  int32_T c17_h_varargin_1;
  int32_T c17_e_a0;
  int32_T c17_b_varargin_2;
  int32_T c17_e_b0;
  int32_T c17_fmo_3;
  int32_T c17_c_a;
  int32_T c17_fmo_4;
  int32_T c17_c_b;
  int32_T c17_b_fmo_3;
  int32_T c17_f_a0;
  int32_T c17_b_fmo_4;
  int32_T c17_f_b0;
  int32_T c17_i_varargin_1;
  int32_T c17_e_a1;
  int32_T c17_j_varargin_1;
  int32_T c17_e_b1;
  int32_T c17_d_var1;
  int32_T c17_f_a1;
  int32_T c17_d_hfi;
  int32_T c17_f_b1;
  boolean_T c17_c_c;
  int32_T c17_k_varargin_1;
  int32_T c17_i8;
  int32_T c17_l_varargin_1;
  int32_T c17_e_var1;
  int32_T c17_e_hfi;
  int32_T c17_i9;
  real_T c17_d_t;
  int32_T c17_m_varargin_1;
  int32_T c17_g_a0;
  int32_T c17_c_varargin_2;
  int32_T c17_g_b0;
  int32_T c17_fmo_5;
  int32_T c17_d_a;
  int32_T c17_fmo_6;
  int32_T c17_d_b;
  int32_T c17_b_fmo_5;
  int32_T c17_h_a0;
  int32_T c17_b_fmo_6;
  int32_T c17_h_b0;
  int32_T c17_n_varargin_1;
  int32_T c17_g_a1;
  int32_T c17_o_varargin_1;
  int32_T c17_g_b1;
  int32_T c17_f_var1;
  int32_T c17_h_a1;
  int32_T c17_f_hfi;
  int32_T c17_h_b1;
  boolean_T c17_d_c;
  int32_T c17_p_varargin_1;
  int32_T c17_i10;
  int32_T c17_q_varargin_1;
  int32_T c17_g_var1;
  int32_T c17_g_hfi;
  int32_T c17_i11;
  real_T c17_e_t;
  int32_T c17_r_varargin_1;
  int32_T c17_i_a0;
  int32_T c17_d_varargin_2;
  int32_T c17_i_b0;
  int32_T c17_fmo_7;
  int32_T c17_e_a;
  int32_T c17_fmo_8;
  int32_T c17_e_b;
  int32_T c17_b_fmo_7;
  int32_T c17_j_a0;
  int32_T c17_b_fmo_8;
  int32_T c17_j_b0;
  int32_T c17_s_varargin_1;
  int32_T c17_i_a1;
  int32_T c17_t_varargin_1;
  int32_T c17_i_b1;
  int32_T c17_h_var1;
  int32_T c17_j_a1;
  int32_T c17_h_hfi;
  int32_T c17_j_b1;
  boolean_T c17_e_c;
  int32_T c17_u_varargin_1;
  int32_T c17_i12;
  int32_T c17_v_varargin_1;
  int32_T c17_i_var1;
  int32_T c17_i_hfi;
  int32_T c17_i13;
  real_T c17_f_t;
  int32_T c17_w_varargin_1;
  int32_T c17_k_a0;
  int32_T c17_e_varargin_2;
  int32_T c17_k_b0;
  int32_T c17_fmo_9;
  int32_T c17_f_a;
  int32_T c17_fmo_10;
  int32_T c17_f_b;
  int32_T c17_b_fmo_9;
  int32_T c17_l_a0;
  int32_T c17_b_fmo_10;
  int32_T c17_l_b0;
  int32_T c17_x_varargin_1;
  int32_T c17_k_a1;
  int32_T c17_y_varargin_1;
  int32_T c17_k_b1;
  int32_T c17_j_var1;
  int32_T c17_l_a1;
  int32_T c17_j_hfi;
  int32_T c17_l_b1;
  boolean_T c17_f_c;
  int32_T c17_ab_varargin_1;
  int32_T c17_i14;
  int32_T c17_bb_varargin_1;
  int32_T c17_k_var1;
  int32_T c17_k_hfi;
  int32_T c17_i15;
  real_T c17_g_t;
  int32_T c17_cb_varargin_1;
  int32_T c17_m_a0;
  int32_T c17_f_varargin_2;
  int32_T c17_m_b0;
  int32_T c17_fmo_11;
  int32_T c17_g_a;
  int32_T c17_fmo_12;
  int32_T c17_g_b;
  int32_T c17_b_fmo_11;
  int32_T c17_n_a0;
  int32_T c17_b_fmo_12;
  int32_T c17_n_b0;
  int32_T c17_db_varargin_1;
  int32_T c17_m_a1;
  int32_T c17_eb_varargin_1;
  int32_T c17_m_b1;
  int32_T c17_l_var1;
  int32_T c17_n_a1;
  int32_T c17_l_hfi;
  int32_T c17_n_b1;
  boolean_T c17_g_c;
  int32_T c17_fb_varargin_1;
  int32_T c17_i16;
  int32_T c17_gb_varargin_1;
  int32_T c17_m_var1;
  int32_T c17_m_hfi;
  int32_T c17_i17;
  real_T c17_h_t;
  int32_T c17_hb_varargin_1;
  int32_T c17_o_a0;
  int32_T c17_g_varargin_2;
  int32_T c17_o_b0;
  int32_T c17_fmo_13;
  int32_T c17_h_a;
  int32_T c17_fmo_14;
  int32_T c17_h_b;
  int32_T c17_b_fmo_13;
  int32_T c17_p_a0;
  int32_T c17_b_fmo_14;
  int32_T c17_p_b0;
  int32_T c17_ib_varargin_1;
  int32_T c17_o_a1;
  int32_T c17_jb_varargin_1;
  int32_T c17_o_b1;
  int32_T c17_n_var1;
  int32_T c17_p_a1;
  int32_T c17_n_hfi;
  int32_T c17_p_b1;
  boolean_T c17_h_c;
  int32_T c17_kb_varargin_1;
  int32_T c17_i18;
  int32_T c17_lb_varargin_1;
  int32_T c17_o_var1;
  int32_T c17_o_hfi;
  int32_T c17_i19;
  real_T c17_i_t;
  int32_T c17_mb_varargin_1;
  int32_T c17_q_a0;
  int32_T c17_h_varargin_2;
  int32_T c17_q_b0;
  int32_T c17_fmo_15;
  int32_T c17_i_a;
  int32_T c17_fmo_16;
  int32_T c17_i_b;
  int32_T c17_b_fmo_15;
  int32_T c17_r_a0;
  int32_T c17_b_fmo_16;
  int32_T c17_r_b0;
  int32_T c17_nb_varargin_1;
  int32_T c17_q_a1;
  int32_T c17_ob_varargin_1;
  int32_T c17_q_b1;
  int32_T c17_p_var1;
  int32_T c17_r_a1;
  int32_T c17_p_hfi;
  int32_T c17_r_b1;
  boolean_T c17_i_c;
  int32_T c17_pb_varargin_1;
  int32_T c17_i20;
  int32_T c17_qb_varargin_1;
  int32_T c17_q_var1;
  int32_T c17_q_hfi;
  int32_T c17_i21;
  real_T c17_j_t;
  int32_T c17_rb_varargin_1;
  int32_T c17_sb_varargin_1;
  int32_T c17_i_varargin_2;
  int32_T c17_tb_varargin_1;
  int32_T c17_fmo_17;
  int32_T c17_r_var1;
  int32_T c17_fmo_18;
  int32_T c17_r_hfi;
  int32_T c17_b_fmo_17;
  int32_T c17_b_y;
  int32_T c17_b_fmo_18;
  int32_T c17_ub_varargin_1;
  int32_T c17_vb_varargin_1;
  int32_T c17_s_var1;
  int32_T c17_s_hfi;
  int32_T c17_wb_varargin_1;
  int32_T c17_xb_varargin_1;
  int32_T c17_t_var1;
  int32_T c17_t_hfi;
  chartInstance->c17_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c17_covrtInstance, 0U, (real_T)
                    *chartInstance->c17_u);
  chartInstance->c17_sfEvent = CALL_EVENT;
  c17_b_u = *chartInstance->c17_u;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  chartInstance->c17_emlrtLocLogSimulated = true;

  /* logging input variable 'u' for function 'eML_blk_kernel' */
  c17_emlrt_update_log_1(chartInstance, c17_b_u,
    chartInstance->c17_emlrtLocationLoggingDataTables, 0);
  covrtEmlFcnEval(chartInstance->c17_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c17_covrtInstance, 4U, 0, 1);
  c17_varargin_1 = c17_b_u;
  c17_b_varargin_1 = c17_varargin_1;
  c17_var1 = c17_b_varargin_1;
  c17_hfi = c17_var1;
  c17_c_u = c17_emlrt_update_log_1(chartInstance, c17_hfi,
    chartInstance->c17_emlrtLocationLoggingDataTables, 1);
  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 0,
                     !chartInstance->c17_d_not_empty)) {
    for (c17_i = 0; c17_i < 5; c17_i++) {
      chartInstance->c17_d[c17_i] = 0;
    }

    c17_b_emlrt_update_log_2(chartInstance, chartInstance->c17_d,
      chartInstance->c17_emlrtLocationLoggingDataTables, 2);
    chartInstance->c17_d_not_empty = true;
  }

  for (c17_i1 = 0; c17_i1 < 4; c17_i1++) {
    c17_iv[c17_i1] = chartInstance->c17_d[c17_i1 + 1];
  }

  for (c17_i2 = 0; c17_i2 < 4; c17_i2++) {
    chartInstance->c17_d[c17_i2] = c17_iv[c17_i2];
  }

  c17_b_emlrt_update_log_3(chartInstance, *(int32_T (*)[4])&chartInstance->
    c17_d[0], chartInstance->c17_emlrtLocationLoggingDataTables, 3);
  chartInstance->c17_d[4] = c17_emlrt_update_log_1(chartInstance, c17_c_u,
    chartInstance->c17_emlrtLocationLoggingDataTables, 4);
  for (c17_i3 = 0; c17_i3 < 5; c17_i3++) {
    c17_t[c17_i3] = chartInstance->c17_d[c17_i3];
  }

  c17_b_emlrt_update_log_2(chartInstance, c17_t,
    chartInstance->c17_emlrtLocationLoggingDataTables, 5);
  c17_a0 = c17_t[0];
  c17_b0 = c17_t[1];
  c17_a = c17_a0;
  c17_b = c17_b0;
  c17_b_a0 = c17_a;
  c17_b_b0 = c17_b;
  c17_a1 = c17_b_a0;
  c17_b1 = c17_b_b0;
  c17_b_a1 = c17_a1;
  c17_b_b1 = c17_b1;
  c17_c = (c17_b_a1 > c17_b_b1);
  c17_i4 = c17_t[1] - c17_t[0];
  if (c17_i4 > 131071) {
    c17_i4 = 131071;
  } else {
    if (c17_i4 < -131072) {
      c17_i4 = -131072;
    }
  }

  c17_i5 = c17_t[0] - c17_t[1];
  if (c17_i5 > 131071) {
    c17_i5 = 131071;
  } else {
    if (c17_i5 < -131072) {
      c17_i5 = -131072;
    }
  }

  if (c17_t[0] < c17_t[1]) {
    c17_b_t = (real_T)(c17_i4 <= 1);
  } else if (c17_t[0] > c17_t[1]) {
    if (c17_i5 <= 1) {
      c17_b_t = 3.0;
    } else {
      c17_b_t = 0.0;
    }
  } else {
    c17_b_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 1,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 0U, c17_b_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_c, chartInstance->c17_emlrtLocationLoggingDataTables,
         6)))) {
    c17_c_varargin_1 = c17_t[0];
    c17_varargin_2 = c17_t[1];
    c17_fmo_1 = c17_c_varargin_1;
    c17_fmo_2 = c17_varargin_2;
    c17_b_fmo_1 = c17_emlrt_update_log_1(chartInstance, c17_fmo_1,
      chartInstance->c17_emlrtLocationLoggingDataTables, 34);
    c17_b_fmo_2 = c17_emlrt_update_log_1(chartInstance, c17_fmo_2,
      chartInstance->c17_emlrtLocationLoggingDataTables, 35);
    c17_d_varargin_1 = c17_b_fmo_1;
    c17_e_varargin_1 = c17_d_varargin_1;
    c17_b_var1 = c17_e_varargin_1;
    c17_b_hfi = c17_b_var1;
    c17_t[1] = c17_emlrt_update_log_1(chartInstance, c17_b_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 7);
    c17_f_varargin_1 = c17_b_fmo_2;
    c17_g_varargin_1 = c17_f_varargin_1;
    c17_c_var1 = c17_g_varargin_1;
    c17_c_hfi = c17_c_var1;
    c17_t[0] = c17_emlrt_update_log_1(chartInstance, c17_c_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 8);
  }

  c17_c_a0 = c17_t[1];
  c17_c_b0 = c17_t[2];
  c17_b_a = c17_c_a0;
  c17_b_b = c17_c_b0;
  c17_d_a0 = c17_b_a;
  c17_d_b0 = c17_b_b;
  c17_c_a1 = c17_d_a0;
  c17_c_b1 = c17_d_b0;
  c17_d_a1 = c17_c_a1;
  c17_d_b1 = c17_c_b1;
  c17_b_c = (c17_d_a1 > c17_d_b1);
  c17_i6 = c17_t[2] - c17_t[1];
  if (c17_i6 > 131071) {
    c17_i6 = 131071;
  } else {
    if (c17_i6 < -131072) {
      c17_i6 = -131072;
    }
  }

  c17_i7 = c17_t[1] - c17_t[2];
  if (c17_i7 > 131071) {
    c17_i7 = 131071;
  } else {
    if (c17_i7 < -131072) {
      c17_i7 = -131072;
    }
  }

  if (c17_t[1] < c17_t[2]) {
    c17_c_t = (real_T)(c17_i6 <= 1);
  } else if (c17_t[1] > c17_t[2]) {
    if (c17_i7 <= 1) {
      c17_c_t = 3.0;
    } else {
      c17_c_t = 0.0;
    }
  } else {
    c17_c_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 2,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 1U, c17_c_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_b_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 9)))) {
    c17_h_varargin_1 = c17_t[1];
    c17_b_varargin_2 = c17_t[2];
    c17_fmo_3 = c17_h_varargin_1;
    c17_fmo_4 = c17_b_varargin_2;
    c17_b_fmo_3 = c17_emlrt_update_log_1(chartInstance, c17_fmo_3,
      chartInstance->c17_emlrtLocationLoggingDataTables, 36);
    c17_b_fmo_4 = c17_emlrt_update_log_1(chartInstance, c17_fmo_4,
      chartInstance->c17_emlrtLocationLoggingDataTables, 37);
    c17_i_varargin_1 = c17_b_fmo_3;
    c17_j_varargin_1 = c17_i_varargin_1;
    c17_d_var1 = c17_j_varargin_1;
    c17_d_hfi = c17_d_var1;
    c17_t[2] = c17_emlrt_update_log_1(chartInstance, c17_d_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 10);
    c17_k_varargin_1 = c17_b_fmo_4;
    c17_l_varargin_1 = c17_k_varargin_1;
    c17_e_var1 = c17_l_varargin_1;
    c17_e_hfi = c17_e_var1;
    c17_t[1] = c17_emlrt_update_log_1(chartInstance, c17_e_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 11);
  }

  c17_e_a0 = c17_t[2];
  c17_e_b0 = c17_t[3];
  c17_c_a = c17_e_a0;
  c17_c_b = c17_e_b0;
  c17_f_a0 = c17_c_a;
  c17_f_b0 = c17_c_b;
  c17_e_a1 = c17_f_a0;
  c17_e_b1 = c17_f_b0;
  c17_f_a1 = c17_e_a1;
  c17_f_b1 = c17_e_b1;
  c17_c_c = (c17_f_a1 > c17_f_b1);
  c17_i8 = c17_t[3] - c17_t[2];
  if (c17_i8 > 131071) {
    c17_i8 = 131071;
  } else {
    if (c17_i8 < -131072) {
      c17_i8 = -131072;
    }
  }

  c17_i9 = c17_t[2] - c17_t[3];
  if (c17_i9 > 131071) {
    c17_i9 = 131071;
  } else {
    if (c17_i9 < -131072) {
      c17_i9 = -131072;
    }
  }

  if (c17_t[2] < c17_t[3]) {
    c17_d_t = (real_T)(c17_i8 <= 1);
  } else if (c17_t[2] > c17_t[3]) {
    if (c17_i9 <= 1) {
      c17_d_t = 3.0;
    } else {
      c17_d_t = 0.0;
    }
  } else {
    c17_d_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 3,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 2U, c17_d_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_c_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 12)))) {
    c17_m_varargin_1 = c17_t[2];
    c17_c_varargin_2 = c17_t[3];
    c17_fmo_5 = c17_m_varargin_1;
    c17_fmo_6 = c17_c_varargin_2;
    c17_b_fmo_5 = c17_emlrt_update_log_1(chartInstance, c17_fmo_5,
      chartInstance->c17_emlrtLocationLoggingDataTables, 38);
    c17_b_fmo_6 = c17_emlrt_update_log_1(chartInstance, c17_fmo_6,
      chartInstance->c17_emlrtLocationLoggingDataTables, 39);
    c17_n_varargin_1 = c17_b_fmo_5;
    c17_o_varargin_1 = c17_n_varargin_1;
    c17_f_var1 = c17_o_varargin_1;
    c17_f_hfi = c17_f_var1;
    c17_t[3] = c17_emlrt_update_log_1(chartInstance, c17_f_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 13);
    c17_p_varargin_1 = c17_b_fmo_6;
    c17_q_varargin_1 = c17_p_varargin_1;
    c17_g_var1 = c17_q_varargin_1;
    c17_g_hfi = c17_g_var1;
    c17_t[2] = c17_emlrt_update_log_1(chartInstance, c17_g_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 14);
  }

  c17_g_a0 = c17_t[3];
  c17_g_b0 = c17_t[4];
  c17_d_a = c17_g_a0;
  c17_d_b = c17_g_b0;
  c17_h_a0 = c17_d_a;
  c17_h_b0 = c17_d_b;
  c17_g_a1 = c17_h_a0;
  c17_g_b1 = c17_h_b0;
  c17_h_a1 = c17_g_a1;
  c17_h_b1 = c17_g_b1;
  c17_d_c = (c17_h_a1 > c17_h_b1);
  c17_i10 = c17_t[4] - c17_t[3];
  if (c17_i10 > 131071) {
    c17_i10 = 131071;
  } else {
    if (c17_i10 < -131072) {
      c17_i10 = -131072;
    }
  }

  c17_i11 = c17_t[3] - c17_t[4];
  if (c17_i11 > 131071) {
    c17_i11 = 131071;
  } else {
    if (c17_i11 < -131072) {
      c17_i11 = -131072;
    }
  }

  if (c17_t[3] < c17_t[4]) {
    c17_e_t = (real_T)(c17_i10 <= 1);
  } else if (c17_t[3] > c17_t[4]) {
    if (c17_i11 <= 1) {
      c17_e_t = 3.0;
    } else {
      c17_e_t = 0.0;
    }
  } else {
    c17_e_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 4,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 3U, c17_e_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_d_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 15)))) {
    c17_r_varargin_1 = c17_t[3];
    c17_d_varargin_2 = c17_t[4];
    c17_fmo_7 = c17_r_varargin_1;
    c17_fmo_8 = c17_d_varargin_2;
    c17_b_fmo_7 = c17_emlrt_update_log_1(chartInstance, c17_fmo_7,
      chartInstance->c17_emlrtLocationLoggingDataTables, 40);
    c17_b_fmo_8 = c17_emlrt_update_log_1(chartInstance, c17_fmo_8,
      chartInstance->c17_emlrtLocationLoggingDataTables, 41);
    c17_s_varargin_1 = c17_b_fmo_7;
    c17_t_varargin_1 = c17_s_varargin_1;
    c17_h_var1 = c17_t_varargin_1;
    c17_h_hfi = c17_h_var1;
    c17_emlrt_update_log_1(chartInstance, c17_h_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 16);
    c17_u_varargin_1 = c17_b_fmo_8;
    c17_v_varargin_1 = c17_u_varargin_1;
    c17_i_var1 = c17_v_varargin_1;
    c17_i_hfi = c17_i_var1;
    c17_t[3] = c17_emlrt_update_log_1(chartInstance, c17_i_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 17);
  }

  c17_i_a0 = c17_t[0];
  c17_i_b0 = c17_t[1];
  c17_e_a = c17_i_a0;
  c17_e_b = c17_i_b0;
  c17_j_a0 = c17_e_a;
  c17_j_b0 = c17_e_b;
  c17_i_a1 = c17_j_a0;
  c17_i_b1 = c17_j_b0;
  c17_j_a1 = c17_i_a1;
  c17_j_b1 = c17_i_b1;
  c17_e_c = (c17_j_a1 > c17_j_b1);
  c17_i12 = c17_t[1] - c17_t[0];
  if (c17_i12 > 131071) {
    c17_i12 = 131071;
  } else {
    if (c17_i12 < -131072) {
      c17_i12 = -131072;
    }
  }

  c17_i13 = c17_t[0] - c17_t[1];
  if (c17_i13 > 131071) {
    c17_i13 = 131071;
  } else {
    if (c17_i13 < -131072) {
      c17_i13 = -131072;
    }
  }

  if (c17_t[0] < c17_t[1]) {
    c17_f_t = (real_T)(c17_i12 <= 1);
  } else if (c17_t[0] > c17_t[1]) {
    if (c17_i13 <= 1) {
      c17_f_t = 3.0;
    } else {
      c17_f_t = 0.0;
    }
  } else {
    c17_f_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 5,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 4U, c17_f_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_e_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 18)))) {
    c17_w_varargin_1 = c17_t[0];
    c17_e_varargin_2 = c17_t[1];
    c17_fmo_9 = c17_w_varargin_1;
    c17_fmo_10 = c17_e_varargin_2;
    c17_b_fmo_9 = c17_emlrt_update_log_1(chartInstance, c17_fmo_9,
      chartInstance->c17_emlrtLocationLoggingDataTables, 42);
    c17_b_fmo_10 = c17_emlrt_update_log_1(chartInstance, c17_fmo_10,
      chartInstance->c17_emlrtLocationLoggingDataTables, 43);
    c17_x_varargin_1 = c17_b_fmo_9;
    c17_y_varargin_1 = c17_x_varargin_1;
    c17_j_var1 = c17_y_varargin_1;
    c17_j_hfi = c17_j_var1;
    c17_t[1] = c17_emlrt_update_log_1(chartInstance, c17_j_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 19);
    c17_ab_varargin_1 = c17_b_fmo_10;
    c17_bb_varargin_1 = c17_ab_varargin_1;
    c17_k_var1 = c17_bb_varargin_1;
    c17_k_hfi = c17_k_var1;
    c17_t[0] = c17_emlrt_update_log_1(chartInstance, c17_k_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 20);
  }

  c17_k_a0 = c17_t[1];
  c17_k_b0 = c17_t[2];
  c17_f_a = c17_k_a0;
  c17_f_b = c17_k_b0;
  c17_l_a0 = c17_f_a;
  c17_l_b0 = c17_f_b;
  c17_k_a1 = c17_l_a0;
  c17_k_b1 = c17_l_b0;
  c17_l_a1 = c17_k_a1;
  c17_l_b1 = c17_k_b1;
  c17_f_c = (c17_l_a1 > c17_l_b1);
  c17_i14 = c17_t[2] - c17_t[1];
  if (c17_i14 > 131071) {
    c17_i14 = 131071;
  } else {
    if (c17_i14 < -131072) {
      c17_i14 = -131072;
    }
  }

  c17_i15 = c17_t[1] - c17_t[2];
  if (c17_i15 > 131071) {
    c17_i15 = 131071;
  } else {
    if (c17_i15 < -131072) {
      c17_i15 = -131072;
    }
  }

  if (c17_t[1] < c17_t[2]) {
    c17_g_t = (real_T)(c17_i14 <= 1);
  } else if (c17_t[1] > c17_t[2]) {
    if (c17_i15 <= 1) {
      c17_g_t = 3.0;
    } else {
      c17_g_t = 0.0;
    }
  } else {
    c17_g_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 6,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 5U, c17_g_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_f_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 21)))) {
    c17_cb_varargin_1 = c17_t[1];
    c17_f_varargin_2 = c17_t[2];
    c17_fmo_11 = c17_cb_varargin_1;
    c17_fmo_12 = c17_f_varargin_2;
    c17_b_fmo_11 = c17_emlrt_update_log_1(chartInstance, c17_fmo_11,
      chartInstance->c17_emlrtLocationLoggingDataTables, 44);
    c17_b_fmo_12 = c17_emlrt_update_log_1(chartInstance, c17_fmo_12,
      chartInstance->c17_emlrtLocationLoggingDataTables, 45);
    c17_db_varargin_1 = c17_b_fmo_11;
    c17_eb_varargin_1 = c17_db_varargin_1;
    c17_l_var1 = c17_eb_varargin_1;
    c17_l_hfi = c17_l_var1;
    c17_t[2] = c17_emlrt_update_log_1(chartInstance, c17_l_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 22);
    c17_fb_varargin_1 = c17_b_fmo_12;
    c17_gb_varargin_1 = c17_fb_varargin_1;
    c17_m_var1 = c17_gb_varargin_1;
    c17_m_hfi = c17_m_var1;
    c17_t[1] = c17_emlrt_update_log_1(chartInstance, c17_m_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 23);
  }

  c17_m_a0 = c17_t[2];
  c17_m_b0 = c17_t[3];
  c17_g_a = c17_m_a0;
  c17_g_b = c17_m_b0;
  c17_n_a0 = c17_g_a;
  c17_n_b0 = c17_g_b;
  c17_m_a1 = c17_n_a0;
  c17_m_b1 = c17_n_b0;
  c17_n_a1 = c17_m_a1;
  c17_n_b1 = c17_m_b1;
  c17_g_c = (c17_n_a1 > c17_n_b1);
  c17_i16 = c17_t[3] - c17_t[2];
  if (c17_i16 > 131071) {
    c17_i16 = 131071;
  } else {
    if (c17_i16 < -131072) {
      c17_i16 = -131072;
    }
  }

  c17_i17 = c17_t[2] - c17_t[3];
  if (c17_i17 > 131071) {
    c17_i17 = 131071;
  } else {
    if (c17_i17 < -131072) {
      c17_i17 = -131072;
    }
  }

  if (c17_t[2] < c17_t[3]) {
    c17_h_t = (real_T)(c17_i16 <= 1);
  } else if (c17_t[2] > c17_t[3]) {
    if (c17_i17 <= 1) {
      c17_h_t = 3.0;
    } else {
      c17_h_t = 0.0;
    }
  } else {
    c17_h_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 7,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 6U, c17_h_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_g_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 24)))) {
    c17_hb_varargin_1 = c17_t[2];
    c17_g_varargin_2 = c17_t[3];
    c17_fmo_13 = c17_hb_varargin_1;
    c17_fmo_14 = c17_g_varargin_2;
    c17_b_fmo_13 = c17_emlrt_update_log_1(chartInstance, c17_fmo_13,
      chartInstance->c17_emlrtLocationLoggingDataTables, 46);
    c17_b_fmo_14 = c17_emlrt_update_log_1(chartInstance, c17_fmo_14,
      chartInstance->c17_emlrtLocationLoggingDataTables, 47);
    c17_ib_varargin_1 = c17_b_fmo_13;
    c17_jb_varargin_1 = c17_ib_varargin_1;
    c17_n_var1 = c17_jb_varargin_1;
    c17_n_hfi = c17_n_var1;
    c17_emlrt_update_log_1(chartInstance, c17_n_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 25);
    c17_kb_varargin_1 = c17_b_fmo_14;
    c17_lb_varargin_1 = c17_kb_varargin_1;
    c17_o_var1 = c17_lb_varargin_1;
    c17_o_hfi = c17_o_var1;
    c17_t[2] = c17_emlrt_update_log_1(chartInstance, c17_o_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 26);
  }

  c17_o_a0 = c17_t[0];
  c17_o_b0 = c17_t[1];
  c17_h_a = c17_o_a0;
  c17_h_b = c17_o_b0;
  c17_p_a0 = c17_h_a;
  c17_p_b0 = c17_h_b;
  c17_o_a1 = c17_p_a0;
  c17_o_b1 = c17_p_b0;
  c17_p_a1 = c17_o_a1;
  c17_p_b1 = c17_o_b1;
  c17_h_c = (c17_p_a1 > c17_p_b1);
  c17_i18 = c17_t[1] - c17_t[0];
  if (c17_i18 > 131071) {
    c17_i18 = 131071;
  } else {
    if (c17_i18 < -131072) {
      c17_i18 = -131072;
    }
  }

  c17_i19 = c17_t[0] - c17_t[1];
  if (c17_i19 > 131071) {
    c17_i19 = 131071;
  } else {
    if (c17_i19 < -131072) {
      c17_i19 = -131072;
    }
  }

  if (c17_t[0] < c17_t[1]) {
    c17_i_t = (real_T)(c17_i18 <= 1);
  } else if (c17_t[0] > c17_t[1]) {
    if (c17_i19 <= 1) {
      c17_i_t = 3.0;
    } else {
      c17_i_t = 0.0;
    }
  } else {
    c17_i_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 8,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 7U, c17_i_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_h_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 27)))) {
    c17_mb_varargin_1 = c17_t[0];
    c17_h_varargin_2 = c17_t[1];
    c17_fmo_15 = c17_mb_varargin_1;
    c17_fmo_16 = c17_h_varargin_2;
    c17_b_fmo_15 = c17_emlrt_update_log_1(chartInstance, c17_fmo_15,
      chartInstance->c17_emlrtLocationLoggingDataTables, 48);
    c17_b_fmo_16 = c17_emlrt_update_log_1(chartInstance, c17_fmo_16,
      chartInstance->c17_emlrtLocationLoggingDataTables, 49);
    c17_nb_varargin_1 = c17_b_fmo_15;
    c17_ob_varargin_1 = c17_nb_varargin_1;
    c17_p_var1 = c17_ob_varargin_1;
    c17_p_hfi = c17_p_var1;
    c17_t[1] = c17_emlrt_update_log_1(chartInstance, c17_p_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 28);
    c17_pb_varargin_1 = c17_b_fmo_16;
    c17_qb_varargin_1 = c17_pb_varargin_1;
    c17_q_var1 = c17_qb_varargin_1;
    c17_q_hfi = c17_q_var1;
    c17_emlrt_update_log_1(chartInstance, c17_q_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 29);
  }

  c17_q_a0 = c17_t[1];
  c17_q_b0 = c17_t[2];
  c17_i_a = c17_q_a0;
  c17_i_b = c17_q_b0;
  c17_r_a0 = c17_i_a;
  c17_r_b0 = c17_i_b;
  c17_q_a1 = c17_r_a0;
  c17_q_b1 = c17_r_b0;
  c17_r_a1 = c17_q_a1;
  c17_r_b1 = c17_q_b1;
  c17_i_c = (c17_r_a1 > c17_r_b1);
  c17_i20 = c17_t[2] - c17_t[1];
  if (c17_i20 > 131071) {
    c17_i20 = 131071;
  } else {
    if (c17_i20 < -131072) {
      c17_i20 = -131072;
    }
  }

  c17_i21 = c17_t[1] - c17_t[2];
  if (c17_i21 > 131071) {
    c17_i21 = 131071;
  } else {
    if (c17_i21 < -131072) {
      c17_i21 = -131072;
    }
  }

  if (c17_t[1] < c17_t[2]) {
    c17_j_t = (real_T)(c17_i20 <= 1);
  } else if (c17_t[1] > c17_t[2]) {
    if (c17_i21 <= 1) {
      c17_j_t = 3.0;
    } else {
      c17_j_t = 0.0;
    }
  } else {
    c17_j_t = 2.0;
  }

  if (covrtEmlIfEval(chartInstance->c17_covrtInstance, 4U, 0, 9,
                     covrtRelationalopUpdateFcn(chartInstance->c17_covrtInstance,
        4U, 0U, 8U, c17_j_t, 0.0, -2, 4U, (int32_T)c17_emlrt_update_log_4
        (chartInstance, c17_i_c,
         chartInstance->c17_emlrtLocationLoggingDataTables, 30)))) {
    c17_rb_varargin_1 = c17_t[1];
    c17_i_varargin_2 = c17_t[2];
    c17_fmo_17 = c17_rb_varargin_1;
    c17_fmo_18 = c17_i_varargin_2;
    c17_b_fmo_17 = c17_emlrt_update_log_1(chartInstance, c17_fmo_17,
      chartInstance->c17_emlrtLocationLoggingDataTables, 50);
    c17_b_fmo_18 = c17_emlrt_update_log_1(chartInstance, c17_fmo_18,
      chartInstance->c17_emlrtLocationLoggingDataTables, 51);
    c17_ub_varargin_1 = c17_b_fmo_17;
    c17_vb_varargin_1 = c17_ub_varargin_1;
    c17_s_var1 = c17_vb_varargin_1;
    c17_s_hfi = c17_s_var1;
    c17_t[2] = c17_emlrt_update_log_1(chartInstance, c17_s_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 31);
    c17_wb_varargin_1 = c17_b_fmo_18;
    c17_xb_varargin_1 = c17_wb_varargin_1;
    c17_t_var1 = c17_xb_varargin_1;
    c17_t_hfi = c17_t_var1;
    c17_emlrt_update_log_1(chartInstance, c17_t_hfi,
      chartInstance->c17_emlrtLocationLoggingDataTables, 32);
  }

  c17_sb_varargin_1 = c17_t[2];
  c17_tb_varargin_1 = c17_sb_varargin_1;
  c17_r_var1 = c17_tb_varargin_1;
  c17_r_hfi = c17_r_var1;
  c17_b_y = c17_emlrt_update_log_1(chartInstance, c17_r_hfi,
    chartInstance->c17_emlrtLocationLoggingDataTables, 33);
  *chartInstance->c17_y = c17_b_y;
  c17_do_animation_call_c17_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c17_covrtInstance, 1U, (real_T)
                    *chartInstance->c17_y);
}

static void mdl_start_c17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c17_decisionTxtStartIdx = 0U;
  static const uint32_T c17_decisionTxtEndIdx = 0U;
  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c17_chart_data_browse_helper);
  chartInstance->c17_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c17_covrtInstance, 1U, 0U, 1U,
    54U);
  covrtChartInitFcn(chartInstance->c17_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c17_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c17_decisionTxtStartIdx, &c17_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c17_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c17_covrtInstance, "", 4U, 0U, 2U, 0U, 10U, 0U,
                  0U, 0U, 0U, 0U, 0U, 0U);
  covrtEmlFcnInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 1633);
  covrtEmlFcnInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 1U, "get_fimath",
                     1636, -1, 1890);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 0U, 116, 130, -1,
                    178);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 1U, 350, 364, -1,
                    483);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 2U, 484, 498, -1,
                    617);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 3U, 618, 632, -1,
                    751);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 4U, 752, 766, -1,
                    885);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 5U, 895, 909, -1,
                    1030);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 6U, 1031, 1045, -1,
                    1168);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 7U, 1169, 1183, -1,
                    1306);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 8U, 1316, 1330, -1,
                    1453);
  covrtEmlIfInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 9U, 1454, 1468, -1,
                    1591);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 0U, 353,
    364, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 1U, 487,
    498, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 2U, 621,
    632, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 3U, 755,
    766, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 4U, 898,
    909, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 5U, 1034,
    1045, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 6U, 1172,
    1183, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 7U, 1319,
    1330, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c17_covrtInstance, 4U, 0U, 8U, 1457,
    1468, -2, 4U);
}

static void initSimStructsc17_zeabus_hydrophone_concrete
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c17_emlrt_update_log_1
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c17_in,
   emlrtLocationLoggingDataType c17_table[], int32_T c17_index)
{
  boolean_T c17_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c17_b_table;
  real_T c17_b_d;
  int32_T c17_i;
  int32_T c17_localMin;
  real_T c17_d1;
  int32_T c17_i1;
  int32_T c17_localMax;
  emlrtLocationLoggingHistogramType *c17_histTable;
  real_T c17_inDouble;
  real_T c17_significand;
  int32_T c17_exponent;
  (void)chartInstance;
  c17_isLoggingEnabledHere = (c17_index >= 0);
  if (c17_isLoggingEnabledHere) {
    c17_b_table = (emlrtLocationLoggingDataType *)&c17_table[c17_index];
    c17_b_d = muDoubleScalarFloor(c17_b_table[0U].SimMin * 131072.0);
    if (c17_b_d < 131072.0) {
      if (c17_b_d >= -131072.0) {
        c17_i = (int32_T)c17_b_d;
      } else {
        c17_i = -131072;
      }
    } else if (c17_b_d >= 131072.0) {
      c17_i = 131071;
    } else {
      c17_i = 0;
    }

    c17_localMin = c17_i;
    c17_d1 = muDoubleScalarFloor(c17_b_table[0U].SimMax * 131072.0);
    if (c17_d1 < 131072.0) {
      if (c17_d1 >= -131072.0) {
        c17_i1 = (int32_T)c17_d1;
      } else {
        c17_i1 = -131072;
      }
    } else if (c17_d1 >= 131072.0) {
      c17_i1 = 131071;
    } else {
      c17_i1 = 0;
    }

    c17_localMax = c17_i1;
    c17_histTable = c17_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c17_in < c17_localMin) {
      c17_localMin = c17_in;
    }

    if (c17_in > c17_localMax) {
      c17_localMax = c17_in;
    }

    /* Histogram logging. */
    c17_inDouble = (real_T)c17_in * 7.62939453125E-6;
    c17_histTable->TotalNumberOfValues++;
    if (c17_inDouble == 0.0) {
      c17_histTable->NumberOfZeros++;
    } else {
      c17_histTable->SimSum += c17_inDouble;
      if ((!muDoubleScalarIsInf(c17_inDouble)) && (!muDoubleScalarIsNaN
           (c17_inDouble))) {
        c17_significand = frexp(c17_inDouble, &c17_exponent);
        if (c17_exponent > 128) {
          c17_exponent = 128;
        }

        if (c17_exponent < -127) {
          c17_exponent = -127;
        }

        if (c17_significand < 0.0) {
          c17_histTable->NumberOfNegativeValues++;
          c17_histTable->HistogramOfNegativeValues[127 + c17_exponent]++;
        } else {
          c17_histTable->NumberOfPositiveValues++;
          c17_histTable->HistogramOfPositiveValues[127 + c17_exponent]++;
        }
      }
    }

    c17_b_table[0U].SimMin = (real_T)c17_localMin * 7.62939453125E-6;
    c17_b_table[0U].SimMax = (real_T)c17_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c17_in & 131071U) != 0U) {
      c17_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c17_in;
}

static void c17_emlrt_update_log_2
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[5], emlrtLocationLoggingDataType c17_table[], int32_T c17_index,
   int32_T c17_out[5])
{
  int32_T c17_i;
  for (c17_i = 0; c17_i < 5; c17_i++) {
    c17_out[c17_i] = c17_in[c17_i];
  }

  c17_b_emlrt_update_log_2(chartInstance, c17_out, c17_table, c17_index);
}

static void c17_emlrt_update_log_3
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[4], emlrtLocationLoggingDataType c17_table[], int32_T c17_index,
   int32_T c17_out[4])
{
  int32_T c17_i;
  for (c17_i = 0; c17_i < 4; c17_i++) {
    c17_out[c17_i] = c17_in[c17_i];
  }

  c17_b_emlrt_update_log_3(chartInstance, c17_out, c17_table, c17_index);
}

static boolean_T c17_emlrt_update_log_4
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c17_in, emlrtLocationLoggingDataType c17_table[], int32_T c17_index)
{
  boolean_T c17_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c17_b_table;
  boolean_T c17_localMin;
  boolean_T c17_localMax;
  emlrtLocationLoggingHistogramType *c17_histTable;
  real_T c17_inDouble;
  real_T c17_significand;
  int32_T c17_exponent;
  (void)chartInstance;
  c17_isLoggingEnabledHere = (c17_index >= 0);
  if (c17_isLoggingEnabledHere) {
    c17_b_table = (emlrtLocationLoggingDataType *)&c17_table[c17_index];
    c17_localMin = (c17_b_table[0U].SimMin > 0.0);
    c17_localMax = (c17_b_table[0U].SimMax > 0.0);
    c17_histTable = c17_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c17_in < (int32_T)c17_localMin) {
      c17_localMin = c17_in;
    }

    if ((int32_T)c17_in > (int32_T)c17_localMax) {
      c17_localMax = c17_in;
    }

    /* Histogram logging. */
    c17_inDouble = (real_T)c17_in;
    c17_histTable->TotalNumberOfValues++;
    if (c17_inDouble == 0.0) {
      c17_histTable->NumberOfZeros++;
    } else {
      c17_histTable->SimSum += c17_inDouble;
      if ((!muDoubleScalarIsInf(c17_inDouble)) && (!muDoubleScalarIsNaN
           (c17_inDouble))) {
        c17_significand = frexp(c17_inDouble, &c17_exponent);
        if (c17_exponent > 128) {
          c17_exponent = 128;
        }

        if (c17_exponent < -127) {
          c17_exponent = -127;
        }

        if (c17_significand < 0.0) {
          c17_histTable->NumberOfNegativeValues++;
          c17_histTable->HistogramOfNegativeValues[127 + c17_exponent]++;
        } else {
          c17_histTable->NumberOfPositiveValues++;
          c17_histTable->HistogramOfPositiveValues[127 + c17_exponent]++;
        }
      }
    }

    c17_b_table[0U].SimMin = (real_T)c17_localMin;
    c17_b_table[0U].SimMax = (real_T)c17_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c17_in;
}

static void c17_emlrtInitVarDataTables
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c17_dataTables[52],
   emlrtLocationLoggingHistogramType c17_histTables[52])
{
  int32_T c17_i;
  int32_T c17_iH;
  (void)chartInstance;
  for (c17_i = 0; c17_i < 52; c17_i++) {
    c17_dataTables[c17_i].SimMin = rtInf;
    c17_dataTables[c17_i].SimMax = rtMinusInf;
    c17_dataTables[c17_i].OverflowWraps = 0;
    c17_dataTables[c17_i].Saturations = 0;
    c17_dataTables[c17_i].IsAlwaysInteger = true;
    c17_dataTables[c17_i].HistogramTable = &c17_histTables[c17_i];
    c17_histTables[c17_i].NumberOfZeros = 0.0;
    c17_histTables[c17_i].NumberOfPositiveValues = 0.0;
    c17_histTables[c17_i].NumberOfNegativeValues = 0.0;
    c17_histTables[c17_i].TotalNumberOfValues = 0.0;
    c17_histTables[c17_i].SimSum = 0.0;
    for (c17_iH = 0; c17_iH < 256; c17_iH++) {
      c17_histTables[c17_i].HistogramOfPositiveValues[c17_iH] = 0.0;
      c17_histTables[c17_i].HistogramOfNegativeValues[c17_iH] = 0.0;
    }
  }
}

const mxArray *sf_c17_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c17_nameCaptureInfo = NULL;
  c17_nameCaptureInfo = NULL;
  sf_mex_assign(&c17_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c17_nameCaptureInfo;
}

static int32_T c17_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_y, const char_T *c17_identifier)
{
  int32_T c17_c_y;
  emlrtMsgIdentifier c17_thisId;
  c17_thisId.fIdentifier = (const char *)c17_identifier;
  c17_thisId.fParent = NULL;
  c17_thisId.bParentIsCell = false;
  c17_c_y = c17_b_emlrt_marshallIn(chartInstance, c17_sp, sf_mex_dup(c17_b_y),
    &c17_thisId);
  sf_mex_destroy(&c17_b_y);
  return c17_c_y;
}

static int32_T c17_b_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_u, const emlrtMsgIdentifier
   *c17_parentId)
{
  int32_T c17_b_y;
  const mxArray *c17_mxFi = NULL;
  const mxArray *c17_mxInt = NULL;
  int32_T c17_i;
  (void)chartInstance;
  sf_mex_check_fi(c17_parentId, c17_b_u, false, 0U, NULL, c17_eml_mx,
                  c17_b_eml_mx);
  sf_mex_assign(&c17_mxFi, sf_mex_dup(c17_b_u), false);
  sf_mex_assign(&c17_mxInt, sf_mex_call(c17_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c17_mxFi)), false);
  sf_mex_import(c17_parentId, sf_mex_dup(c17_mxInt), &c17_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c17_mxFi);
  sf_mex_destroy(&c17_mxInt);
  c17_b_y = c17_i;
  sf_mex_destroy(&c17_mxFi);
  sf_mex_destroy(&c17_b_u);
  return c17_b_y;
}

static void c17_c_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_d, const char_T *c17_identifier,
   boolean_T *c17_svPtr, int32_T c17_b_y[5])
{
  emlrtMsgIdentifier c17_thisId;
  c17_thisId.fIdentifier = (const char *)c17_identifier;
  c17_thisId.fParent = NULL;
  c17_thisId.bParentIsCell = false;
  c17_d_emlrt_marshallIn(chartInstance, c17_sp, sf_mex_dup(c17_b_d), &c17_thisId,
    c17_svPtr, c17_b_y);
  sf_mex_destroy(&c17_b_d);
}

static void c17_d_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c17_sp, const mxArray *c17_b_u, const emlrtMsgIdentifier
   *c17_parentId, boolean_T *c17_svPtr, int32_T c17_b_y[5])
{
  int32_T c17_i;
  uint32_T c17_uv[2];
  const mxArray *c17_mxFi = NULL;
  const mxArray *c17_mxInt = NULL;
  int32_T c17_iv[5];
  int32_T c17_i1;
  (void)chartInstance;
  for (c17_i = 0; c17_i < 2; c17_i++) {
    c17_uv[c17_i] = 1U + ((uint32_T)c17_i << 2);
  }

  if (mxIsEmpty(c17_b_u)) {
    *c17_svPtr = false;
  } else {
    *c17_svPtr = true;
    sf_mex_check_fi(c17_parentId, c17_b_u, false, 2U, c17_uv, c17_eml_mx,
                    c17_b_eml_mx);
    sf_mex_assign(&c17_mxFi, sf_mex_dup(c17_b_u), false);
    sf_mex_assign(&c17_mxInt, sf_mex_call(c17_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c17_mxFi)), false);
    sf_mex_import(c17_parentId, sf_mex_dup(c17_mxInt), c17_iv, 1, 6, 0U, 1, 0U,
                  2, 1, 5);
    sf_mex_destroy(&c17_mxFi);
    sf_mex_destroy(&c17_mxInt);
    for (c17_i1 = 0; c17_i1 < 5; c17_i1++) {
      c17_b_y[c17_i1] = c17_iv[c17_i1];
    }
  }

  sf_mex_destroy(&c17_mxFi);
  sf_mex_destroy(&c17_b_u);
}

static uint8_T c17_e_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c17_b_is_active_c17_zeabus_hydrophone_concrete, const char_T *c17_identifier)
{
  uint8_T c17_b_y;
  emlrtMsgIdentifier c17_thisId;
  c17_thisId.fIdentifier = (const char *)c17_identifier;
  c17_thisId.fParent = NULL;
  c17_thisId.bParentIsCell = false;
  c17_b_y = c17_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c17_b_is_active_c17_zeabus_hydrophone_concrete), &c17_thisId);
  sf_mex_destroy(&c17_b_is_active_c17_zeabus_hydrophone_concrete);
  return c17_b_y;
}

static uint8_T c17_f_emlrt_marshallIn
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c17_b_u, const emlrtMsgIdentifier *c17_parentId)
{
  uint8_T c17_b_y;
  uint8_T c17_c_u;
  (void)chartInstance;
  sf_mex_import(c17_parentId, sf_mex_dup(c17_b_u), &c17_c_u, 1, 3, 0U, 0, 0U, 0);
  c17_b_y = c17_c_u;
  sf_mex_destroy(&c17_b_u);
  return c17_b_y;
}

static const mxArray *c17_chart_data_browse_helper
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_ssIdNumber)
{
  const mxArray *c17_mxData = NULL;
  int32_T c17_i;
  int32_T c17_i1;
  real_T c17_b_d;
  real_T c17_d1;
  c17_mxData = NULL;
  switch (c17_ssIdNumber) {
   case 4U:
    c17_i = *chartInstance->c17_u;
    c17_b_d = (real_T)c17_i * 7.62939453125E-6;
    sf_mex_assign(&c17_mxData, sf_mex_create("mxData", &c17_b_d, 0, 0U, 0U, 0U,
      0), false);
    break;

   case 5U:
    c17_i1 = *chartInstance->c17_y;
    c17_d1 = (real_T)c17_i1 * 7.62939453125E-6;
    sf_mex_assign(&c17_mxData, sf_mex_create("mxData", &c17_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c17_mxData;
}

static void c17_b_emlrt_update_log_2
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[5], emlrtLocationLoggingDataType c17_table[], int32_T c17_index)
{
  boolean_T c17_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c17_b_table;
  real_T c17_b_d;
  int32_T c17_i;
  int32_T c17_localMin;
  real_T c17_d1;
  int32_T c17_i1;
  int32_T c17_localMax;
  emlrtLocationLoggingHistogramType *c17_histTable;
  int32_T c17_b_i;
  int32_T c17_c_i;
  real_T c17_inDouble;
  real_T c17_significand;
  int32_T c17_exponent;
  (void)chartInstance;
  c17_isLoggingEnabledHere = (c17_index >= 0);
  if (c17_isLoggingEnabledHere) {
    c17_b_table = (emlrtLocationLoggingDataType *)&c17_table[c17_index];
    c17_b_d = muDoubleScalarFloor(c17_b_table[0U].SimMin * 131072.0);
    if (c17_b_d < 131072.0) {
      if (c17_b_d >= -131072.0) {
        c17_i = (int32_T)c17_b_d;
      } else {
        c17_i = -131072;
      }
    } else if (c17_b_d >= 131072.0) {
      c17_i = 131071;
    } else {
      c17_i = 0;
    }

    c17_localMin = c17_i;
    c17_d1 = muDoubleScalarFloor(c17_b_table[0U].SimMax * 131072.0);
    if (c17_d1 < 131072.0) {
      if (c17_d1 >= -131072.0) {
        c17_i1 = (int32_T)c17_d1;
      } else {
        c17_i1 = -131072;
      }
    } else if (c17_d1 >= 131072.0) {
      c17_i1 = 131071;
    } else {
      c17_i1 = 0;
    }

    c17_localMax = c17_i1;
    c17_histTable = c17_b_table[0U].HistogramTable;
    for (c17_b_i = 0; c17_b_i < 5; c17_b_i++) {
      /* Simulation Min-Max logging. */
      if (c17_in[c17_b_i] < c17_localMin) {
        c17_localMin = c17_in[c17_b_i];
      }

      if (c17_in[c17_b_i] > c17_localMax) {
        c17_localMax = c17_in[c17_b_i];
      }

      /* Histogram logging. */
      c17_inDouble = (real_T)c17_in[c17_b_i] * 7.62939453125E-6;
      c17_histTable->TotalNumberOfValues++;
      if (c17_inDouble == 0.0) {
        c17_histTable->NumberOfZeros++;
      } else {
        c17_histTable->SimSum += c17_inDouble;
        if ((!muDoubleScalarIsInf(c17_inDouble)) && (!muDoubleScalarIsNaN
             (c17_inDouble))) {
          c17_significand = frexp(c17_inDouble, &c17_exponent);
          if (c17_exponent > 128) {
            c17_exponent = 128;
          }

          if (c17_exponent < -127) {
            c17_exponent = -127;
          }

          if (c17_significand < 0.0) {
            c17_histTable->NumberOfNegativeValues++;
            c17_histTable->HistogramOfNegativeValues[127 + c17_exponent]++;
          } else {
            c17_histTable->NumberOfPositiveValues++;
            c17_histTable->HistogramOfPositiveValues[127 + c17_exponent]++;
          }
        }
      }
    }

    c17_b_table[0U].SimMin = (real_T)c17_localMin * 7.62939453125E-6;
    c17_b_table[0U].SimMax = (real_T)c17_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c17_c_i = 0;
    while (c17_b_table[0U].IsAlwaysInteger && (c17_c_i < 5)) {
      if (((uint32_T)c17_in[c17_c_i] & 131071U) != 0U) {
        c17_b_table[0U].IsAlwaysInteger = false;
      }

      c17_c_i++;
    }
  }
}

static void c17_b_emlrt_update_log_3
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c17_in[4], emlrtLocationLoggingDataType c17_table[], int32_T c17_index)
{
  boolean_T c17_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c17_b_table;
  real_T c17_b_d;
  int32_T c17_i;
  int32_T c17_localMin;
  real_T c17_d1;
  int32_T c17_i1;
  int32_T c17_localMax;
  emlrtLocationLoggingHistogramType *c17_histTable;
  int32_T c17_b_i;
  int32_T c17_c_i;
  real_T c17_inDouble;
  real_T c17_significand;
  int32_T c17_exponent;
  (void)chartInstance;
  c17_isLoggingEnabledHere = (c17_index >= 0);
  if (c17_isLoggingEnabledHere) {
    c17_b_table = (emlrtLocationLoggingDataType *)&c17_table[c17_index];
    c17_b_d = muDoubleScalarFloor(c17_b_table[0U].SimMin * 131072.0);
    if (c17_b_d < 131072.0) {
      if (c17_b_d >= -131072.0) {
        c17_i = (int32_T)c17_b_d;
      } else {
        c17_i = -131072;
      }
    } else if (c17_b_d >= 131072.0) {
      c17_i = 131071;
    } else {
      c17_i = 0;
    }

    c17_localMin = c17_i;
    c17_d1 = muDoubleScalarFloor(c17_b_table[0U].SimMax * 131072.0);
    if (c17_d1 < 131072.0) {
      if (c17_d1 >= -131072.0) {
        c17_i1 = (int32_T)c17_d1;
      } else {
        c17_i1 = -131072;
      }
    } else if (c17_d1 >= 131072.0) {
      c17_i1 = 131071;
    } else {
      c17_i1 = 0;
    }

    c17_localMax = c17_i1;
    c17_histTable = c17_b_table[0U].HistogramTable;
    for (c17_b_i = 0; c17_b_i < 4; c17_b_i++) {
      /* Simulation Min-Max logging. */
      if (c17_in[c17_b_i] < c17_localMin) {
        c17_localMin = c17_in[c17_b_i];
      }

      if (c17_in[c17_b_i] > c17_localMax) {
        c17_localMax = c17_in[c17_b_i];
      }

      /* Histogram logging. */
      c17_inDouble = (real_T)c17_in[c17_b_i] * 7.62939453125E-6;
      c17_histTable->TotalNumberOfValues++;
      if (c17_inDouble == 0.0) {
        c17_histTable->NumberOfZeros++;
      } else {
        c17_histTable->SimSum += c17_inDouble;
        if ((!muDoubleScalarIsInf(c17_inDouble)) && (!muDoubleScalarIsNaN
             (c17_inDouble))) {
          c17_significand = frexp(c17_inDouble, &c17_exponent);
          if (c17_exponent > 128) {
            c17_exponent = 128;
          }

          if (c17_exponent < -127) {
            c17_exponent = -127;
          }

          if (c17_significand < 0.0) {
            c17_histTable->NumberOfNegativeValues++;
            c17_histTable->HistogramOfNegativeValues[127 + c17_exponent]++;
          } else {
            c17_histTable->NumberOfPositiveValues++;
            c17_histTable->HistogramOfPositiveValues[127 + c17_exponent]++;
          }
        }
      }
    }

    c17_b_table[0U].SimMin = (real_T)c17_localMin * 7.62939453125E-6;
    c17_b_table[0U].SimMax = (real_T)c17_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c17_c_i = 0;
    while (c17_b_table[0U].IsAlwaysInteger && (c17_c_i < 4)) {
      if (((uint32_T)c17_in[c17_c_i] & 131071U) != 0U) {
        c17_b_table[0U].IsAlwaysInteger = false;
      }

      c17_c_i++;
    }
  }
}

static void init_dsm_address_info(SFc17_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c17_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c17_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c17_u = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c17_y = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c17_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2929868855U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(436972284U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(707407755U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(719007121U);
}

mxArray *sf_c17_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c17_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c17_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c17_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiCewMzAwAakOYCYiQECWKF8RiBmhtIQcRa4uAIQl1QWpILEi4uSPVOAdF5iLpi"
    "fWFrhmZeWDzbfggFhPhsW8xmRzOeEikPAB3vK9Is4gPQbIOlnIaBfAMiqhIYLLHzIt1/AgTL9EP"
    "tJdX8KVN8FBvzxyogWr0xQPkhPDkMmQwHUHAcC7mdCc78AzPEOMQ5guiGGKuFAeXwoUMUdEQTiQ"
    "wMlPiD8zOL4xOSSzLLU+GRD8/iq1MSk0uL4jMqUovyCjPw8oGh+XnJRakkqzJ8ALB0nEw=="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c17_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "s2lfbEDUyQjWCMMTPbwPIdD";
}

static void sf_opaque_initialize_c17_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c17_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c17_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c17_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c17_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c17_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c17_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc17_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c17_zeabus_hydrophone_concrete
      ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc17_zeabus_hydrophone_concrete
    ((SFc17_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c17_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c17_zeabus_hydrophone_concrete
      ((SFc17_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc17_zeabus_hydrophone_concrete
      ((SFc17_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c17_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [17] = {
    "eNrtVstu00AUddKAWlGqIIFAgkV3dMEC2MCO0DxEpIQG0geLStHEvomHjGfMPJKGFTs2LPgAdvw",
    "QP8COD+ATuHacNnJspyGlQgJLznicc8+c+5jrsXL1poXXFt53bljWVRzX8c5bk+tKNM/N3JP3Be",
    "t+NP+KIG68FpHEU1bmxYkHr0EJZjQVvM57IhFGeQ8kcBuxvpA6jU1RzzDKBzXD7YBPHbnUdtuuM",
    "MzZRVvi7HE2Rjbf6BbyVKgEW9cAHO1KYfpujZH+qWKpR2UX7IEyXpYLCnTb+IEs1TRMU59B9QTs",
    "OleaoGJ1pq2tiYayPkl1M/BUtadA4fmMEp7orUtUG3wMsIYD38HfPaPRqTjMdonUu+CSIagGHYS",
    "cgkOckyr8o0s50UJSwqoeKweG89paDPU0hQMsIyCobVcCGfiCcp2e/3YNPa1y0mVQga7pp7O14Z",
    "0Jkn9IYQQyNW69shiCJH3Y46mLhgGpnoTZOq2SeZimHhwS+dzG/ClwUqsXK0e1CeYJ9tEiDQahk",
    "3W1L+kQw5vKZrx6UJmLtozxJslWi2AhW3UIWVk4ZavZvEwYU6mwfeE3YAgsZK0QTbJhE9ZknC+F",
    "T/pYtQ4GOSjxsuAOncuFbZQWXhnLrdJovMROkSzuDFbnGmSP2JC0b5XtgmMYoKPYmXS4XAKpQ1W",
    "QrQWoKKeLUJbqGV4ZCTlARzO2/ZkLQQ5SgZ7qY/Sxdg8UlnkWLIj+Qty0zz+0zvr85jn6/NQuPu",
    "7M8OQSeKyZMb7uRj573Tw+5SK70ozd9dg6hZhdgCvi/aX66bu4u/7x8NbmEf/x4NpK6xeW+y5uR",
    "fN70wZ0Wp7DuaoIsC9mdBUS+G/P8BejuXrMet1q5WD86u1Rudncb3VHrbpTCfk+r2XrXYvpnb7f",
    "Djrh2A/7mpJ23Yk+2MGcmMlnLOB/OqP36oJ4bETvJ9fPZ6vZ3yzF81hYYF/Ep3Gsbn9//WJpNfv",
    "5fXAe/U5k981arg7z0TywYRa1/IT9lKQ/H9NfnIovHZfC8cPxhcRh9XxsX4iONwvysRPbfzvh+a",
    "ND8DQxhI796EnnPZCuUR137OCXzsUTV8cW3JagYesC+t+ydtZ/u7/CLvcP+nee88Rl21mXbLeqf",
    "8ueq1Y5h8X7nRXDF1dY50/jVz2PLoP/BSuJaQg=",
    ""
  };

  static char newstr [1165] = "";
  newstr[0] = '\0';
  for (i = 0; i < 17; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c17_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c17_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(3716957596U));
  ssSetChecksum1(S,(2265455471U));
  ssSetChecksum2(S,(1460409686U));
  ssSetChecksum3(S,(187491438U));
}

static void mdlRTW_c17_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c17_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc17_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc17_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc17_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc17_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c17_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c17_zeabus_hydrophone_concrete;
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
    chartInstance->c17_JITStateAnimation,
    chartInstance->c17_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c17_zeabus_hydrophone_concrete(chartInstance);
}

void c17_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c17_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c17_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c17_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c17_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
