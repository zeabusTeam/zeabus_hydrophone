/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c12_zeabus_hydrophone_concrete.h"
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
static const mxArray *c12_eml_mx;
static const mxArray *c12_b_eml_mx;
static const mxArray *c12_c_eml_mx;
static const mxArray *c12_d_eml_mx;
static emlrtRSInfo c12_emlrtRSI = { 3, /* lineNo */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:584"    /* pathName */
};

static emlrtRSInfo c12_b_emlrtRSI = { 56,/* lineNo */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fcnName */
  "#zeabus_hydrophone_concrete:584"    /* pathName */
};

static emlrtDCInfo c12_emlrtDCI = { 25,/* lineNo */
  9,                                   /* colNo */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c12_emlrtBCI = { 1, /* iFirst */
  64,                                  /* iLast */
  25,                                  /* lineNo */
  9,                                   /* colNo */
  "fifo",                              /* aName */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  3                                    /* checkKind */
};

static emlrtDCInfo c12_b_emlrtDCI = { 29,/* lineNo */
  9,                                   /* colNo */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c12_b_emlrtBCI = { 1,/* iFirst */
  64,                                  /* iLast */
  29,                                  /* lineNo */
  9,                                   /* colNo */
  "fifo",                              /* aName */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  3                                    /* checkKind */
};

static emlrtDCInfo c12_c_emlrtDCI = { 33,/* lineNo */
  9,                                   /* colNo */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c12_c_emlrtBCI = { 1,/* iFirst */
  64,                                  /* iLast */
  33,                                  /* lineNo */
  9,                                   /* colNo */
  "fifo",                              /* aName */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  3                                    /* checkKind */
};

static emlrtDCInfo c12_d_emlrtDCI = { 37,/* lineNo */
  9,                                   /* colNo */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c12_d_emlrtBCI = { 1,/* iFirst */
  64,                                  /* iLast */
  37,                                  /* lineNo */
  9,                                   /* colNo */
  "fifo",                              /* aName */
  "Hydrophone processing/Trigger/Trigger_FixPt",/* fName */
  "#zeabus_hydrophone_concrete:584",   /* pName */
  3                                    /* checkKind */
};

/* Function Declarations */
static void initialize_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void initialize_params_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void enable_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void disable_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c12_update_jit_animation_state_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c12_do_animation_call_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void ext_mode_exec_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void set_sim_state_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c12_st);
static void finalize_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void sf_gateway_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void mdl_start_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static void c12_chartstep_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp);
static void initSimStructsc12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);
static int32_T c12_emlrt_update_log_1
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static uint16_T c12_emlrt_update_log_2
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint16_T
   c12_in, emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static uint8_T c12_emlrt_update_log_3
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static void c12_emlrt_update_log_4
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[256], emlrtLocationLoggingDataType c12_table[], int32_T c12_index,
   int32_T c12_out[256]);
static boolean_T c12_emlrt_update_log_5
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c12_in, emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static uint32_T c12_emlrt_update_log_6
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint32_T
   c12_in, emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static void c12_emlrt_update_log_7
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[252], emlrtLocationLoggingDataType c12_table[], int32_T c12_index,
   int32_T c12_out[252]);
static int16_T c12_emlrt_update_log_8
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int16_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static int8_T c12_emlrt_update_log_9
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int8_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static uint8_T c12_emlrt_update_log_10
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static void c12_emlrtInitVarDataTables
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c12_dataTables[59],
   emlrtLocationLoggingHistogramType c12_histTables[59]);
static int32_T c12_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_o1, const char_T *c12_identifier);
static int32_T c12_b_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId);
static uint32_T c12_c_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_trigged, const char_T
   *c12_identifier);
static uint32_T c12_d_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId);
static uint8_T c12_e_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_after, const char_T *c12_identifier,
   boolean_T *c12_svPtr);
static uint8_T c12_f_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId, boolean_T *c12_svPtr);
static void c12_g_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_fifo, const char_T *c12_identifier,
   boolean_T *c12_svPtr, int32_T c12_y[256]);
static void c12_h_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId, boolean_T *c12_svPtr, int32_T c12_y[256]);
static uint8_T c12_i_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c12_b_is_active_c12_zeabus_hydrophone_concrete, const char_T *c12_identifier);
static uint8_T c12_j_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c12_u, const emlrtMsgIdentifier *c12_parentId);
static const mxArray *c12_chart_data_browse_helper
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_ssIdNumber);
static void c12_b_emlrt_update_log_4
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[256], emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static void c12_b_emlrt_update_log_7
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[252], emlrtLocationLoggingDataType c12_table[], int32_T c12_index);
static uint32_T c12__u32_add__(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c12_b, uint32_T c12_c, int32_T c12_EMLOvCount_src_loc,
  uint32_T c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T
  c12_length_src_loc);
static uint8_T c12__u8_u32_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc);
static uint8_T c12__u8_s16_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int16_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc);
static int32_T c12__s32_minus__(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c12_b, int32_T c12_c, int32_T c12_EMLOvCount_src_loc,
  uint32_T c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T
  c12_length_src_loc);
static int16_T c12__s16_s32_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc);
static int8_T c12__s8_u8_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint8_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc);
static int32_T c12__s32_uminus__(SFc12_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc);
static void init_dsm_address_info(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance);
static void init_simulink_io_address
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c12_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c12_st.tls = chartInstance->c12_fEmlrtCtx;
  emlrtLicenseCheckR2012b(&c12_st, "Fixed_Point_Toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  chartInstance->c12_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c12_after_not_empty = false;
  chartInstance->c12_before_not_empty = false;
  chartInstance->c12_fifo_not_empty = false;
  chartInstance->c12_is_active_c12_zeabus_hydrophone_concrete = 0U;
  sf_mex_assign(&c12_d_eml_mx, sf_mex_call(&c12_st, "numerictype", 1U, 14U, 15,
    "SignednessBool", 3, false, 15, "Signedness", 15, "Unsigned", 15,
    "WordLength", 6, 7.0, 15, "FractionLength", 6, 0.0, 15, "BinaryPoint", 6,
    0.0, 15, "Slope", 6, 1.0, 15, "FixedExponent", 6, 0.0), true);
  sf_mex_assign(&c12_c_eml_mx, sf_mex_call(&c12_st, "numerictype", 1U, 14U, 15,
    "SignednessBool", 3, false, 15, "Signedness", 15, "Unsigned", 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c12_b_eml_mx, sf_mex_call(&c12_st, "numerictype", 1U, 10U, 15,
    "WordLength", 6, 18.0, 15, "FractionLength", 6, 17.0, 15, "BinaryPoint", 6,
    17.0, 15, "Slope", 6, 7.62939453125E-6, 15, "FixedExponent", 6, -17.0), true);
  sf_mex_assign(&c12_eml_mx, sf_mex_call(&c12_st, "fimath", 1U, 42U, 15,
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
  chartInstance->c12_emlrtLocLogSimulated = false;
  c12_emlrtInitVarDataTables(chartInstance,
    chartInstance->c12_emlrtLocationLoggingDataTables,
    chartInstance->c12_emlrtLocLogHistTables);
}

static void initialize_params_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c12_update_jit_animation_state_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c12_do_animation_call_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  sfDoAnimationWrapper(chartInstance->S, false, true);
  sfDoAnimationWrapper(chartInstance->S, false, false);
}

static void ext_mode_exec_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const mxArray *c12_st;
  const mxArray *c12_y = NULL;
  const mxArray *c12_b_y = NULL;
  int32_T c12_u;
  const mxArray *c12_c_y = NULL;
  const mxArray *c12_d_y = NULL;
  int32_T c12_b_u;
  const mxArray *c12_e_y = NULL;
  const mxArray *c12_f_y = NULL;
  int32_T c12_c_u;
  const mxArray *c12_g_y = NULL;
  const mxArray *c12_h_y = NULL;
  int32_T c12_d_u;
  const mxArray *c12_i_y = NULL;
  const mxArray *c12_j_y = NULL;
  uint32_T c12_e_u;
  const mxArray *c12_k_y = NULL;
  const mxArray *c12_l_y = NULL;
  uint8_T c12_f_u;
  const mxArray *c12_m_y = NULL;
  const mxArray *c12_n_y = NULL;
  uint8_T c12_g_u;
  const mxArray *c12_o_y = NULL;
  const mxArray *c12_p_y = NULL;
  int32_T c12_i;
  const mxArray *c12_q_y = NULL;
  int32_T c12_h_u[256];
  const mxArray *c12_r_y = NULL;
  c12_st = NULL;
  c12_st = NULL;
  c12_y = NULL;
  sf_mex_assign(&c12_y, sf_mex_createcellmatrix(9, 1), false);
  c12_b_y = NULL;
  c12_u = *chartInstance->c12_o1;
  c12_c_y = NULL;
  sf_mex_assign(&c12_c_y, sf_mex_create("y", &c12_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c12_b_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
    (c12_b_eml_mx), "simulinkarray", c12_c_y, false, false), false);
  sf_mex_setcell(c12_y, 0, c12_b_y);
  c12_d_y = NULL;
  c12_b_u = *chartInstance->c12_o2;
  c12_e_y = NULL;
  sf_mex_assign(&c12_e_y, sf_mex_create("y", &c12_b_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c12_d_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
    (c12_b_eml_mx), "simulinkarray", c12_e_y, false, false), false);
  sf_mex_setcell(c12_y, 1, c12_d_y);
  c12_f_y = NULL;
  c12_c_u = *chartInstance->c12_o3;
  c12_g_y = NULL;
  sf_mex_assign(&c12_g_y, sf_mex_create("y", &c12_c_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c12_f_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
    (c12_b_eml_mx), "simulinkarray", c12_g_y, false, false), false);
  sf_mex_setcell(c12_y, 2, c12_f_y);
  c12_h_y = NULL;
  c12_d_u = *chartInstance->c12_o4;
  c12_i_y = NULL;
  sf_mex_assign(&c12_i_y, sf_mex_create("y", &c12_d_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c12_h_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
    (c12_b_eml_mx), "simulinkarray", c12_i_y, false, false), false);
  sf_mex_setcell(c12_y, 3, c12_h_y);
  c12_j_y = NULL;
  c12_e_u = *chartInstance->c12_trigged;
  c12_k_y = NULL;
  sf_mex_assign(&c12_k_y, sf_mex_create("y", &c12_e_u, 7, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c12_j_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
    (c12_c_eml_mx), "simulinkarray", c12_k_y, false, false), false);
  sf_mex_setcell(c12_y, 4, c12_j_y);
  c12_l_y = NULL;
  if (!chartInstance->c12_after_not_empty) {
    sf_mex_assign(&c12_l_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c12_f_u = chartInstance->c12_after;
    c12_m_y = NULL;
    sf_mex_assign(&c12_m_y, sf_mex_create("y", &c12_f_u, 3, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c12_l_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
      (c12_d_eml_mx), "simulinkarray", c12_m_y, true, false), false);
  }

  sf_mex_setcell(c12_y, 5, c12_l_y);
  c12_n_y = NULL;
  if (!chartInstance->c12_after_not_empty) {
    sf_mex_assign(&c12_n_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    c12_g_u = chartInstance->c12_before;
    c12_o_y = NULL;
    sf_mex_assign(&c12_o_y, sf_mex_create("y", &c12_g_u, 3, 0U, 0U, 0U, 0),
                  false);
    sf_mex_assign(&c12_n_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
      (c12_d_eml_mx), "simulinkarray", c12_o_y, true, false), false);
  }

  sf_mex_setcell(c12_y, 6, c12_n_y);
  c12_p_y = NULL;
  if (!chartInstance->c12_fifo_not_empty) {
    sf_mex_assign(&c12_p_y, sf_mex_create("y", NULL, 0, 0U, 1U, 0U, 2, 0, 0),
                  false);
  } else {
    for (c12_i = 0; c12_i < 256; c12_i++) {
      c12_h_u[c12_i] = chartInstance->c12_fifo[c12_i];
    }

    c12_q_y = NULL;
    sf_mex_assign(&c12_q_y, sf_mex_create("y", c12_h_u, 6, 0U, 1U, 0U, 2, 4, 64),
                  false);
    sf_mex_assign(&c12_p_y, sf_mex_create_fi(sf_mex_dup(c12_eml_mx), sf_mex_dup
      (c12_b_eml_mx), "simulinkarray", c12_q_y, true, false), false);
  }

  sf_mex_setcell(c12_y, 7, c12_p_y);
  c12_r_y = NULL;
  sf_mex_assign(&c12_r_y, sf_mex_create("y",
    &chartInstance->c12_is_active_c12_zeabus_hydrophone_concrete, 3, 0U, 0U, 0U,
    0), false);
  sf_mex_setcell(c12_y, 8, c12_r_y);
  sf_mex_assign(&c12_st, c12_y, false);
  return c12_st;
}

static void set_sim_state_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c12_st)
{
  emlrtStack c12_b_st = { NULL,        /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *c12_u;
  int32_T c12_iv[256];
  int32_T c12_i;
  c12_b_st.tls = chartInstance->c12_fEmlrtCtx;
  chartInstance->c12_doneDoubleBufferReInit = true;
  c12_u = sf_mex_dup(c12_st);
  *chartInstance->c12_o1 = c12_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 0)), "o1");
  *chartInstance->c12_o2 = c12_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 1)), "o2");
  *chartInstance->c12_o3 = c12_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 2)), "o3");
  *chartInstance->c12_o4 = c12_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 3)), "o4");
  *chartInstance->c12_trigged = c12_c_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 4)), "trigged");
  chartInstance->c12_after = c12_e_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 5)), "after",
    &chartInstance->c12_after_not_empty);
  chartInstance->c12_before = c12_e_emlrt_marshallIn(chartInstance, &c12_b_st,
    sf_mex_dup(sf_mex_getcell(c12_u, 6)), "before",
    &chartInstance->c12_before_not_empty);
  c12_g_emlrt_marshallIn(chartInstance, &c12_b_st, sf_mex_dup(sf_mex_getcell
    (c12_u, 7)), "fifo", &chartInstance->c12_fifo_not_empty, c12_iv);
  for (c12_i = 0; c12_i < 256; c12_i++) {
    chartInstance->c12_fifo[c12_i] = c12_iv[c12_i];
  }

  chartInstance->c12_is_active_c12_zeabus_hydrophone_concrete =
    c12_i_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c12_u, 8)),
    "is_active_c12_zeabus_hydrophone_concrete");
  sf_mex_destroy(&c12_u);
  sf_mex_destroy(&c12_st);
}

