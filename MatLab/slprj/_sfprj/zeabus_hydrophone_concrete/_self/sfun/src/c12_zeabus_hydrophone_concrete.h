#ifndef __c12_zeabus_hydrophone_concrete_h__
#define __c12_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc12_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc12_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c12_sfEvent;
  boolean_T c12_doneDoubleBufferReInit;
  uint8_T c12_is_active_c12_zeabus_hydrophone_concrete;
  uint8_T c12_JITStateAnimation[1];
  uint8_T c12_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c12_emlrtLocationLoggingDataTables[59];
  void *c12_RuntimeVar;
  uint8_T c12_after;
  boolean_T c12_after_not_empty;
  uint8_T c12_before;
  boolean_T c12_before_not_empty;
  int32_T c12_fifo[256];
  boolean_T c12_fifo_not_empty;
  emlrtLocationLoggingHistogramType c12_emlrtLocLogHistTables[59];
  boolean_T c12_emlrtLocLogSimulated;
  uint32_T c12_mlFcnLineNumber;
  void *c12_fcnDataPtrs[20];
  char_T *c12_dataNames[20];
  uint32_T c12_numFcnVars;
  uint32_T c12_ssIds[20];
  uint32_T c12_statuses[20];
  void *c12_outMexFcns[20];
  void *c12_inMexFcns[20];
  CovrtStateflowInstance *c12_covrtInstance;
  void *c12_fEmlrtCtx;
  int32_T *c12_i1;
  int32_T *c12_i2;
  int32_T *c12_i3;
  int32_T *c12_i4;
  int32_T *c12_o1;
  uint16_T *c12_threshold;
  int32_T *c12_o2;
  int32_T *c12_o3;
  int32_T *c12_o4;
  uint32_T *c12_trigged;
} SFc12_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc12_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c12_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c12_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c12_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
