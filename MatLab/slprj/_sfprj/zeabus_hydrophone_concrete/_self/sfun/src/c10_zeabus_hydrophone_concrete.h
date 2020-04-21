#ifndef __c10_zeabus_hydrophone_concrete_h__
#define __c10_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc10_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc10_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c10_sfEvent;
  boolean_T c10_doneDoubleBufferReInit;
  uint8_T c10_is_active_c10_zeabus_hydrophone_concrete;
  uint8_T c10_JITStateAnimation[1];
  uint8_T c10_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c10_emlrtLocationLoggingDataTables[18];
  void *c10_RuntimeVar;
  int32_T c10_acc;
  boolean_T c10_acc_not_empty;
  uint8_T c10_counter;
  boolean_T c10_counter_not_empty;
  int32_T c10_avg;
  boolean_T c10_avg_not_empty;
  emlrtLocationLoggingHistogramType c10_emlrtLocLogHistTables[18];
  boolean_T c10_emlrtLocLogSimulated;
  uint32_T c10_mlFcnLineNumber;
  void *c10_fcnDataPtrs[6];
  char_T *c10_dataNames[6];
  uint32_T c10_numFcnVars;
  uint32_T c10_ssIds[6];
  uint32_T c10_statuses[6];
  void *c10_outMexFcns[6];
  void *c10_inMexFcns[6];
  CovrtStateflowInstance *c10_covrtInstance;
  void *c10_fEmlrtCtx;
  int32_T *c10_u;
  int32_T *c10_y;
} SFc10_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc10_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c10_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c10_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c10_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