static void finalize_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  const emlrtLocationLoggingFileInfoType c12_emlrtLocationLoggingFileInfo = {
    "#zeabus_hydrophone_concrete:584", /* mexFileName */
    "Thu Apr 16 10:58:00 2020",        /* timestamp */
    "",                                /* buildDir */
    2,                                 /* numFcns */
    256                                /* numHistogramBins */
  };

  const emlrtLocationLoggingFunctionInfoType
    c12_emlrtLocationLoggingFunctionInfoTable[2] = { { "eML_blk_kernel",/* fcnName */
      1,                               /* fcnId */
      57                               /* numInstrPoints */
    }, { "fi_signed",                  /* fcnName */
      115,                             /* fcnId */
      2                                /* numInstrPoints */
    } };

  const emlrtLocationLoggingLocationType c12_emlrtLocationInfo[76] = { { 1,/* MxInfoID */
      59,                              /* TextStart */
      2,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 1,                            /* MxInfoID */
      63,                              /* TextStart */
      2,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 1,                            /* MxInfoID */
      67,                              /* TextStart */
      2,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 1,                            /* MxInfoID */
      71,                              /* TextStart */
      2,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 2,                            /* MxInfoID */
      75,                              /* TextStart */
      9,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      106,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      111,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      134,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      139,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      162,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      167,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      190,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      195,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 5,                            /* MxInfoID */
      218,                             /* TextStart */
      9,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 5,                            /* MxInfoID */
      230,                             /* TextStart */
      28,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      351,                             /* TextStart */
      6,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      409,                             /* TextStart */
      5,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 7,                            /* MxInfoID */
      465,                             /* TextStart */
      4,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      529,                             /* TextStart */
      15,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      551,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      556,                             /* TextStart */
      29,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      608,                             /* TextStart */
      15,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      630,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      635,                             /* TextStart */
      29,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      687,                             /* TextStart */
      15,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      709,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      714,                             /* TextStart */
      29,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      766,                             /* TextStart */
      15,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      788,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      793,                             /* TextStart */
      29,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      829,                             /* TextStart */
      20,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      829,                             /* TextStart */
      7,                               /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      853,                             /* TextStart */
      20,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      853,                             /* TextStart */
      7,                               /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      877,                             /* TextStart */
      20,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      877,                             /* TextStart */
      7,                               /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      901,                             /* TextStart */
      20,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      901,                             /* TextStart */
      7,                               /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      928,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      933,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      960,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      965,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      992,                             /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      997,                             /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1024,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1029,                            /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 9,                            /* MxInfoID */
      1056,                            /* TextStart */
      7,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1092,                            /* TextStart */
      5,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      1115,                            /* TextStart */
      28,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 10,                           /* MxInfoID */
      1154,                            /* TextStart */
      13,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      1201,                            /* TextStart */
      26,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1234,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1239,                            /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1266,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1271,                            /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1298,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1303,                            /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1330,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      true                             /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1335,                            /* TextStart */
      21,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 9,                            /* MxInfoID */
      1362,                            /* TextStart */
      7,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1398,                            /* TextStart */
      5,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 11,                           /* MxInfoID */
      1409,                            /* TextStart */
      37,                              /* TextLength */
      6,                               /* Reason */
      false                            /* MoreLocations */
    }, { 12,                           /* MxInfoID */
      1409,                            /* TextStart */
      16,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      1456,                            /* TextStart */
      28,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 10,                           /* MxInfoID */
      1495,                            /* TextStart */
      13,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1543,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1574,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1605,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 4,                            /* MxInfoID */
      1636,                            /* TextStart */
      2,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 9,                            /* MxInfoID */
      1667,                            /* TextStart */
      7,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 8,                            /* MxInfoID */
      1706,                            /* TextStart */
      28,                              /* TextLength */
      3,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1744,                            /* TextStart */
      6,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 13,                           /* MxInfoID */
      1756,                            /* TextStart */
      27,                              /* TextLength */
      5,                               /* Reason */
      false                            /* MoreLocations */
    }, { 10,                           /* MxInfoID */
      1802,                            /* TextStart */
      13,                              /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    }, { 6,                            /* MxInfoID */
      1875,                            /* TextStart */
      1,                               /* TextLength */
      1,                               /* Reason */
      false                            /* MoreLocations */
    }, { 12,                           /* MxInfoID */
      2057,                            /* TextStart */
      1,                               /* TextLength */
      2,                               /* Reason */
      false                            /* MoreLocations */
    } };

  const int32_T c12_emlrtLocationLoggingFieldCounts[59] = { 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  };

  sfListenerLightTerminate(chartInstance->c12_RuntimeVar);
  if (chartInstance->c12_emlrtLocLogSimulated) {
    emlrtLocationLoggingClearLog("#zeabus_hydrophone_concrete:584");
    emlrtLocationLoggingPushLog(&c12_emlrtLocationLoggingFileInfo,
      c12_emlrtLocationLoggingFunctionInfoTable,
      chartInstance->c12_emlrtLocationLoggingDataTables, c12_emlrtLocationInfo,
      NULL, 0U, c12_emlrtLocationLoggingFieldCounts, NULL);
    addResultsToFPTRepository("#zeabus_hydrophone_concrete:584");
  }

  sf_mex_destroy(&c12_eml_mx);
  sf_mex_destroy(&c12_b_eml_mx);
  sf_mex_destroy(&c12_c_eml_mx);
  sf_mex_destroy(&c12_d_eml_mx);
  covrtDeleteStateflowInstanceData(chartInstance->c12_covrtInstance);
}

static void sf_gateway_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  emlrtStack c12_st = { NULL,          /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  c12_st.tls = chartInstance->c12_fEmlrtCtx;
  chartInstance->c12_JITTransitionAnimation[0] = 0U;
  _sfTime_ = sf_get_time(chartInstance->S);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 4U, (real_T)
                    *chartInstance->c12_threshold);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 3U, (real_T)
                    *chartInstance->c12_i4);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 2U, (real_T)
                    *chartInstance->c12_i3);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 1U, (real_T)
                    *chartInstance->c12_i2);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 0U, (real_T)
                    *chartInstance->c12_i1);
  chartInstance->c12_sfEvent = CALL_EVENT;
  c12_chartstep_c12_zeabus_hydrophone_concrete(chartInstance, &c12_st);
  c12_do_animation_call_c12_zeabus_hydrophone_concrete(chartInstance);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 5U, (real_T)
                    *chartInstance->c12_o1);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 6U, (real_T)
                    *chartInstance->c12_o2);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 7U, (real_T)
                    *chartInstance->c12_o3);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 8U, (real_T)
                    *chartInstance->c12_o4);
  covrtSigUpdateFcn(chartInstance->c12_covrtInstance, 9U, (real_T)
                    *chartInstance->c12_trigged);
}

static void mdl_start_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  static const uint32_T c12_decisionTxtStartIdx = 0U;
  static const uint32_T c12_decisionTxtEndIdx = 0U;
  static const int32_T c12_condTxtStartIdx[4] = { 829, 853, 877, 901 };

  static const int32_T c12_condTxtEndIdx[4] = { 849, 873, 897, 921 };

  static const int32_T c12_postfixPredicateTree[7] = { 0, 1, -2, 2, -2, 3, -2 };

  static const int32_T c12_b_condTxtStartIdx[2] = { 1915, 1930 };

  static const int32_T c12_b_condTxtEndIdx[2] = { 1924, 1943 };

  static const int32_T c12_b_postfixPredicateTree[4] = { 0, 1, -1, -3 };

  setLegacyDebuggerFlag(chartInstance->S, false);
  setDebuggerFlag(chartInstance->S, true);
  setDataBrowseFcn(chartInstance->S, (void *)c12_chart_data_browse_helper);
  chartInstance->c12_RuntimeVar = sfListenerCacheSimStruct(chartInstance->S);
  sim_mode_is_external(chartInstance->S);
  covrtCreateStateflowInstanceData(chartInstance->c12_covrtInstance, 1U, 0U, 1U,
    62U);
  covrtChartInitFcn(chartInstance->c12_covrtInstance, 0U, false, false, false);
  covrtStateInitFcn(chartInstance->c12_covrtInstance, 0U, 0U, false, false,
                    false, 0U, &c12_decisionTxtStartIdx, &c12_decisionTxtEndIdx);
  covrtTransInitFcn(chartInstance->c12_covrtInstance, 0U, 0, NULL, NULL, 0U,
                    NULL);
  covrtEmlInitFcn(chartInstance->c12_covrtInstance, "", 4U, 0U, 3U, 0U, 9U, 0U,
                  0U, 0U, 0U, 0U, 6U, 2U);
  covrtEmlFcnInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 0U,
                     "eML_blk_kernel", 16, -1, 1848);
  covrtEmlFcnInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 1U, "fi_signed",
                     1852, -1, 2126);
  covrtEmlFcnInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 2U, "get_fimath",
                     2128, -1, 2382);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 0U, 325, 344, -1,
                    383);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 1U, 384, 402, -1,
                    440);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 2U, 441, 458, -1,
                    507);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 3U, 825, 921, 1193,
                    1844);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 4U, 1111, 1143, -1,
                    1192);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 5U, 1193, 1227,
                    1534, 1844);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 6U, 1452, 1484, -1,
                    1533);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 7U, 1703, 1735,
                    1789, 1840);
  covrtEmlIfInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 8U, 1912, 1944,
                    2095, 2122);
  covrtEmlMCDCInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 0U, 829, 921, 4U,
                      0U, c12_condTxtStartIdx, c12_condTxtEndIdx, 7U,
                      c12_postfixPredicateTree);
  covrtEmlMCDCInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 1U, 1915, 1944,
                      2U, 4U, c12_b_condTxtStartIdx, c12_b_condTxtEndIdx, 4U,
                      c12_b_postfixPredicateTree);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 0U, 829,
    849, -2, 5U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 1U, 853,
    873, -2, 5U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 2U, 877,
    897, -2, 5U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 3U, 901,
    921, -2, 5U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 4U, 1115,
    1143, -2, 5U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 5U, 1201,
    1227, -2, 4U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 6U, 1456,
    1484, -2, 5U);
  covrtEmlRelationalInitFcn(chartInstance->c12_covrtInstance, 4U, 0U, 7U, 1706,
    1734, -2, 2U);
}

