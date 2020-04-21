#ifndef __c11_zeabus_hydrophone_concrete_h__
#define __c11_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc11_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc11_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c11_sfEvent;
  boolean_T c11_doneDoubleBufferReInit;
  uint8_T c11_is_active_c11_zeabus_hydrophone_concrete;
  uint8_T c11_JITStateAnimation[1];
  uint8_T c11_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c11_emlrtLocationLoggingDataTables[18];
  void *c11_RuntimeVar;
  int32_T c11_acc;
  boolean_T c11_acc_not_empty;
  uint8_T c11_counter;
  boolean_T c11_counter_not_empty;
  int32_T c11_avg;
  boolean_T c11_avg_not_empty;
  emlrtLocationLoggingHistogramType c11_emlrtLocLogHistTables[18];
  boolean_T c11_emlrtLocLogSimulated;
  uint32_T c11_mlFcnLineNumber;
  void *c11_fcnDataPtrs[6];
  char_T *c11_dataNames[6];
  uint32_T c11_numFcnVars;
  uint32_T c11_ssIds[6];
  uint32_T c11_statuses[6];
  void *c11_outMexFcns[6];
  void *c11_inMexFcns[6];
  CovrtStateflowInstance *c11_covrtInstance;
  void *c11_fEmlrtCtx;
  int32_T *c11_u;
  int32_T *c11_y;
} SFc11_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc11_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c11_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c11_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c11_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
