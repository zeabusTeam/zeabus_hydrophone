#ifndef __c16_zeabus_hydrophone_concrete_h__
#define __c16_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc16_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc16_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c16_sfEvent;
  boolean_T c16_doneDoubleBufferReInit;
  uint8_T c16_is_active_c16_zeabus_hydrophone_concrete;
  uint8_T c16_JITStateAnimation[1];
  uint8_T c16_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c16_emlrtLocationLoggingDataTables[52];
  void *c16_RuntimeVar;
  int32_T c16_d[5];
  boolean_T c16_d_not_empty;
  emlrtLocationLoggingHistogramType c16_emlrtLocLogHistTables[52];
  boolean_T c16_emlrtLocLogSimulated;
  uint32_T c16_mlFcnLineNumber;
  void *c16_fcnDataPtrs[23];
  char_T *c16_dataNames[23];
  uint32_T c16_numFcnVars;
  uint32_T c16_ssIds[23];
  uint32_T c16_statuses[23];
  void *c16_outMexFcns[23];
  void *c16_inMexFcns[23];
  CovrtStateflowInstance *c16_covrtInstance;
  void *c16_fEmlrtCtx;
  int32_T *c16_u;
  int32_T *c16_y;
} SFc16_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc16_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c16_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c16_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c16_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