static void c12_chartstep_c12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp)
{
  int32_T c12_PICOffset;
  int32_T c12_b_i1;
  int32_T c12_b_i2;
  int32_T c12_b_i3;
  int32_T c12_b_i4;
  uint16_T c12_b_threshold;
  int32_T c12_varargin_1;
  int32_T c12_b_varargin_1;
  int32_T c12_var1;
  int32_T c12_hfi;
  int32_T c12_c_i1;
  int32_T c12_c_varargin_1;
  int32_T c12_d_varargin_1;
  int32_T c12_b_var1;
  int32_T c12_b_hfi;
  int32_T c12_c_i2;
  int32_T c12_e_varargin_1;
  int32_T c12_f_varargin_1;
  int32_T c12_c_var1;
  int32_T c12_c_hfi;
  int32_T c12_c_i3;
  int32_T c12_g_varargin_1;
  int32_T c12_h_varargin_1;
  int32_T c12_d_var1;
  int32_T c12_d_hfi;
  int32_T c12_c_i4;
  uint16_T c12_i_varargin_1;
  uint16_T c12_j_varargin_1;
  uint16_T c12_e_var1;
  uint16_T c12_e_hfi;
  uint16_T c12_c_threshold;
  int32_T c12_i;
  real_T c12_d;
  int32_T c12_d_i1;
  int32_T c12_k_varargin_1;
  int32_T c12_l_varargin_1;
  int32_T c12_f_var1;
  int32_T c12_f_hfi;
  int32_T c12_d1;
  real_T c12_b_d1;
  int32_T c12_d_i2;
  int32_T c12_m_varargin_1;
  int32_T c12_n_varargin_1;
  int32_T c12_g_var1;
  int32_T c12_g_hfi;
  int32_T c12_d2;
  real_T c12_b_d2;
  int32_T c12_d_i3;
  int32_T c12_o_varargin_1;
  int32_T c12_p_varargin_1;
  int32_T c12_h_var1;
  int32_T c12_h_hfi;
  int32_T c12_d3;
  real_T c12_b_d3;
  int32_T c12_d_i4;
  int32_T c12_q_varargin_1;
  int32_T c12_r_varargin_1;
  int32_T c12_i_var1;
  int32_T c12_i_hfi;
  int32_T c12_d4;
  int32_T c12_xfi;
  int32_T c12_a0;
  int32_T c12_a;
  int32_T c12_b_a0;
  int32_T c12_a1;
  int32_T c12_b_a1;
  boolean_T c12_c;
  int32_T c12_y;
  int32_T c12_i5;
  int32_T c12_yreturn;
  int32_T c12_i6;
  real_T c12_b_d4;
  int32_T c12_c_a0;
  uint16_T c12_b0;
  real_T c12_d5;
  int32_T c12_b_a;
  uint16_T c12_b;
  int32_T c12_d_a0;
  uint16_T c12_b_b0;
  int32_T c12_c_a1;
  uint16_T c12_b1;
  int32_T c12_d_a1;
  uint16_T c12_b_b1;
  int32_T c12_i7;
  int32_T c12_i8;
  boolean_T c12_b_c;
  int32_T c12_i9;
  int32_T c12_i10;
  int32_T c12_i11;
  int32_T c12_i12;
  int32_T c12_i13;
  int32_T c12_i14;
  int32_T c12_i15;
  int32_T c12_i16;
  int32_T c12_i17;
  int32_T c12_i18;
  real_T c12_d6;
  boolean_T c12_guard1 = false;
  int32_T c12_b_xfi;
  int32_T c12_e_a0;
  int32_T c12_c_a;
  int32_T c12_f_a0;
  int32_T c12_e_a1;
  int32_T c12_b_o1;
  int32_T c12_f_a1;
  int32_T c12_b_o2;
  int32_T c12_s_varargin_1;
  boolean_T c12_c_c;
  int32_T c12_b_o3;
  int32_T c12_t_varargin_1;
  int32_T c12_b_o4;
  int32_T c12_j_var1;
  int32_T c12_b_y;
  int32_T c12_i19;
  uint32_T c12_b_trigged;
  int32_T c12_j_hfi;
  int32_T c12_b_yreturn;
  int32_T c12_u_varargin_1;
  int32_T c12_i20;
  real_T c12_d7;
  int32_T c12_v_varargin_1;
  int32_T c12_g_a0;
  int32_T c12_k_var1;
  uint16_T c12_c_b0;
  real_T c12_d8;
  int32_T c12_k_hfi;
  int32_T c12_d_a;
  uint16_T c12_b_b;
  int32_T c12_w_varargin_1;
  int32_T c12_h_a0;
  int32_T c12_x_varargin_1;
  uint16_T c12_d_b0;
  int32_T c12_l_var1;
  int32_T c12_g_a1;
  int32_T c12_l_hfi;
  uint16_T c12_c_b1;
  int32_T c12_h_a1;
  int32_T c12_y_varargin_1;
  uint16_T c12_d_b1;
  int32_T c12_ab_varargin_1;
  int32_T c12_i21;
  int32_T c12_m_var1;
  int32_T c12_m_hfi;
  int32_T c12_i22;
  boolean_T c12_d_c;
  int32_T c12_i23;
  uint8_T c12_i_a0;
  int32_T c12_i24;
  uint8_T c12_e_a;
  uint8_T c12_j_a0;
  int32_T c12_i25;
  uint8_T c12_i_a1;
  uint8_T c12_j_a1;
  int32_T c12_i26;
  boolean_T c12_e_c;
  int32_T c12_i27;
  int32_T c12_i28;
  int32_T c12_i29;
  int32_T c12_i30;
  int32_T c12_i31;
  int32_T c12_i32;
  real_T c12_d9;
  int32_T c12_i33;
  int32_T c12_i34;
  int32_T c12_i35;
  int32_T c12_i36;
  int32_T c12_i37;
  int32_T c12_i38;
  int32_T c12_i39;
  int32_T c12_iv[252];
  int32_T c12_i40;
  real_T c12_d10;
  int32_T c12_c_xfi;
  int32_T c12_k_a0;
  int32_T c12_f_a;
  int32_T c12_l_a0;
  int32_T c12_k_a1;
  int32_T c12_l_a1;
  boolean_T c12_f_c;
  int32_T c12_c_y;
  int32_T c12_i41;
  int32_T c12_c_yreturn;
  int32_T c12_i42;
  real_T c12_d11;
  int32_T c12_m_a0;
  uint16_T c12_e_b0;
  real_T c12_d12;
  int32_T c12_g_a;
  uint16_T c12_c_b;
  int32_T c12_n_a0;
  uint16_T c12_f_b0;
  int32_T c12_m_a1;
  uint16_T c12_e_b1;
  int32_T c12_n_a1;
  uint16_T c12_f_b1;
  int32_T c12_i43;
  int32_T c12_i44;
  boolean_T c12_g_c;
  int32_T c12_i45;
  int32_T c12_i46;
  int32_T c12_i47;
  int32_T c12_i48;
  int32_T c12_i49;
  int32_T c12_i50;
  int32_T c12_i51;
  int32_T c12_i52;
  int32_T c12_i53;
  int32_T c12_i54;
  real_T c12_d13;
  int32_T c12_d_xfi;
  int32_T c12_o_a0;
  int32_T c12_h_a;
  int32_T c12_p_a0;
  int32_T c12_o_a1;
  int32_T c12_p_a1;
  boolean_T c12_h_c;
  int32_T c12_d_y;
  int32_T c12_i55;
  int32_T c12_d_yreturn;
  int32_T c12_i56;
  real_T c12_d14;
  int32_T c12_q_a0;
  uint16_T c12_g_b0;
  real_T c12_d15;
  int32_T c12_i_a;
  uint16_T c12_d_b;
  int32_T c12_r_a0;
  uint16_T c12_h_b0;
  int32_T c12_q_a1;
  uint16_T c12_g_b1;
  int32_T c12_r_a1;
  uint16_T c12_h_b1;
  int32_T c12_i57;
  int32_T c12_i58;
  boolean_T c12_i_c;
  int32_T c12_i59;
  int32_T c12_i60;
  int32_T c12_i61;
  int32_T c12_i62;
  int32_T c12_i63;
  int32_T c12_i64;
  int32_T c12_i65;
  int32_T c12_i66;
  int32_T c12_i67;
  int32_T c12_i68;
  real_T c12_d16;
  uint8_T c12_s_a0;
  uint8_T c12_j_a;
  uint8_T c12_t_a0;
  uint8_T c12_s_a1;
  uint8_T c12_t_a1;
  boolean_T c12_j_c;
  real_T c12_d17;
  int32_T c12_bb_varargin_1;
  int32_T c12_cb_varargin_1;
  int32_T c12_n_var1;
  int32_T c12_n_hfi;
  uint8_T c12_u_a0;
  int32_T c12_db_varargin_1;
  uint8_T c12_k_a;
  int32_T c12_eb_varargin_1;
  uint8_T c12_v_a0;
  int32_T c12_o_var1;
  uint8_T c12_u_a1;
  int32_T c12_o_hfi;
  uint8_T c12_v_a1;
  boolean_T c12_k_c;
  int32_T c12_fb_varargin_1;
  int32_T c12_i69;
  int32_T c12_gb_varargin_1;
  int32_T c12_p_var1;
  int32_T c12_p_hfi;
  int32_T c12_i70;
  int32_T c12_hb_varargin_1;
  int32_T c12_ib_varargin_1;
  int32_T c12_q_var1;
  int32_T c12_q_hfi;
  real_T c12_d18;
  uint8_T c12_l_a;
  int32_T c12_i71;
  uint8_T c12_w_a0;
  int32_T c12_i72;
  uint8_T c12_l_c;
  uint8_T c12_u;
  int32_T c12_i73;
  int32_T c12_i74;
  int32_T c12_i75;
  int32_T c12_iv1[252];
  real_T c12_d19;
  int32_T c12_i76;
  int8_T c12_e_y;
  int8_T c12_x_a0;
  int16_T c12_i77;
  real_T c12_d20;
  real_T c12_d21;
  int16_T c12_i78;
  int16_T c12_i79;
  real_T c12_d22;
  real_T c12_d23;
  int16_T c12_m_c;
  uint8_T c12_u1;
  real_T c12_d24;
  uint8_T c12_y_a0;
  uint8_T c12_m_a;
  uint8_T c12_ab_a0;
  uint8_T c12_w_a1;
  uint8_T c12_x_a1;
  boolean_T c12_n_c;
  int32_T c12_i80;
  int32_T c12_i81;
  real_T c12_d25;
  int32_T c12_i82;
  int32_T c12_i83;
  int32_T c12_i84;
  int32_T c12_i85;
  int32_T c12_i86;
  int32_T c12_iv2[252];
  int32_T c12_i87;
  observerLogReadPIC(&c12_PICOffset);
  c12_b_i1 = *chartInstance->c12_i1;
  c12_b_i2 = *chartInstance->c12_i2;
  c12_b_i3 = *chartInstance->c12_i3;
  c12_b_i4 = *chartInstance->c12_i4;
  c12_b_threshold = *chartInstance->c12_threshold;

  /* logging input variable 'i1' for function 'eML_blk_kernel' */
  /* logging input variable 'i2' for function 'eML_blk_kernel' */
  /* logging input variable 'i3' for function 'eML_blk_kernel' */
  /* logging input variable 'i4' for function 'eML_blk_kernel' */
  /* logging input variable 'threshold' for function 'eML_blk_kernel' */
  chartInstance->c12_emlrtLocLogSimulated = true;

  /* logging input variable 'i1' for function 'eML_blk_kernel' */
  c12_emlrt_update_log_1(chartInstance, c12_b_i1,
    chartInstance->c12_emlrtLocationLoggingDataTables, 0);

  /* logging input variable 'i2' for function 'eML_blk_kernel' */
  c12_emlrt_update_log_1(chartInstance, c12_b_i2,
    chartInstance->c12_emlrtLocationLoggingDataTables, 1);

  /* logging input variable 'i3' for function 'eML_blk_kernel' */
  c12_emlrt_update_log_1(chartInstance, c12_b_i3,
    chartInstance->c12_emlrtLocationLoggingDataTables, 2);

  /* logging input variable 'i4' for function 'eML_blk_kernel' */
  c12_emlrt_update_log_1(chartInstance, c12_b_i4,
    chartInstance->c12_emlrtLocationLoggingDataTables, 3);

  /* logging input variable 'threshold' for function 'eML_blk_kernel' */
  c12_emlrt_update_log_2(chartInstance, c12_b_threshold,
    chartInstance->c12_emlrtLocationLoggingDataTables, 4);
  covrtEmlFcnEval(chartInstance->c12_covrtInstance, 4U, 0, 0);
  covrtEmlFcnEval(chartInstance->c12_covrtInstance, 4U, 0, 2);
  c12_varargin_1 = c12_b_i1;
  c12_b_varargin_1 = c12_varargin_1;
  c12_var1 = c12_b_varargin_1;
  c12_hfi = c12_var1;
  c12_c_i1 = c12_emlrt_update_log_1(chartInstance, c12_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 5);
  c12_c_varargin_1 = c12_b_i2;
  c12_d_varargin_1 = c12_c_varargin_1;
  c12_b_var1 = c12_d_varargin_1;
  c12_b_hfi = c12_b_var1;
  c12_c_i2 = c12_emlrt_update_log_1(chartInstance, c12_b_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 6);
  c12_e_varargin_1 = c12_b_i3;
  c12_f_varargin_1 = c12_e_varargin_1;
  c12_c_var1 = c12_f_varargin_1;
  c12_c_hfi = c12_c_var1;
  c12_c_i3 = c12_emlrt_update_log_1(chartInstance, c12_c_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 7);
  c12_g_varargin_1 = c12_b_i4;
  c12_h_varargin_1 = c12_g_varargin_1;
  c12_d_var1 = c12_h_varargin_1;
  c12_d_hfi = c12_d_var1;
  c12_c_i4 = c12_emlrt_update_log_1(chartInstance, c12_d_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 8);
  c12_i_varargin_1 = c12_b_threshold;
  c12_j_varargin_1 = c12_i_varargin_1;
  c12_e_var1 = c12_j_varargin_1;
  c12_e_hfi = c12_e_var1;
  c12_c_threshold = c12_emlrt_update_log_2(chartInstance, c12_e_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 9);
  if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 0,
                     !chartInstance->c12_before_not_empty)) {
    chartInstance->c12_before = c12_emlrt_update_log_3(chartInstance, 1U,
      chartInstance->c12_emlrtLocationLoggingDataTables, 10);
    chartInstance->c12_before_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 1,
                     !chartInstance->c12_after_not_empty)) {
    chartInstance->c12_after = c12_emlrt_update_log_3(chartInstance, 0U,
      chartInstance->c12_emlrtLocationLoggingDataTables, 11);
    chartInstance->c12_after_not_empty = true;
  }

  if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 2,
                     !chartInstance->c12_fifo_not_empty)) {
    for (c12_i = 0; c12_i < 256; c12_i++) {
      chartInstance->c12_fifo[c12_i] = 0;
    }

    c12_b_emlrt_update_log_4(chartInstance, chartInstance->c12_fifo,
      chartInstance->c12_emlrtLocationLoggingDataTables, 12);
    chartInstance->c12_fifo_not_empty = true;
  }

  c12_d = (real_T)chartInstance->c12_before;
  c12_d_i1 = (int32_T)emlrtIntegerCheckR2012b(c12_d, &c12_emlrtDCI, c12_sp);
  chartInstance->c12_fifo[(emlrtDynamicBoundsCheckR2012b(c12_d_i1, 1, 64,
    &c12_emlrtBCI, c12_sp) - 1) << 2] = c12_emlrt_update_log_1(chartInstance,
    c12_c_i1, chartInstance->c12_emlrtLocationLoggingDataTables, 13);
  c12_k_varargin_1 = chartInstance->c12_fifo[0];
  c12_l_varargin_1 = c12_k_varargin_1;
  c12_f_var1 = c12_l_varargin_1;
  c12_f_hfi = c12_f_var1;
  c12_d1 = c12_emlrt_update_log_1(chartInstance, c12_f_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 14);
  c12_b_d1 = (real_T)chartInstance->c12_before;
  c12_d_i2 = (int32_T)emlrtIntegerCheckR2012b(c12_b_d1, &c12_b_emlrtDCI, c12_sp);
  chartInstance->c12_fifo[1 + ((emlrtDynamicBoundsCheckR2012b(c12_d_i2, 1, 64,
    &c12_b_emlrtBCI, c12_sp) - 1) << 2)] = c12_emlrt_update_log_1(chartInstance,
    c12_c_i2, chartInstance->c12_emlrtLocationLoggingDataTables, 15);
  c12_m_varargin_1 = chartInstance->c12_fifo[1];
  c12_n_varargin_1 = c12_m_varargin_1;
  c12_g_var1 = c12_n_varargin_1;
  c12_g_hfi = c12_g_var1;
  c12_d2 = c12_emlrt_update_log_1(chartInstance, c12_g_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 16);
  c12_b_d2 = (real_T)chartInstance->c12_before;
  c12_d_i3 = (int32_T)emlrtIntegerCheckR2012b(c12_b_d2, &c12_c_emlrtDCI, c12_sp);
  chartInstance->c12_fifo[2 + ((emlrtDynamicBoundsCheckR2012b(c12_d_i3, 1, 64,
    &c12_c_emlrtBCI, c12_sp) - 1) << 2)] = c12_emlrt_update_log_1(chartInstance,
    c12_c_i3, chartInstance->c12_emlrtLocationLoggingDataTables, 17);
  c12_o_varargin_1 = chartInstance->c12_fifo[2];
  c12_p_varargin_1 = c12_o_varargin_1;
  c12_h_var1 = c12_p_varargin_1;
  c12_h_hfi = c12_h_var1;
  c12_d3 = c12_emlrt_update_log_1(chartInstance, c12_h_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 18);
  c12_b_d3 = (real_T)chartInstance->c12_before;
  c12_d_i4 = (int32_T)emlrtIntegerCheckR2012b(c12_b_d3, &c12_d_emlrtDCI, c12_sp);
  chartInstance->c12_fifo[3 + ((emlrtDynamicBoundsCheckR2012b(c12_d_i4, 1, 64,
    &c12_d_emlrtBCI, c12_sp) - 1) << 2)] = c12_emlrt_update_log_1(chartInstance,
    c12_c_i4, chartInstance->c12_emlrtLocationLoggingDataTables, 19);
  c12_q_varargin_1 = chartInstance->c12_fifo[3];
  c12_r_varargin_1 = c12_q_varargin_1;
  c12_i_var1 = c12_r_varargin_1;
  c12_i_hfi = c12_i_var1;
  c12_d4 = c12_emlrt_update_log_1(chartInstance, c12_i_hfi,
    chartInstance->c12_emlrtLocationLoggingDataTables, 20);
  c12_xfi = c12_c_i1;
  c12_a0 = c12_xfi;
  c12_a = c12_a0;
  c12_b_a0 = c12_a;
  c12_a1 = c12_b_a0;
  c12_b_a1 = c12_a1;
  c12_c = (c12_b_a1 < 0);
  if (c12_c) {
    c12_i5 = c12__s32_uminus__(chartInstance, c12_xfi, 84, 1U, 829, 7);
    if (c12_i5 > 131071) {
      sf_data_overflow_error(chartInstance->S, 1U, 829, 7);
      c12_b_d4 = 1.0;
      observerLog(86 + c12_PICOffset, &c12_b_d4, 1);
    }

    if (c12_i5 < -131072) {
      sf_data_overflow_error(chartInstance->S, 1U, 829, 7);
      c12_d5 = 1.0;
      observerLog(86 + c12_PICOffset, &c12_d5, 1);
    }

    if ((c12_i5 & 131072) != 0) {
      c12_y = c12_i5 | -131072;
    } else {
      c12_y = c12_i5 & 131071;
    }
  } else {
    c12_y = c12_xfi;
  }

  c12_yreturn = c12_y;
  c12_i6 = c12_emlrt_update_log_1(chartInstance, c12_yreturn,
    chartInstance->c12_emlrtLocationLoggingDataTables, 22);
  c12_c_a0 = c12_i6;
  c12_b0 = c12_c_threshold;
  c12_b_a = c12_c_a0;
  c12_b = c12_b0;
  c12_d_a0 = c12_b_a;
  c12_b_b0 = c12_b;
  c12_c_a1 = c12_d_a0;
  c12_b1 = c12_b_b0;
  c12_d_a1 = c12_c_a1;
  c12_b_b1 = c12_b1;
  c12_i7 = c12_b_b1 << 1;
  if ((c12_i7 & 131072) != 0) {
    c12_i8 = c12_i7 | -131072;
  } else {
    c12_i8 = c12_i7 & 131071;
  }

  c12_b_c = (c12_d_a1 >= c12_i8);
  c12_i9 = c12_c_threshold << 1;
  c12_i10 = c12_c_threshold << 1;
  if ((c12_i10 & 131072) != 0) {
    c12_i11 = c12_i10 | -131072;
  } else {
    c12_i11 = c12_i10 & 131071;
  }

  c12_i12 = c12_i11 - c12_i6;
  if (c12_i12 > 131071) {
    c12_i12 = 131071;
  } else {
    if (c12_i12 < -131072) {
      c12_i12 = -131072;
    }
  }

  c12_i13 = c12_c_threshold << 1;
  c12_i14 = c12_c_threshold << 1;
  if ((c12_i14 & 131072) != 0) {
    c12_i15 = c12_i14 | -131072;
  } else {
    c12_i15 = c12_i14 & 131071;
  }

  c12_i16 = c12_i6 - c12_i15;
  if (c12_i16 > 131071) {
    c12_i16 = 131071;
  } else {
    if (c12_i16 < -131072) {
      c12_i16 = -131072;
    }
  }

  if ((c12_i9 & 131072) != 0) {
    c12_i17 = c12_i9 | -131072;
  } else {
    c12_i17 = c12_i9 & 131071;
  }

  if ((c12_i13 & 131072) != 0) {
    c12_i18 = c12_i13 | -131072;
  } else {
    c12_i18 = c12_i13 & 131071;
  }

  if (c12_i6 < c12_i17) {
    c12_d6 = (real_T)(c12_i12 <= 1);
  } else if (c12_i6 > c12_i18) {
    if (c12_i16 <= 1) {
      c12_d6 = 3.0;
    } else {
      c12_d6 = 0.0;
    }
  } else {
    c12_d6 = 2.0;
  }

  c12_guard1 = false;
  if (covrtEmlCondEval(chartInstance->c12_covrtInstance, 4U, 0, 0,
                       covrtRelationalopUpdateFcn
                       (chartInstance->c12_covrtInstance, 4U, 0U, 0U, c12_d6,
                        0.0, -2, 5U, (int32_T)c12_emlrt_update_log_5
                        (chartInstance, c12_b_c,
                         chartInstance->c12_emlrtLocationLoggingDataTables, 21))))
  {
    c12_guard1 = true;
  } else {
    c12_b_xfi = c12_c_i2;
    c12_e_a0 = c12_b_xfi;
    c12_c_a = c12_e_a0;
    c12_f_a0 = c12_c_a;
    c12_e_a1 = c12_f_a0;
    c12_f_a1 = c12_e_a1;
    c12_c_c = (c12_f_a1 < 0);
    if (c12_c_c) {
      c12_i19 = c12__s32_uminus__(chartInstance, c12_b_xfi, 87, 1U, 853, 7);
      if (c12_i19 > 131071) {
        sf_data_overflow_error(chartInstance->S, 1U, 853, 7);
        c12_d7 = 1.0;
        observerLog(90 + c12_PICOffset, &c12_d7, 1);
      }

      if (c12_i19 < -131072) {
        sf_data_overflow_error(chartInstance->S, 1U, 853, 7);
        c12_d8 = 1.0;
        observerLog(90 + c12_PICOffset, &c12_d8, 1);
      }

      if ((c12_i19 & 131072) != 0) {
        c12_b_y = c12_i19 | -131072;
      } else {
        c12_b_y = c12_i19 & 131071;
      }
    } else {
      c12_b_y = c12_b_xfi;
    }

    c12_b_yreturn = c12_b_y;
    c12_i20 = c12_emlrt_update_log_1(chartInstance, c12_b_yreturn,
      chartInstance->c12_emlrtLocationLoggingDataTables, 24);
    c12_g_a0 = c12_i20;
    c12_c_b0 = c12_c_threshold;
    c12_d_a = c12_g_a0;
    c12_b_b = c12_c_b0;
    c12_h_a0 = c12_d_a;
    c12_d_b0 = c12_b_b;
    c12_g_a1 = c12_h_a0;
    c12_c_b1 = c12_d_b0;
    c12_h_a1 = c12_g_a1;
    c12_d_b1 = c12_c_b1;
    c12_i21 = c12_d_b1 << 1;
    if ((c12_i21 & 131072) != 0) {
      c12_i22 = c12_i21 | -131072;
    } else {
      c12_i22 = c12_i21 & 131071;
    }

    c12_d_c = (c12_h_a1 >= c12_i22);
    c12_i23 = c12_c_threshold << 1;
    c12_i24 = c12_c_threshold << 1;
    if ((c12_i24 & 131072) != 0) {
      c12_i25 = c12_i24 | -131072;
    } else {
      c12_i25 = c12_i24 & 131071;
    }

    c12_i26 = c12_i25 - c12_i20;
    if (c12_i26 > 131071) {
      c12_i26 = 131071;
    } else {
      if (c12_i26 < -131072) {
        c12_i26 = -131072;
      }
    }

    c12_i28 = c12_c_threshold << 1;
    c12_i29 = c12_c_threshold << 1;
    if ((c12_i29 & 131072) != 0) {
      c12_i31 = c12_i29 | -131072;
    } else {
      c12_i31 = c12_i29 & 131071;
    }

    c12_i32 = c12_i20 - c12_i31;
    if (c12_i32 > 131071) {
      c12_i32 = 131071;
    } else {
      if (c12_i32 < -131072) {
        c12_i32 = -131072;
      }
    }

    if ((c12_i23 & 131072) != 0) {
      c12_i34 = c12_i23 | -131072;
    } else {
      c12_i34 = c12_i23 & 131071;
    }

    if ((c12_i28 & 131072) != 0) {
      c12_i38 = c12_i28 | -131072;
    } else {
      c12_i38 = c12_i28 & 131071;
    }

    if (c12_i20 < c12_i34) {
      c12_d10 = (real_T)(c12_i26 <= 1);
    } else if (c12_i20 > c12_i38) {
      if (c12_i32 <= 1) {
        c12_d10 = 3.0;
      } else {
        c12_d10 = 0.0;
      }
    } else {
      c12_d10 = 2.0;
    }

    if (covrtEmlCondEval(chartInstance->c12_covrtInstance, 4U, 0, 1,
                         covrtRelationalopUpdateFcn
                         (chartInstance->c12_covrtInstance, 4U, 0U, 1U, c12_d10,
                          0.0, -2, 5U, (int32_T)c12_emlrt_update_log_5
                          (chartInstance, c12_d_c,
                           chartInstance->c12_emlrtLocationLoggingDataTables, 23))))
    {
      c12_guard1 = true;
    } else {
      c12_c_xfi = c12_c_i3;
      c12_k_a0 = c12_c_xfi;
      c12_f_a = c12_k_a0;
      c12_l_a0 = c12_f_a;
      c12_k_a1 = c12_l_a0;
      c12_l_a1 = c12_k_a1;
      c12_f_c = (c12_l_a1 < 0);
      if (c12_f_c) {
        c12_i41 = c12__s32_uminus__(chartInstance, c12_c_xfi, 96, 1U, 877, 7);
        if (c12_i41 > 131071) {
          sf_data_overflow_error(chartInstance->S, 1U, 877, 7);
          c12_d11 = 1.0;
          observerLog(99 + c12_PICOffset, &c12_d11, 1);
        }

        if (c12_i41 < -131072) {
          sf_data_overflow_error(chartInstance->S, 1U, 877, 7);
          c12_d12 = 1.0;
          observerLog(99 + c12_PICOffset, &c12_d12, 1);
        }

        if ((c12_i41 & 131072) != 0) {
          c12_c_y = c12_i41 | -131072;
        } else {
          c12_c_y = c12_i41 & 131071;
        }
      } else {
        c12_c_y = c12_c_xfi;
      }

      c12_c_yreturn = c12_c_y;
      c12_i42 = c12_emlrt_update_log_1(chartInstance, c12_c_yreturn,
        chartInstance->c12_emlrtLocationLoggingDataTables, 26);
      c12_m_a0 = c12_i42;
      c12_e_b0 = c12_c_threshold;
      c12_g_a = c12_m_a0;
      c12_c_b = c12_e_b0;
      c12_n_a0 = c12_g_a;
      c12_f_b0 = c12_c_b;
      c12_m_a1 = c12_n_a0;
      c12_e_b1 = c12_f_b0;
      c12_n_a1 = c12_m_a1;
      c12_f_b1 = c12_e_b1;
      c12_i43 = c12_f_b1 << 1;
      if ((c12_i43 & 131072) != 0) {
        c12_i44 = c12_i43 | -131072;
      } else {
        c12_i44 = c12_i43 & 131071;
      }

      c12_g_c = (c12_n_a1 >= c12_i44);
      c12_i45 = c12_c_threshold << 1;
      c12_i46 = c12_c_threshold << 1;
      if ((c12_i46 & 131072) != 0) {
        c12_i47 = c12_i46 | -131072;
      } else {
        c12_i47 = c12_i46 & 131071;
      }

      c12_i48 = c12_i47 - c12_i42;
      if (c12_i48 > 131071) {
        c12_i48 = 131071;
      } else {
        if (c12_i48 < -131072) {
          c12_i48 = -131072;
        }
      }

      c12_i49 = c12_c_threshold << 1;
      c12_i50 = c12_c_threshold << 1;
      if ((c12_i50 & 131072) != 0) {
        c12_i51 = c12_i50 | -131072;
      } else {
        c12_i51 = c12_i50 & 131071;
      }

      c12_i52 = c12_i42 - c12_i51;
      if (c12_i52 > 131071) {
        c12_i52 = 131071;
      } else {
        if (c12_i52 < -131072) {
          c12_i52 = -131072;
        }
      }

      if ((c12_i45 & 131072) != 0) {
        c12_i53 = c12_i45 | -131072;
      } else {
        c12_i53 = c12_i45 & 131071;
      }

      if ((c12_i49 & 131072) != 0) {
        c12_i54 = c12_i49 | -131072;
      } else {
        c12_i54 = c12_i49 & 131071;
      }

      if (c12_i42 < c12_i53) {
        c12_d13 = (real_T)(c12_i48 <= 1);
      } else if (c12_i42 > c12_i54) {
        if (c12_i52 <= 1) {
          c12_d13 = 3.0;
        } else {
          c12_d13 = 0.0;
        }
      } else {
        c12_d13 = 2.0;
      }

      if (covrtEmlCondEval(chartInstance->c12_covrtInstance, 4U, 0, 2,
                           covrtRelationalopUpdateFcn
                           (chartInstance->c12_covrtInstance, 4U, 0U, 2U,
                            c12_d13, 0.0, -2, 5U, (int32_T)
                            c12_emlrt_update_log_5(chartInstance, c12_g_c,
             chartInstance->c12_emlrtLocationLoggingDataTables, 25)))) {
        c12_guard1 = true;
      } else {
        c12_d_xfi = c12_c_i4;
        c12_o_a0 = c12_d_xfi;
        c12_h_a = c12_o_a0;
        c12_p_a0 = c12_h_a;
        c12_o_a1 = c12_p_a0;
        c12_p_a1 = c12_o_a1;
        c12_h_c = (c12_p_a1 < 0);
        if (c12_h_c) {
          c12_i55 = c12__s32_uminus__(chartInstance, c12_d_xfi, 100, 1U, 901, 7);
          if (c12_i55 > 131071) {
            sf_data_overflow_error(chartInstance->S, 1U, 901, 7);
            c12_d14 = 1.0;
            observerLog(137 + c12_PICOffset, &c12_d14, 1);
          }

          if (c12_i55 < -131072) {
            sf_data_overflow_error(chartInstance->S, 1U, 901, 7);
            c12_d15 = 1.0;
            observerLog(137 + c12_PICOffset, &c12_d15, 1);
          }

          if ((c12_i55 & 131072) != 0) {
            c12_d_y = c12_i55 | -131072;
          } else {
            c12_d_y = c12_i55 & 131071;
          }
        } else {
          c12_d_y = c12_d_xfi;
        }

        c12_d_yreturn = c12_d_y;
        c12_i56 = c12_emlrt_update_log_1(chartInstance, c12_d_yreturn,
          chartInstance->c12_emlrtLocationLoggingDataTables, 28);
        c12_q_a0 = c12_i56;
        c12_g_b0 = c12_c_threshold;
        c12_i_a = c12_q_a0;
        c12_d_b = c12_g_b0;
        c12_r_a0 = c12_i_a;
        c12_h_b0 = c12_d_b;
        c12_q_a1 = c12_r_a0;
        c12_g_b1 = c12_h_b0;
        c12_r_a1 = c12_q_a1;
        c12_h_b1 = c12_g_b1;
        c12_i57 = c12_h_b1 << 1;
        if ((c12_i57 & 131072) != 0) {
          c12_i58 = c12_i57 | -131072;
        } else {
          c12_i58 = c12_i57 & 131071;
        }

        c12_i_c = (c12_r_a1 >= c12_i58);
        c12_i59 = c12_c_threshold << 1;
        c12_i60 = c12_c_threshold << 1;
        if ((c12_i60 & 131072) != 0) {
          c12_i61 = c12_i60 | -131072;
        } else {
          c12_i61 = c12_i60 & 131071;
        }

        c12_i62 = c12_i61 - c12_i56;
        if (c12_i62 > 131071) {
          c12_i62 = 131071;
        } else {
          if (c12_i62 < -131072) {
            c12_i62 = -131072;
          }
        }

        c12_i63 = c12_c_threshold << 1;
        c12_i64 = c12_c_threshold << 1;
        if ((c12_i64 & 131072) != 0) {
          c12_i65 = c12_i64 | -131072;
        } else {
          c12_i65 = c12_i64 & 131071;
        }

        c12_i66 = c12_i56 - c12_i65;
        if (c12_i66 > 131071) {
          c12_i66 = 131071;
        } else {
          if (c12_i66 < -131072) {
            c12_i66 = -131072;
          }
        }

        if ((c12_i59 & 131072) != 0) {
          c12_i67 = c12_i59 | -131072;
        } else {
          c12_i67 = c12_i59 & 131071;
        }

        if ((c12_i63 & 131072) != 0) {
          c12_i68 = c12_i63 | -131072;
        } else {
          c12_i68 = c12_i63 & 131071;
        }

        if (c12_i56 < c12_i67) {
          c12_d16 = (real_T)(c12_i62 <= 1);
        } else if (c12_i56 > c12_i68) {
          if (c12_i66 <= 1) {
            c12_d16 = 3.0;
          } else {
            c12_d16 = 0.0;
          }
        } else {
          c12_d16 = 2.0;
        }

        if (covrtEmlCondEval(chartInstance->c12_covrtInstance, 4U, 0, 3,
                             covrtRelationalopUpdateFcn
                             (chartInstance->c12_covrtInstance, 4U, 0U, 3U,
                              c12_d16, 0.0, -2, 5U, (int32_T)
                              c12_emlrt_update_log_5(chartInstance, c12_i_c,
               chartInstance->c12_emlrtLocationLoggingDataTables, 27)))) {
          c12_guard1 = true;
        } else {
          covrtEmlMcdcEval(chartInstance->c12_covrtInstance, 4U, 0, 0, false);
          covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 3, false);
          c12_s_a0 = chartInstance->c12_after;
          c12_j_a = c12_s_a0;
          c12_t_a0 = c12_j_a;
          c12_s_a1 = c12_t_a0;
          c12_t_a1 = c12_s_a1;
          c12_j_c = (c12_t_a1 > 0);
          if ((int8_T)chartInstance->c12_after > 0) {
            if ((int8_T)chartInstance->c12_after <= 1) {
              c12_d17 = 3.0;
            } else {
              c12_d17 = 0.0;
            }
          } else {
            c12_d17 = 2.0;
          }

          if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 5,
                             covrtRelationalopUpdateFcn
                             (chartInstance->c12_covrtInstance, 4U, 0U, 5U,
                              c12_d17, 0.0, -2, 4U, (int32_T)
                              c12_emlrt_update_log_5(chartInstance, c12_j_c,
                 chartInstance->c12_emlrtLocationLoggingDataTables, 37)))) {
            c12_bb_varargin_1 = c12_d1;
            c12_cb_varargin_1 = c12_bb_varargin_1;
            c12_n_var1 = c12_cb_varargin_1;
            c12_n_hfi = c12_n_var1;
            c12_b_o1 = c12_emlrt_update_log_1(chartInstance, c12_n_hfi,
              chartInstance->c12_emlrtLocationLoggingDataTables, 38);
            c12_db_varargin_1 = c12_d2;
            c12_eb_varargin_1 = c12_db_varargin_1;
            c12_o_var1 = c12_eb_varargin_1;
            c12_o_hfi = c12_o_var1;
            c12_b_o2 = c12_emlrt_update_log_1(chartInstance, c12_o_hfi,
              chartInstance->c12_emlrtLocationLoggingDataTables, 39);
            c12_fb_varargin_1 = c12_d3;
            c12_gb_varargin_1 = c12_fb_varargin_1;
            c12_p_var1 = c12_gb_varargin_1;
            c12_p_hfi = c12_p_var1;
            c12_b_o3 = c12_emlrt_update_log_1(chartInstance, c12_p_hfi,
              chartInstance->c12_emlrtLocationLoggingDataTables, 40);
            c12_hb_varargin_1 = c12_d4;
            c12_ib_varargin_1 = c12_hb_varargin_1;
            c12_q_var1 = c12_ib_varargin_1;
            c12_q_hfi = c12_q_var1;
            c12_b_o4 = c12_emlrt_update_log_1(chartInstance, c12_q_hfi,
              chartInstance->c12_emlrtLocationLoggingDataTables, 41);
            c12_b_trigged = c12_emlrt_update_log_6(chartInstance, 131072U,
              chartInstance->c12_emlrtLocationLoggingDataTables, 42);
            c12_l_a = chartInstance->c12_after;

            /* logging input variable 'a' for function 'fi_signed' */
            c12_emlrt_update_log_3(chartInstance, c12_l_a,
              chartInstance->c12_emlrtLocationLoggingDataTables, 57);
            covrtEmlFcnEval(chartInstance->c12_covrtInstance, 4U, 0, 1);
            covrtEmlCondEval(chartInstance->c12_covrtInstance, 4U, 0, 4, true);
            covrtEmlCondEval(chartInstance->c12_covrtInstance, 4U, 0, 5, false);
            covrtEmlMcdcEval(chartInstance->c12_covrtInstance, 4U, 0, 1, true);
            covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 8, true);
            c12_e_y = c12_emlrt_update_log_9(chartInstance, c12__s8_u8_
              (chartInstance, c12_l_a, 120, 1U, 2061, 28),
              chartInstance->c12_emlrtLocationLoggingDataTables, 58);
            c12_x_a0 = c12_emlrt_update_log_9(chartInstance, c12_e_y,
              chartInstance->c12_emlrtLocationLoggingDataTables, 45);
            c12_i77 = c12_x_a0;
            if (c12_i77 > 511) {
              sf_data_overflow_error(chartInstance->S, 1U, 1409, 37);
              c12_d20 = 1.0;
              observerLog(124 + c12_PICOffset, &c12_d20, 1);
            }

            if (c12_i77 < -512) {
              sf_data_overflow_error(chartInstance->S, 1U, 1409, 37);
              c12_d21 = 1.0;
              observerLog(124 + c12_PICOffset, &c12_d21, 1);
            }

            if ((int16_T)(c12_i77 & 512) != 0) {
              c12_i78 = (int16_T)(c12_i77 | -512);
            } else {
              c12_i78 = (int16_T)(c12_i77 & 511);
            }

            c12_i79 = c12__s16_s32_(chartInstance, c12__s32_minus__
              (chartInstance, (int32_T)c12_i78, 1, 123, 1U, 1409, 37), 122, 1U,
              1409, 37);
            if (c12_i79 > 511) {
              sf_data_overflow_error(chartInstance->S, 1U, 1409, 37);
              c12_d22 = 1.0;
              observerLog(135 + c12_PICOffset, &c12_d22, 1);
            }

            if (c12_i79 < -512) {
              sf_data_overflow_error(chartInstance->S, 1U, 1409, 37);
              c12_d23 = 1.0;
              observerLog(135 + c12_PICOffset, &c12_d23, 1);
            }

            if ((int16_T)(c12_i79 & 512) != 0) {
              c12_m_c = (int16_T)(c12_i79 | -512);
            } else {
              c12_m_c = (int16_T)(c12_i79 & 511);
            }

            c12_u1 = c12__u8_s16_(chartInstance, c12_emlrt_update_log_8
                                  (chartInstance, c12_m_c,
              chartInstance->c12_emlrtLocationLoggingDataTables, 44), 127, 1U,
                                  1398, 48);
            if (c12_u1 > 127) {
              sf_data_overflow_error(chartInstance->S, 1U, 1398, 48);
              c12_d24 = 1.0;
              observerLog(133 + c12_PICOffset, &c12_d24, 1);
            }

            chartInstance->c12_after = c12_emlrt_update_log_3(chartInstance,
              (uint8_T)(c12_u1 & 127),
              chartInstance->c12_emlrtLocationLoggingDataTables, 43);
            c12_y_a0 = chartInstance->c12_before;
            c12_m_a = c12_y_a0;
            c12_ab_a0 = c12_m_a;
            c12_w_a1 = c12_ab_a0;
            c12_x_a1 = c12_w_a1;
            c12_n_c = (c12_x_a1 >= 2);
            c12_i80 = 2 - (int8_T)chartInstance->c12_before;
            if (c12_i80 > 127) {
              c12_i80 = 127;
            } else {
              if (c12_i80 < -128) {
                c12_i80 = -128;
              }
            }

            c12_i81 = (int8_T)chartInstance->c12_before - 2;
            if (c12_i81 > 127) {
              c12_i81 = 127;
            } else {
              if (c12_i81 < -128) {
                c12_i81 = -128;
              }
            }

            if ((int8_T)chartInstance->c12_before < 2) {
              c12_d25 = (real_T)((int8_T)c12_i80 <= 1);
            } else if ((int8_T)chartInstance->c12_before > 2) {
              if ((int8_T)c12_i81 <= 1) {
                c12_d25 = 3.0;
              } else {
                c12_d25 = 0.0;
              }
            } else {
              c12_d25 = 2.0;
            }

            if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 6,
                               covrtRelationalopUpdateFcn
                               (chartInstance->c12_covrtInstance, 4U, 0U, 6U,
                                c12_d25, 0.0, -2, 5U, (int32_T)
                                c12_emlrt_update_log_5(chartInstance, c12_n_c,
                   chartInstance->c12_emlrtLocationLoggingDataTables, 46)))) {
              c12_i82 = 0;
              for (c12_i83 = 0; c12_i83 < 63; c12_i83++) {
                for (c12_i85 = 0; c12_i85 < 4; c12_i85++) {
                  c12_iv2[c12_i85 + c12_i82] = chartInstance->c12_fifo[(c12_i85
                    + c12_i82) + 4];
                }

                c12_i82 += 4;
              }

              c12_i84 = 0;
              for (c12_i86 = 0; c12_i86 < 63; c12_i86++) {
                for (c12_i87 = 0; c12_i87 < 4; c12_i87++) {
                  chartInstance->c12_fifo[c12_i87 + c12_i84] = c12_iv2[c12_i87 +
                    c12_i84];
                }

                c12_i84 += 4;
              }

              c12_b_emlrt_update_log_7(chartInstance, *(int32_T (*)[252])&
                chartInstance->c12_fifo[0],
                chartInstance->c12_emlrtLocationLoggingDataTables, 47);
            }
          } else {
            c12_b_o1 = c12_emlrt_update_log_1(chartInstance, 0,
              chartInstance->c12_emlrtLocationLoggingDataTables, 48);
            c12_b_o2 = c12_emlrt_update_log_1(chartInstance, 0,
              chartInstance->c12_emlrtLocationLoggingDataTables, 49);
            c12_b_o3 = c12_emlrt_update_log_1(chartInstance, 0,
              chartInstance->c12_emlrtLocationLoggingDataTables, 50);
            c12_b_o4 = c12_emlrt_update_log_1(chartInstance, 0,
              chartInstance->c12_emlrtLocationLoggingDataTables, 51);
            c12_b_trigged = c12_emlrt_update_log_6(chartInstance, 0U,
              chartInstance->c12_emlrtLocationLoggingDataTables, 52);
            c12_u_a0 = chartInstance->c12_before;
            c12_k_a = c12_u_a0;
            c12_v_a0 = c12_k_a;
            c12_u_a1 = c12_v_a0;
            c12_v_a1 = c12_u_a1;
            c12_k_c = (c12_v_a1 < 64);
            c12_i69 = 64 - (int8_T)chartInstance->c12_before;
            if (c12_i69 > 127) {
              c12_i69 = 127;
            } else {
              if (c12_i69 < -128) {
                c12_i69 = -128;
              }
            }

            c12_i70 = (int8_T)chartInstance->c12_before - 64;
            if (c12_i70 > 127) {
              c12_i70 = 127;
            } else {
              if (c12_i70 < -128) {
                c12_i70 = -128;
              }
            }

            if ((int8_T)chartInstance->c12_before < 64) {
              c12_d18 = (real_T)((int8_T)c12_i69 <= 1);
            } else if ((int8_T)chartInstance->c12_before > 64) {
              if ((int8_T)c12_i70 <= 1) {
                c12_d18 = 3.0;
              } else {
                c12_d18 = 0.0;
              }
            } else {
              c12_d18 = 2.0;
            }

            if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 7,
                               covrtRelationalopUpdateFcn
                               (chartInstance->c12_covrtInstance, 4U, 0U, 7U,
                                c12_d18, 0.0, -2, 2U, (int32_T)
                                c12_emlrt_update_log_5(chartInstance, c12_k_c,
                   chartInstance->c12_emlrtLocationLoggingDataTables, 53)))) {
              c12_w_a0 = chartInstance->c12_before;
              c12_l_c = c12__u8_u32_(chartInstance, c12__u32_add__(chartInstance,
                (uint32_T)c12_w_a0, 1U, 114, 1U, 1756, 27), 113, 1U, 1756, 27);
              c12_u = c12_emlrt_update_log_10(chartInstance, c12_l_c,
                chartInstance->c12_emlrtLocationLoggingDataTables, 55);
              if (c12_u > 127) {
                sf_data_overflow_error(chartInstance->S, 1U, 1744, 39);
                c12_d19 = 1.0;
                observerLog(116 + c12_PICOffset, &c12_d19, 1);
              }

              chartInstance->c12_before = c12_emlrt_update_log_3(chartInstance,
                (uint8_T)(c12_u & 127),
                chartInstance->c12_emlrtLocationLoggingDataTables, 54);
            } else {
              c12_i71 = 0;
              for (c12_i72 = 0; c12_i72 < 63; c12_i72++) {
                for (c12_i74 = 0; c12_i74 < 4; c12_i74++) {
                  c12_iv1[c12_i74 + c12_i71] = chartInstance->c12_fifo[(c12_i74
                    + c12_i71) + 4];
                }

                c12_i71 += 4;
              }

              c12_i73 = 0;
              for (c12_i75 = 0; c12_i75 < 63; c12_i75++) {
                for (c12_i76 = 0; c12_i76 < 4; c12_i76++) {
                  chartInstance->c12_fifo[c12_i76 + c12_i73] = c12_iv1[c12_i76 +
                    c12_i73];
                }

                c12_i73 += 4;
              }

              c12_b_emlrt_update_log_7(chartInstance, *(int32_T (*)[252])&
                chartInstance->c12_fifo[0],
                chartInstance->c12_emlrtLocationLoggingDataTables, 56);
            }
          }
        }
      }
    }
  }

  if (c12_guard1) {
    covrtEmlMcdcEval(chartInstance->c12_covrtInstance, 4U, 0, 0, true);
    covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 3, true);
    c12_s_varargin_1 = c12_d1;
    c12_t_varargin_1 = c12_s_varargin_1;
    c12_j_var1 = c12_t_varargin_1;
    c12_j_hfi = c12_j_var1;
    c12_b_o1 = c12_emlrt_update_log_1(chartInstance, c12_j_hfi,
      chartInstance->c12_emlrtLocationLoggingDataTables, 29);
    c12_u_varargin_1 = c12_d2;
    c12_v_varargin_1 = c12_u_varargin_1;
    c12_k_var1 = c12_v_varargin_1;
    c12_k_hfi = c12_k_var1;
    c12_b_o2 = c12_emlrt_update_log_1(chartInstance, c12_k_hfi,
      chartInstance->c12_emlrtLocationLoggingDataTables, 30);
    c12_w_varargin_1 = c12_d3;
    c12_x_varargin_1 = c12_w_varargin_1;
    c12_l_var1 = c12_x_varargin_1;
    c12_l_hfi = c12_l_var1;
    c12_b_o3 = c12_emlrt_update_log_1(chartInstance, c12_l_hfi,
      chartInstance->c12_emlrtLocationLoggingDataTables, 31);
    c12_y_varargin_1 = c12_d4;
    c12_ab_varargin_1 = c12_y_varargin_1;
    c12_m_var1 = c12_ab_varargin_1;
    c12_m_hfi = c12_m_var1;
    c12_b_o4 = c12_emlrt_update_log_1(chartInstance, c12_m_hfi,
      chartInstance->c12_emlrtLocationLoggingDataTables, 32);
    c12_b_trigged = c12_emlrt_update_log_6(chartInstance, 131072U,
      chartInstance->c12_emlrtLocationLoggingDataTables, 33);
    chartInstance->c12_after = c12_emlrt_update_log_3(chartInstance, 64U,
      chartInstance->c12_emlrtLocationLoggingDataTables, 34);
    c12_i_a0 = chartInstance->c12_before;
    c12_e_a = c12_i_a0;
    c12_j_a0 = c12_e_a;
    c12_i_a1 = c12_j_a0;
    c12_j_a1 = c12_i_a1;
    c12_e_c = (c12_j_a1 >= 2);
    c12_i27 = 2 - (int8_T)chartInstance->c12_before;
    if (c12_i27 > 127) {
      c12_i27 = 127;
    } else {
      if (c12_i27 < -128) {
        c12_i27 = -128;
      }
    }

    c12_i30 = (int8_T)chartInstance->c12_before - 2;
    if (c12_i30 > 127) {
      c12_i30 = 127;
    } else {
      if (c12_i30 < -128) {
        c12_i30 = -128;
      }
    }

    if ((int8_T)chartInstance->c12_before < 2) {
      c12_d9 = (real_T)((int8_T)c12_i27 <= 1);
    } else if ((int8_T)chartInstance->c12_before > 2) {
      if ((int8_T)c12_i30 <= 1) {
        c12_d9 = 3.0;
      } else {
        c12_d9 = 0.0;
      }
    } else {
      c12_d9 = 2.0;
    }

    if (covrtEmlIfEval(chartInstance->c12_covrtInstance, 4U, 0, 4,
                       covrtRelationalopUpdateFcn
                       (chartInstance->c12_covrtInstance, 4U, 0U, 4U, c12_d9,
                        0.0, -2, 5U, (int32_T)c12_emlrt_update_log_5
                        (chartInstance, c12_e_c,
                         chartInstance->c12_emlrtLocationLoggingDataTables, 35))))
    {
      c12_i33 = 0;
      for (c12_i35 = 0; c12_i35 < 63; c12_i35++) {
        for (c12_i37 = 0; c12_i37 < 4; c12_i37++) {
          c12_iv[c12_i37 + c12_i33] = chartInstance->c12_fifo[(c12_i37 + c12_i33)
            + 4];
        }

        c12_i33 += 4;
      }

      c12_i36 = 0;
      for (c12_i39 = 0; c12_i39 < 63; c12_i39++) {
        for (c12_i40 = 0; c12_i40 < 4; c12_i40++) {
          chartInstance->c12_fifo[c12_i40 + c12_i36] = c12_iv[c12_i40 + c12_i36];
        }

        c12_i36 += 4;
      }

      c12_b_emlrt_update_log_7(chartInstance, *(int32_T (*)[252])&
        chartInstance->c12_fifo[0],
        chartInstance->c12_emlrtLocationLoggingDataTables, 36);
    }
  }

  *chartInstance->c12_o1 = c12_b_o1;
  *chartInstance->c12_o2 = c12_b_o2;
  *chartInstance->c12_o3 = c12_b_o3;
  *chartInstance->c12_o4 = c12_b_o4;
  *chartInstance->c12_trigged = c12_b_trigged;
}

