#ifndef __c15_zeabus_hydrophone_concrete_h__
#define __c15_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc15_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc15_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c15_sfEvent;
  boolean_T c15_doneDoubleBufferReInit;
  uint8_T c15_is_active_c15_zeabus_hydrophone_concrete;
  uint8_T c15_JITStateAnimation[1];
  uint8_T c15_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c15_emlrtLocationLoggingDataTables[52];
  void *c15_RuntimeVar;
  int32_T c15_d[5];
  boolean_T c15_d_not_empty;
  emlrtLocationLoggingHistogramType c15_emlrtLocLogHistTables[52];
  boolean_T c15_emlrtLocLogSimulated;
  uint32_T c15_mlFcnLineNumber;
  void *c15_fcnDataPtrs[23];
  char_T *c15_dataNames[23];
  uint32_T c15_numFcnVars;
  uint32_T c15_ssIds[23];
  uint32_T c15_statuses[23];
  void *c15_outMexFcns[23];
  void *c15_inMexFcns[23];
  CovrtStateflowInstance *c15_covrtInstance;
  void *c15_fEmlrtCtx;
  int32_T *c15_u;
  int32_T *c15_y;
} SFc15_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc15_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c15_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c15_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c15_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
