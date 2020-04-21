#ifndef __c13_zeabus_hydrophone_concrete_h__
#define __c13_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc13_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc13_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c13_sfEvent;
  boolean_T c13_doneDoubleBufferReInit;
  uint8_T c13_is_active_c13_zeabus_hydrophone_concrete;
  uint8_T c13_JITStateAnimation[1];
  uint8_T c13_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c13_emlrtLocationLoggingDataTables[18];
  void *c13_RuntimeVar;
  int32_T c13_acc;
  boolean_T c13_acc_not_empty;
  uint8_T c13_counter;
  boolean_T c13_counter_not_empty;
  int32_T c13_avg;
  boolean_T c13_avg_not_empty;
  emlrtLocationLoggingHistogramType c13_emlrtLocLogHistTables[18];
  boolean_T c13_emlrtLocLogSimulated;
  uint32_T c13_mlFcnLineNumber;
  void *c13_fcnDataPtrs[6];
  char_T *c13_dataNames[6];
  uint32_T c13_numFcnVars;
  uint32_T c13_ssIds[6];
  uint32_T c13_statuses[6];
  void *c13_outMexFcns[6];
  void *c13_inMexFcns[6];
  CovrtStateflowInstance *c13_covrtInstance;
  void *c13_fEmlrtCtx;
  int32_T *c13_u;
  int32_T *c13_y;
} SFc13_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc13_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c13_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c13_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c13_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