static void initSimStructsc12_zeabus_hydrophone_concrete
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static int32_T c12_emlrt_update_log_1
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  int32_T c12_i;
  int32_T c12_localMin;
  real_T c12_d1;
  int32_T c12_b_i1;
  int32_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = muDoubleScalarFloor(c12_b_table[0U].SimMin * 131072.0);
    if (c12_d < 131072.0) {
      if (c12_d >= -131072.0) {
        c12_i = (int32_T)c12_d;
      } else {
        c12_i = -131072;
      }
    } else if (c12_d >= 131072.0) {
      c12_i = 131071;
    } else {
      c12_i = 0;
    }

    c12_localMin = c12_i;
    c12_d1 = muDoubleScalarFloor(c12_b_table[0U].SimMax * 131072.0);
    if (c12_d1 < 131072.0) {
      if (c12_d1 >= -131072.0) {
        c12_b_i1 = (int32_T)c12_d1;
      } else {
        c12_b_i1 = -131072;
      }
    } else if (c12_d1 >= 131072.0) {
      c12_b_i1 = 131071;
    } else {
      c12_b_i1 = 0;
    }

    c12_localMax = c12_b_i1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in * 7.62939453125E-6;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin * 7.62939453125E-6;
    c12_b_table[0U].SimMax = (real_T)c12_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if (((uint32_T)c12_in & 131071U) != 0U) {
      c12_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c12_in;
}

