#ifndef __c14_zeabus_hydrophone_concrete_h__
#define __c14_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc14_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc14_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c14_sfEvent;
  boolean_T c14_doneDoubleBufferReInit;
  uint8_T c14_is_active_c14_zeabus_hydrophone_concrete;
  uint8_T c14_JITStateAnimation[1];
  uint8_T c14_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c14_emlrtLocationLoggingDataTables[18];
  void *c14_RuntimeVar;
  int32_T c14_acc;
  boolean_T c14_acc_not_empty;
  uint8_T c14_counter;
  boolean_T c14_counter_not_empty;
  int32_T c14_avg;
  boolean_T c14_avg_not_empty;
  emlrtLocationLoggingHistogramType c14_emlrtLocLogHistTables[18];
  boolean_T c14_emlrtLocLogSimulated;
  uint32_T c14_mlFcnLineNumber;
  void *c14_fcnDataPtrs[6];
  char_T *c14_dataNames[6];
  uint32_T c14_numFcnVars;
  uint32_T c14_ssIds[6];
  uint32_T c14_statuses[6];
  void *c14_outMexFcns[6];
  void *c14_inMexFcns[6];
  CovrtStateflowInstance *c14_covrtInstance;
  void *c14_fEmlrtCtx;
  int32_T *c14_u;
  int32_T *c14_y;
} SFc14_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc14_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c14_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c14_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c14_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