static uint16_T c12_emlrt_update_log_2
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint16_T
   c12_in, emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  uint16_T c12_u;
  uint16_T c12_localMin;
  real_T c12_d1;
  uint16_T c12_u1;
  uint16_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = c12_b_table[0U].SimMin * 65536.0;
    if (c12_d < 65536.0) {
      if (c12_d >= 0.0) {
        c12_u = (uint16_T)c12_d;
      } else {
        c12_u = 0U;
      }
    } else if (c12_d >= 65536.0) {
      c12_u = MAX_uint16_T;
    } else {
      c12_u = 0U;
    }

    c12_localMin = c12_u;
    c12_d1 = c12_b_table[0U].SimMax * 65536.0;
    if (c12_d1 < 65536.0) {
      if (c12_d1 >= 0.0) {
        c12_u1 = (uint16_T)c12_d1;
      } else {
        c12_u1 = 0U;
      }
    } else if (c12_d1 >= 65536.0) {
      c12_u1 = MAX_uint16_T;
    } else {
      c12_u1 = 0U;
    }

    c12_localMax = c12_u1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in * 1.52587890625E-5;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin * 1.52587890625E-5;
    c12_b_table[0U].SimMax = (real_T)c12_localMax * 1.52587890625E-5;

    /* IsAlwaysInteger logging. */
    if ((uint16_T)(c12_in & MAX_uint16_T) != 0) {
      c12_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c12_in;
}

static uint8_T c12_emlrt_update_log_3
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  uint8_T c12_u;
  uint8_T c12_localMin;
  real_T c12_d1;
  uint8_T c12_u1;
  uint8_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = c12_b_table[0U].SimMin;
    if (c12_d < 128.0) {
      if (c12_d >= 0.0) {
        c12_u = (uint8_T)c12_d;
      } else {
        c12_u = 0U;
      }
    } else if (c12_d >= 128.0) {
      c12_u = 127U;
    } else {
      c12_u = 0U;
    }

    c12_localMin = c12_u;
    c12_d1 = c12_b_table[0U].SimMax;
    if (c12_d1 < 128.0) {
      if (c12_d1 >= 0.0) {
        c12_u1 = (uint8_T)c12_d1;
      } else {
        c12_u1 = 0U;
      }
    } else if (c12_d1 >= 128.0) {
      c12_u1 = 127U;
    } else {
      c12_u1 = 0U;
    }

    c12_localMax = c12_u1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin;
    c12_b_table[0U].SimMax = (real_T)c12_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c12_in;
}

static void c12_emlrt_update_log_4
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[256], emlrtLocationLoggingDataType c12_table[], int32_T c12_index,
   int32_T c12_out[256])
{
  int32_T c12_i;
  for (c12_i = 0; c12_i < 256; c12_i++) {
    c12_out[c12_i] = c12_in[c12_i];
  }

  c12_b_emlrt_update_log_4(chartInstance, c12_out, c12_table, c12_index);
}

static boolean_T c12_emlrt_update_log_5
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, boolean_T
   c12_in, emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  boolean_T c12_localMin;
  boolean_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_localMin = (c12_b_table[0U].SimMin > 0.0);
    c12_localMax = (c12_b_table[0U].SimMax > 0.0);
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if ((int32_T)c12_in < (int32_T)c12_localMin) {
      c12_localMin = c12_in;
    }

    if ((int32_T)c12_in > (int32_T)c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin;
    c12_b_table[0U].SimMax = (real_T)c12_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c12_in;
}

static uint32_T c12_emlrt_update_log_6
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint32_T
   c12_in, emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  uint32_T c12_u;
  uint32_T c12_localMin;
  real_T c12_d1;
  uint32_T c12_u1;
  uint32_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = c12_b_table[0U].SimMin * 131072.0;
    if (c12_d < 262144.0) {
      if (c12_d >= 0.0) {
        c12_u = (uint32_T)c12_d;
      } else {
        c12_u = 0U;
      }
    } else if (c12_d >= 262144.0) {
      c12_u = 262143U;
    } else {
      c12_u = 0U;
    }

    c12_localMin = c12_u;
    c12_d1 = c12_b_table[0U].SimMax * 131072.0;
    if (c12_d1 < 262144.0) {
      if (c12_d1 >= 0.0) {
        c12_u1 = (uint32_T)c12_d1;
      } else {
        c12_u1 = 0U;
      }
    } else if (c12_d1 >= 262144.0) {
      c12_u1 = 262143U;
    } else {
      c12_u1 = 0U;
    }

    c12_localMax = c12_u1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in * 7.62939453125E-6;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin * 7.62939453125E-6;
    c12_b_table[0U].SimMax = (real_T)c12_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    if ((c12_in & 131071U) != 0U) {
      c12_b_table[0U].IsAlwaysInteger = false;
    }
  }

  return c12_in;
}

static void c12_emlrt_update_log_7
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[252], emlrtLocationLoggingDataType c12_table[], int32_T c12_index,
   int32_T c12_out[252])
{
  int32_T c12_i;
  for (c12_i = 0; c12_i < 252; c12_i++) {
    c12_out[c12_i] = c12_in[c12_i];
  }

  c12_b_emlrt_update_log_7(chartInstance, c12_out, c12_table, c12_index);
}

static int16_T c12_emlrt_update_log_8
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int16_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  int16_T c12_i;
  int16_T c12_localMin;
  real_T c12_d1;
  int16_T c12_b_i1;
  int16_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = muDoubleScalarFloor(c12_b_table[0U].SimMin);
    if (c12_d < 512.0) {
      if (c12_d >= -512.0) {
        c12_i = (int16_T)c12_d;
      } else {
        c12_i = -512;
      }
    } else if (c12_d >= 512.0) {
      c12_i = 511;
    } else {
      c12_i = 0;
    }

    c12_localMin = c12_i;
    c12_d1 = muDoubleScalarFloor(c12_b_table[0U].SimMax);
    if (c12_d1 < 512.0) {
      if (c12_d1 >= -512.0) {
        c12_b_i1 = (int16_T)c12_d1;
      } else {
        c12_b_i1 = -512;
      }
    } else if (c12_d1 >= 512.0) {
      c12_b_i1 = 511;
    } else {
      c12_b_i1 = 0;
    }

    c12_localMax = c12_b_i1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin;
    c12_b_table[0U].SimMax = (real_T)c12_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c12_in;
}

static int8_T c12_emlrt_update_log_9
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int8_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  int8_T c12_i;
  int8_T c12_localMin;
  real_T c12_d1;
  int8_T c12_b_i1;
  int8_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = muDoubleScalarFloor(c12_b_table[0U].SimMin);
    if (c12_d < 128.0) {
      if (c12_d >= -128.0) {
        c12_i = (int8_T)c12_d;
      } else {
        c12_i = MIN_int8_T;
      }
    } else if (c12_d >= 128.0) {
      c12_i = MAX_int8_T;
    } else {
      c12_i = 0;
    }

    c12_localMin = c12_i;
    c12_d1 = muDoubleScalarFloor(c12_b_table[0U].SimMax);
    if (c12_d1 < 128.0) {
      if (c12_d1 >= -128.0) {
        c12_b_i1 = (int8_T)c12_d1;
      } else {
        c12_b_i1 = MIN_int8_T;
      }
    } else if (c12_d1 >= 128.0) {
      c12_b_i1 = MAX_int8_T;
    } else {
      c12_b_i1 = 0;
    }

    c12_localMax = c12_b_i1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin;
    c12_b_table[0U].SimMax = (real_T)c12_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c12_in;
}

static uint8_T c12_emlrt_update_log_10
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, uint8_T c12_in,
   emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  uint8_T c12_u;
  uint8_T c12_localMin;
  real_T c12_d1;
  uint8_T c12_u1;
  uint8_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = c12_b_table[0U].SimMin;
    if (c12_d < 256.0) {
      if (c12_d >= 0.0) {
        c12_u = (uint8_T)c12_d;
      } else {
        c12_u = 0U;
      }
    } else if (c12_d >= 256.0) {
      c12_u = MAX_uint8_T;
    } else {
      c12_u = 0U;
    }

    c12_localMin = c12_u;
    c12_d1 = c12_b_table[0U].SimMax;
    if (c12_d1 < 256.0) {
      if (c12_d1 >= 0.0) {
        c12_u1 = (uint8_T)c12_d1;
      } else {
        c12_u1 = 0U;
      }
    } else if (c12_d1 >= 256.0) {
      c12_u1 = MAX_uint8_T;
    } else {
      c12_u1 = 0U;
    }

    c12_localMax = c12_u1;
    c12_histTable = c12_b_table[0U].HistogramTable;

    /* Simulation Min-Max logging. */
    if (c12_in < c12_localMin) {
      c12_localMin = c12_in;
    }

    if (c12_in > c12_localMax) {
      c12_localMax = c12_in;
    }

    /* Histogram logging. */
    c12_inDouble = (real_T)c12_in;
    c12_histTable->TotalNumberOfValues++;
    if (c12_inDouble == 0.0) {
      c12_histTable->NumberOfZeros++;
    } else {
      c12_histTable->SimSum += c12_inDouble;
      if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
           (c12_inDouble))) {
        c12_significand = frexp(c12_inDouble, &c12_exponent);
        if (c12_exponent > 128) {
          c12_exponent = 128;
        }

        if (c12_exponent < -127) {
          c12_exponent = -127;
        }

        if (c12_significand < 0.0) {
          c12_histTable->NumberOfNegativeValues++;
          c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
        } else {
          c12_histTable->NumberOfPositiveValues++;
          c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin;
    c12_b_table[0U].SimMax = (real_T)c12_localMax;

    /* IsAlwaysInteger logging. */
    /* Data type is always integer. */
  }

  return c12_in;
}

static void c12_emlrtInitVarDataTables
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance,
   emlrtLocationLoggingDataType c12_dataTables[59],
   emlrtLocationLoggingHistogramType c12_histTables[59])
{
  int32_T c12_i;
  int32_T c12_iH;
  (void)chartInstance;
  for (c12_i = 0; c12_i < 59; c12_i++) {
    c12_dataTables[c12_i].SimMin = rtInf;
    c12_dataTables[c12_i].SimMax = rtMinusInf;
    c12_dataTables[c12_i].OverflowWraps = 0;
    c12_dataTables[c12_i].Saturations = 0;
    c12_dataTables[c12_i].IsAlwaysInteger = true;
    c12_dataTables[c12_i].HistogramTable = &c12_histTables[c12_i];
    c12_histTables[c12_i].NumberOfZeros = 0.0;
    c12_histTables[c12_i].NumberOfPositiveValues = 0.0;
    c12_histTables[c12_i].NumberOfNegativeValues = 0.0;
    c12_histTables[c12_i].TotalNumberOfValues = 0.0;
    c12_histTables[c12_i].SimSum = 0.0;
    for (c12_iH = 0; c12_iH < 256; c12_iH++) {
      c12_histTables[c12_i].HistogramOfPositiveValues[c12_iH] = 0.0;
      c12_histTables[c12_i].HistogramOfNegativeValues[c12_iH] = 0.0;
    }
  }
}

const mxArray *sf_c12_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c12_nameCaptureInfo = NULL;
  c12_nameCaptureInfo = NULL;
  sf_mex_assign(&c12_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c12_nameCaptureInfo;
}

static int32_T c12_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_o1, const char_T *c12_identifier)
{
  int32_T c12_y;
  emlrtMsgIdentifier c12_thisId;
  c12_thisId.fIdentifier = (const char *)c12_identifier;
  c12_thisId.fParent = NULL;
  c12_thisId.bParentIsCell = false;
  c12_y = c12_b_emlrt_marshallIn(chartInstance, c12_sp, sf_mex_dup(c12_b_o1),
    &c12_thisId);
  sf_mex_destroy(&c12_b_o1);
  return c12_y;
}

static int32_T c12_b_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId)
{
  int32_T c12_y;
  const mxArray *c12_mxFi = NULL;
  const mxArray *c12_mxInt = NULL;
  int32_T c12_i;
  (void)chartInstance;
  sf_mex_check_fi(c12_parentId, c12_u, false, 0U, NULL, c12_eml_mx, c12_b_eml_mx);
  sf_mex_assign(&c12_mxFi, sf_mex_dup(c12_u), false);
  sf_mex_assign(&c12_mxInt, sf_mex_call(c12_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c12_mxFi)), false);
  sf_mex_import(c12_parentId, sf_mex_dup(c12_mxInt), &c12_i, 1, 6, 0U, 0, 0U, 0);
  sf_mex_destroy(&c12_mxFi);
  sf_mex_destroy(&c12_mxInt);
  c12_y = c12_i;
  sf_mex_destroy(&c12_mxFi);
  sf_mex_destroy(&c12_u);
  return c12_y;
}

static uint32_T c12_c_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_trigged, const char_T
   *c12_identifier)
{
  uint32_T c12_y;
  emlrtMsgIdentifier c12_thisId;
  c12_thisId.fIdentifier = (const char *)c12_identifier;
  c12_thisId.fParent = NULL;
  c12_thisId.bParentIsCell = false;
  c12_y = c12_d_emlrt_marshallIn(chartInstance, c12_sp, sf_mex_dup(c12_b_trigged),
    &c12_thisId);
  sf_mex_destroy(&c12_b_trigged);
  return c12_y;
}

static uint32_T c12_d_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId)
{
  uint32_T c12_y;
  const mxArray *c12_mxFi = NULL;
  const mxArray *c12_mxInt = NULL;
  uint32_T c12_b_u;
  (void)chartInstance;
  sf_mex_check_fi(c12_parentId, c12_u, false, 0U, NULL, c12_eml_mx, c12_c_eml_mx);
  sf_mex_assign(&c12_mxFi, sf_mex_dup(c12_u), false);
  sf_mex_assign(&c12_mxInt, sf_mex_call(c12_sp, "interleavedsimulinkarray", 1U,
    1U, 14, sf_mex_dup(c12_mxFi)), false);
  sf_mex_import(c12_parentId, sf_mex_dup(c12_mxInt), &c12_b_u, 1, 7, 0U, 0, 0U,
                0);
  sf_mex_destroy(&c12_mxFi);
  sf_mex_destroy(&c12_mxInt);
  c12_y = c12_b_u;
  sf_mex_destroy(&c12_mxFi);
  sf_mex_destroy(&c12_u);
  return c12_y;
}

static uint8_T c12_e_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_after, const char_T *c12_identifier,
   boolean_T *c12_svPtr)
{
  uint8_T c12_y;
  emlrtMsgIdentifier c12_thisId;
  c12_thisId.fIdentifier = (const char *)c12_identifier;
  c12_thisId.fParent = NULL;
  c12_thisId.bParentIsCell = false;
  c12_y = c12_f_emlrt_marshallIn(chartInstance, c12_sp, sf_mex_dup(c12_b_after),
    &c12_thisId, c12_svPtr);
  sf_mex_destroy(&c12_b_after);
  return c12_y;
}

static uint8_T c12_f_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId, boolean_T *c12_svPtr)
{
  uint8_T c12_y;
  const mxArray *c12_mxFi = NULL;
  const mxArray *c12_mxInt = NULL;
  uint8_T c12_b_u;
  (void)chartInstance;
  if (mxIsEmpty(c12_u)) {
    *c12_svPtr = false;
  } else {
    *c12_svPtr = true;
    sf_mex_check_fi(c12_parentId, c12_u, false, 0U, NULL, c12_eml_mx,
                    c12_d_eml_mx);
    sf_mex_assign(&c12_mxFi, sf_mex_dup(c12_u), false);
    sf_mex_assign(&c12_mxInt, sf_mex_call(c12_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c12_mxFi)), false);
    sf_mex_import(c12_parentId, sf_mex_dup(c12_mxInt), &c12_b_u, 1, 3, 0U, 0, 0U,
                  0);
    sf_mex_destroy(&c12_mxFi);
    sf_mex_destroy(&c12_mxInt);
    c12_y = c12_b_u;
  }

  sf_mex_destroy(&c12_mxFi);
  sf_mex_destroy(&c12_u);
  return c12_y;
}

static void c12_g_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_b_fifo, const char_T *c12_identifier,
   boolean_T *c12_svPtr, int32_T c12_y[256])
{
  emlrtMsgIdentifier c12_thisId;
  c12_thisId.fIdentifier = (const char *)c12_identifier;
  c12_thisId.fParent = NULL;
  c12_thisId.bParentIsCell = false;
  c12_h_emlrt_marshallIn(chartInstance, c12_sp, sf_mex_dup(c12_b_fifo),
    &c12_thisId, c12_svPtr, c12_y);
  sf_mex_destroy(&c12_b_fifo);
}

static void c12_h_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const
   emlrtStack *c12_sp, const mxArray *c12_u, const emlrtMsgIdentifier
   *c12_parentId, boolean_T *c12_svPtr, int32_T c12_y[256])
{
  int32_T c12_i;
  uint32_T c12_uv[2];
  const mxArray *c12_mxFi = NULL;
  const mxArray *c12_mxInt = NULL;
  int32_T c12_iv[256];
  int32_T c12_b_i1;
  (void)chartInstance;
  for (c12_i = 0; c12_i < 2; c12_i++) {
    c12_uv[c12_i] = 4U + 60U * (uint32_T)c12_i;
  }

  if (mxIsEmpty(c12_u)) {
    *c12_svPtr = false;
  } else {
    *c12_svPtr = true;
    sf_mex_check_fi(c12_parentId, c12_u, false, 2U, c12_uv, c12_eml_mx,
                    c12_b_eml_mx);
    sf_mex_assign(&c12_mxFi, sf_mex_dup(c12_u), false);
    sf_mex_assign(&c12_mxInt, sf_mex_call(c12_sp, "interleavedsimulinkarray", 1U,
      1U, 14, sf_mex_dup(c12_mxFi)), false);
    sf_mex_import(c12_parentId, sf_mex_dup(c12_mxInt), c12_iv, 1, 6, 0U, 1, 0U,
                  2, 4, 64);
    sf_mex_destroy(&c12_mxFi);
    sf_mex_destroy(&c12_mxInt);
    for (c12_b_i1 = 0; c12_b_i1 < 256; c12_b_i1++) {
      c12_y[c12_b_i1] = c12_iv[c12_b_i1];
    }
  }

  sf_mex_destroy(&c12_mxFi);
  sf_mex_destroy(&c12_u);
}

static uint8_T c12_i_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c12_b_is_active_c12_zeabus_hydrophone_concrete, const char_T *c12_identifier)
{
  uint8_T c12_y;
  emlrtMsgIdentifier c12_thisId;
  c12_thisId.fIdentifier = (const char *)c12_identifier;
  c12_thisId.fParent = NULL;
  c12_thisId.bParentIsCell = false;
  c12_y = c12_j_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c12_b_is_active_c12_zeabus_hydrophone_concrete), &c12_thisId);
  sf_mex_destroy(&c12_b_is_active_c12_zeabus_hydrophone_concrete);
  return c12_y;
}

static uint8_T c12_j_emlrt_marshallIn
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, const mxArray *
   c12_u, const emlrtMsgIdentifier *c12_parentId)
{
  uint8_T c12_y;
  uint8_T c12_b_u;
  (void)chartInstance;
  sf_mex_import(c12_parentId, sf_mex_dup(c12_u), &c12_b_u, 1, 3, 0U, 0, 0U, 0);
  c12_y = c12_b_u;
  sf_mex_destroy(&c12_u);
  return c12_y;
}

static const mxArray *c12_chart_data_browse_helper
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_ssIdNumber)
{
  const mxArray *c12_mxData = NULL;
  int32_T c12_i;
  int32_T c12_b_i1;
  int32_T c12_b_i2;
  int32_T c12_b_i3;
  int32_T c12_b_i4;
  uint16_T c12_u;
  int32_T c12_i5;
  int32_T c12_i6;
  int32_T c12_i7;
  uint32_T c12_u1;
  real_T c12_d;
  real_T c12_d1;
  real_T c12_d2;
  real_T c12_d3;
  real_T c12_d4;
  real_T c12_d5;
  real_T c12_d6;
  real_T c12_d7;
  real_T c12_d8;
  real_T c12_d9;
  c12_mxData = NULL;
  switch (c12_ssIdNumber) {
   case 8U:
    c12_i = *chartInstance->c12_i1;
    c12_d = (real_T)c12_i * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 9U:
    c12_b_i1 = *chartInstance->c12_i2;
    c12_d1 = (real_T)c12_b_i1 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d1, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 10U:
    c12_b_i2 = *chartInstance->c12_i3;
    c12_d2 = (real_T)c12_b_i2 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d2, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 11U:
    c12_b_i3 = *chartInstance->c12_i4;
    c12_d3 = (real_T)c12_b_i3 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d3, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 5U:
    c12_b_i4 = *chartInstance->c12_o1;
    c12_d4 = (real_T)c12_b_i4 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d4, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 6U:
    c12_u = *chartInstance->c12_threshold;
    c12_d5 = (real_T)c12_u * 1.52587890625E-5;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d5, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 12U:
    c12_i5 = *chartInstance->c12_o2;
    c12_d6 = (real_T)c12_i5 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d6, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 13U:
    c12_i6 = *chartInstance->c12_o3;
    c12_d7 = (real_T)c12_i6 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d7, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 14U:
    c12_i7 = *chartInstance->c12_o4;
    c12_d8 = (real_T)c12_i7 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d8, 0, 0U, 0U, 0U, 0),
                  false);
    break;

   case 15U:
    c12_u1 = *chartInstance->c12_trigged;
    c12_d9 = (real_T)c12_u1 * 7.62939453125E-6;
    sf_mex_assign(&c12_mxData, sf_mex_create("mxData", &c12_d9, 0, 0U, 0U, 0U, 0),
                  false);
    break;
  }

  return c12_mxData;
}

static void c12_b_emlrt_update_log_4
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[256], emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  int32_T c12_i;
  int32_T c12_localMin;
  real_T c12_d1;
  int32_T c12_b_i1;
  int32_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  int32_T c12_b_i;
  int32_T c12_c_i;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = muDoubleScalarFloor(c12_b_table[0U].SimMin * 131072.0);
    if (c12_d < 131072.0) {
      if (c12_d >= -131072.0) {
        c12_i = (int32_T)c12_d;
      } else {
        c12_i = -131072;
      }
    } else if (c12_d >= 131072.0) {
      c12_i = 131071;
    } else {
      c12_i = 0;
    }

    c12_localMin = c12_i;
    c12_d1 = muDoubleScalarFloor(c12_b_table[0U].SimMax * 131072.0);
    if (c12_d1 < 131072.0) {
      if (c12_d1 >= -131072.0) {
        c12_b_i1 = (int32_T)c12_d1;
      } else {
        c12_b_i1 = -131072;
      }
    } else if (c12_d1 >= 131072.0) {
      c12_b_i1 = 131071;
    } else {
      c12_b_i1 = 0;
    }

    c12_localMax = c12_b_i1;
    c12_histTable = c12_b_table[0U].HistogramTable;
    for (c12_b_i = 0; c12_b_i < 256; c12_b_i++) {
      /* Simulation Min-Max logging. */
      if (c12_in[c12_b_i] < c12_localMin) {
        c12_localMin = c12_in[c12_b_i];
      }

      if (c12_in[c12_b_i] > c12_localMax) {
        c12_localMax = c12_in[c12_b_i];
      }

      /* Histogram logging. */
      c12_inDouble = (real_T)c12_in[c12_b_i] * 7.62939453125E-6;
      c12_histTable->TotalNumberOfValues++;
      if (c12_inDouble == 0.0) {
        c12_histTable->NumberOfZeros++;
      } else {
        c12_histTable->SimSum += c12_inDouble;
        if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
             (c12_inDouble))) {
          c12_significand = frexp(c12_inDouble, &c12_exponent);
          if (c12_exponent > 128) {
            c12_exponent = 128;
          }

          if (c12_exponent < -127) {
            c12_exponent = -127;
          }

          if (c12_significand < 0.0) {
            c12_histTable->NumberOfNegativeValues++;
            c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
          } else {
            c12_histTable->NumberOfPositiveValues++;
            c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
          }
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin * 7.62939453125E-6;
    c12_b_table[0U].SimMax = (real_T)c12_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c12_c_i = 0;
    while (c12_b_table[0U].IsAlwaysInteger && (c12_c_i < 256)) {
      if (((uint32_T)c12_in[c12_c_i] & 131071U) != 0U) {
        c12_b_table[0U].IsAlwaysInteger = false;
      }

      c12_c_i++;
    }
  }
}

static void c12_b_emlrt_update_log_7
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance, int32_T
   c12_in[252], emlrtLocationLoggingDataType c12_table[], int32_T c12_index)
{
  boolean_T c12_isLoggingEnabledHere;
  emlrtLocationLoggingDataType *c12_b_table;
  real_T c12_d;
  int32_T c12_i;
  int32_T c12_localMin;
  real_T c12_d1;
  int32_T c12_b_i1;
  int32_T c12_localMax;
  emlrtLocationLoggingHistogramType *c12_histTable;
  int32_T c12_b_i;
  int32_T c12_c_i;
  real_T c12_inDouble;
  real_T c12_significand;
  int32_T c12_exponent;
  (void)chartInstance;
  c12_isLoggingEnabledHere = (c12_index >= 0);
  if (c12_isLoggingEnabledHere) {
    c12_b_table = (emlrtLocationLoggingDataType *)&c12_table[c12_index];
    c12_d = muDoubleScalarFloor(c12_b_table[0U].SimMin * 131072.0);
    if (c12_d < 131072.0) {
      if (c12_d >= -131072.0) {
        c12_i = (int32_T)c12_d;
      } else {
        c12_i = -131072;
      }
    } else if (c12_d >= 131072.0) {
      c12_i = 131071;
    } else {
      c12_i = 0;
    }

    c12_localMin = c12_i;
    c12_d1 = muDoubleScalarFloor(c12_b_table[0U].SimMax * 131072.0);
    if (c12_d1 < 131072.0) {
      if (c12_d1 >= -131072.0) {
        c12_b_i1 = (int32_T)c12_d1;
      } else {
        c12_b_i1 = -131072;
      }
    } else if (c12_d1 >= 131072.0) {
      c12_b_i1 = 131071;
    } else {
      c12_b_i1 = 0;
    }

    c12_localMax = c12_b_i1;
    c12_histTable = c12_b_table[0U].HistogramTable;
    for (c12_b_i = 0; c12_b_i < 252; c12_b_i++) {
      /* Simulation Min-Max logging. */
      if (c12_in[c12_b_i] < c12_localMin) {
        c12_localMin = c12_in[c12_b_i];
      }

      if (c12_in[c12_b_i] > c12_localMax) {
        c12_localMax = c12_in[c12_b_i];
      }

      /* Histogram logging. */
      c12_inDouble = (real_T)c12_in[c12_b_i] * 7.62939453125E-6;
      c12_histTable->TotalNumberOfValues++;
      if (c12_inDouble == 0.0) {
        c12_histTable->NumberOfZeros++;
      } else {
        c12_histTable->SimSum += c12_inDouble;
        if ((!muDoubleScalarIsInf(c12_inDouble)) && (!muDoubleScalarIsNaN
             (c12_inDouble))) {
          c12_significand = frexp(c12_inDouble, &c12_exponent);
          if (c12_exponent > 128) {
            c12_exponent = 128;
          }

          if (c12_exponent < -127) {
            c12_exponent = -127;
          }

          if (c12_significand < 0.0) {
            c12_histTable->NumberOfNegativeValues++;
            c12_histTable->HistogramOfNegativeValues[127 + c12_exponent]++;
          } else {
            c12_histTable->NumberOfPositiveValues++;
            c12_histTable->HistogramOfPositiveValues[127 + c12_exponent]++;
          }
        }
      }
    }

    c12_b_table[0U].SimMin = (real_T)c12_localMin * 7.62939453125E-6;
    c12_b_table[0U].SimMax = (real_T)c12_localMax * 7.62939453125E-6;

    /* IsAlwaysInteger logging. */
    c12_c_i = 0;
    while (c12_b_table[0U].IsAlwaysInteger && (c12_c_i < 252)) {
      if (((uint32_T)c12_in[c12_c_i] & 131071U) != 0U) {
        c12_b_table[0U].IsAlwaysInteger = false;
      }

      c12_c_i++;
    }
  }
}

static uint32_T c12__u32_add__(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c12_b, uint32_T c12_c, int32_T c12_EMLOvCount_src_loc,
  uint32_T c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T
  c12_length_src_loc)
{
  uint32_T c12_a;
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  c12_a = c12_b + c12_c;
  if (c12_a < c12_b) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return c12_a;
}

static uint8_T c12__u8_u32_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint32_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc)
{
  uint8_T c12_a;
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  c12_a = (uint8_T)c12_b;
  if (c12_a != c12_b) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return c12_a;
}

static uint8_T c12__u8_s16_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int16_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc)
{
  uint8_T c12_a;
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  c12_a = (uint8_T)c12_b;
  if ((int16_T)c12_a != c12_b) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return c12_a;
}

static int32_T c12__s32_minus__(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c12_b, int32_T c12_c, int32_T c12_EMLOvCount_src_loc,
  uint32_T c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T
  c12_length_src_loc)
{
  int32_T c12_a;
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  c12_a = c12_b - c12_c;
  if (((c12_b ^ c12_a) & (c12_b ^ c12_c)) < 0) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return c12_a;
}

static int16_T c12__s16_s32_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, int32_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc)
{
  int16_T c12_a;
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  c12_a = (int16_T)c12_b;
  if (c12_a != c12_b) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return c12_a;
}

static int8_T c12__s8_u8_(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance, uint8_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc)
{
  int8_T c12_a;
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  c12_a = (int8_T)c12_b;
  if (c12_a < 0) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return c12_a;
}

static int32_T c12__s32_uminus__(SFc12_zeabus_hydrophone_concreteInstanceStruct *
  chartInstance, int32_T c12_b, int32_T c12_EMLOvCount_src_loc, uint32_T
  c12_ssid_src_loc, int32_T c12_offset_src_loc, int32_T c12_length_src_loc)
{
  int32_T c12_PICOffset;
  real_T c12_d;
  observerLogReadPIC(&c12_PICOffset);
  if (c12_b < -2147483647) {
    sf_data_overflow_error(chartInstance->S, c12_ssid_src_loc,
      c12_offset_src_loc, c12_length_src_loc);
    c12_d = 1.0;
    observerLog(c12_EMLOvCount_src_loc + c12_PICOffset, &c12_d, 1);
  }

  return -c12_b;
}

static void init_dsm_address_info(SFc12_zeabus_hydrophone_concreteInstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address
  (SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance)
{
  chartInstance->c12_covrtInstance = (CovrtStateflowInstance *)
    sfrtGetCovrtInstance(chartInstance->S);
  chartInstance->c12_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c12_i1 = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c12_i2 = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c12_i3 = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c12_i4 = (int32_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 3);
  chartInstance->c12_o1 = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c12_threshold = (uint16_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 4);
  chartInstance->c12_o2 = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c12_o3 = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 3);
  chartInstance->c12_o4 = (int32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 4);
  chartInstance->c12_trigged = (uint32_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 5);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c12_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3930346532U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(4252797633U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1594287409U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3293651676U);
}

mxArray *sf_c12_zeabus_hydrophone_concrete_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c12_zeabus_hydrophone_concrete_jit_fallback_info(void)
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

mxArray *sf_c12_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c12_zeabus_hydrophone_concrete(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiA+wcnAwAakOYCYiQECWKF8RiDmhNIQcRa4uAIQl1QWpILEi4uSPVOAdF5iLpi"
    "fWFrhmZeWDzbfggFhPhsW8xmRzOeEikPAB3vK9Is4gPQbIOlnwaKfCUm/AJCXbwgJF1j4DJz7Nc"
    "hzv9Fgcb8Wee43Hizu1yHP/SaDxf16Duj6sbmfHcX9EH5JUWZ6emoKlfwh4ECZfkz7sfmDFc0fI"
    "H5iWklqEVT/BQb85RwjWjkHi1eQnhyGTIYCqDkOBPzBhOYPAbgvCh3AVEAhVcJjqMQLG1q8gPhJ"
    "qWn5RamDJF4UiiDx0lA0rOKFULnFghIvLAxpmWn5gyI+Aooh8TGheJDEhwJV3BFBID400PIJiJ9"
    "ZHJ+YXJJZlhqfbGgUX5WamFRaHJ9RmVKUX5CRnwcUzc9LLkotSYX5EwBHK0zQ"
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c12_zeabus_hydrophone_concrete_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "s5NXWoVxdJOtFXLRuJHMT4F";
}

static void sf_opaque_initialize_c12_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  initialize_params_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
  initialize_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c12_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  enable_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c12_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  disable_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c12_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  sf_gateway_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c12_zeabus_hydrophone_concrete
  (SimStruct* S)
{
  return get_sim_state_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct *)sf_get_chart_instance_ptr
     (S));                             /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c12_zeabus_hydrophone_concrete(SimStruct* S,
  const mxArray *st)
{
  set_sim_state_c12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*)sf_get_chart_instance_ptr
     (S), st);
}

static void sf_opaque_terminate_c12_zeabus_hydrophone_concrete(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc12_zeabus_hydrophone_concreteInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_zeabus_hydrophone_concrete_optimization_info();
    }

    finalize_c12_zeabus_hydrophone_concrete
      ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc12_zeabus_hydrophone_concrete
    ((SFc12_zeabus_hydrophone_concreteInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c12_zeabus_hydrophone_concrete(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  sf_warn_if_symbolic_dimension_param_changed(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c12_zeabus_hydrophone_concrete
      ((SFc12_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
    initSimStructsc12_zeabus_hydrophone_concrete
      ((SFc12_zeabus_hydrophone_concreteInstanceStruct*)
       sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c12_zeabus_hydrophone_concrete_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [19] = {
    "eNrtWM1u20YQXgmyWwWtq0OBXHrwrUZQFE2aAr1FtX4QBXIsRI5j9CKsyJG4ELlL748s55RbLz3",
    "kHXLtM+ScY6655NAn6CN0lqJsmSLFyHJT9WcBmlj6m9lv5hvOckUKrQOCYwevk9uEbOP9U7yKZD",
    "q24nlh7po+L5Gv4/krBHETdKikgSJLB6cBPAElfKOZ4C0+EKkwxgcggTuIDYXUWd4UC4zP+Khpu",
    "GP9qWcec7yuJ4zv7qMtdQ+5f47eQqM76KfOJDi6CeBqTwoz9Jo+HV4wlvqs5oEzUiZYFoIC3TWh",
    "paUOjK9Z6ENjAk6LK02Rsbrk1tVUQ01PMsO0karuDCiC0GeUp0brUdWFEBOs4Wno4t9DozGoJMz",
    "xqNT74NExqDYbRT4Fh6RPpvAffcapFpJRvxH4NWu4yK3jI58D4YK/JCHIbV8CHYWCcZ2tf7eJkT",
    "Y47ftQh74ZZnvrwqmx4h8zOAOZmbdBTYxB0iEc8sxFo4Q0JpFaF1WyCNMsgGMqf3JQPwVuZvVi5",
    "aguRZ3gCC2yYBAF2VJHko0xvZneTNCylZn3yphgKrbKg0XeGmNYpsKFt6bDa9T3VSbsSIRtGIMf",
    "ea1TTZfDpl7TcaEUIR1i1bqYZFviNcFdtqCFY5QWQQ3Lrd5uP8ZOkU7uEtbiGuSAOpD23irHA9f",
    "4gIFiZ9LRcilOXaasWjmoWNM8FFEDw+tnQo4w0CWv/WUIVoNMYKCGmH2s3acKy3wZzGY/Fzfr89",
    "+Ryz7/2Qf0+Zld8r4356eQ4ofM3S3+xzl8uXgVv5VYtzh7ZkdsX52z/zyxXilhb3EVvF6/efnzq",
    "8pvv77+/f27L279Uk/Gn+RRWOBRILP1J7dW2x934vlXs0Z0Uabjheqw2IdzvEop/m/P+a/Ec/XD",
    "45Nn4njiPjrUzZP2E/Po4cHR/Wbk7015Od9ygu/s+a7tiOdh1N+UdFpuvHHbOTXT7Syp53ZOPsr",
    "x8+n448F69l9Wkzqm5at4JV9FIu5erd+/j//e9fjf2xT+d67H//tN4f/N9fjf3xT+31aT9mn8P0",
    "n0CzvXkg2H+IVzM3FUquvZL66fFsdWIg47pwMdfRpa+7dktb4809Xa+ISRMGV/2c6ph3LMZTpOq",
    "9Gtc3oj+fin6LKd0MXO+zAQEjZEl1051eWF/Ffpkte3Sld0KZEBG4iN0KOjpnq8VBuix+6N8DjJ",
    "0WMv8Z7sRefXHsXT6Bh6zt17vedA+0b1vHMXT0oenth7juCOBA07Gbqv8t26qh35324j7Ar/wfg",
    "+5Dy69ZHtyEe2Wze+Vc/lq+KX7T8kga+ssc5fjV/394xV8H8CG1ySHQ==",
    ""
  };

  static char newstr [1333] = "";
  newstr[0] = '\0';
  for (i = 0; i < 19; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c12_zeabus_hydrophone_concrete(SimStruct *S)
{
  const char* newstr = sf_c12_zeabus_hydrophone_concrete_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(1519438014U));
  ssSetChecksum1(S,(2360086691U));
  ssSetChecksum2(S,(3655262910U));
  ssSetChecksum3(S,(1149700623U));
}

static void mdlRTW_c12_zeabus_hydrophone_concrete(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c12_zeabus_hydrophone_concrete(SimStruct *S)
{
  SFc12_zeabus_hydrophone_concreteInstanceStruct *chartInstance;
  chartInstance = (SFc12_zeabus_hydrophone_concreteInstanceStruct *)utMalloc
    (sizeof(SFc12_zeabus_hydrophone_concreteInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc12_zeabus_hydrophone_concreteInstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  if (ssGetSampleTime(S, 0) == CONTINUOUS_SAMPLE_TIME && ssGetOffsetTime(S, 0) ==
      0 && ssGetNumContStates(ssGetRootSS(S)) > 0) {
    sf_error_out_about_continuous_sample_time_with_persistent_vars(S);
  }

  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlStart = mdlStart_c12_zeabus_hydrophone_concrete;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c12_zeabus_hydrophone_concrete;
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
    chartInstance->c12_JITStateAnimation,
    chartInstance->c12_JITTransitionAnimation);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_start_c12_zeabus_hydrophone_concrete(chartInstance);
}

void c12_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T method,
  void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c12_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c12_zeabus_hydrophone_concrete(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c12_zeabus_hydrophone_concrete(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c12_zeabus_hydrophone_concrete_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
