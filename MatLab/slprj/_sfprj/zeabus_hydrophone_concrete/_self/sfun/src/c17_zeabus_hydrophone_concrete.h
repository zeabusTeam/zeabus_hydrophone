#ifndef __c17_zeabus_hydrophone_concrete_h__
#define __c17_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc17_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc17_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c17_sfEvent;
  boolean_T c17_doneDoubleBufferReInit;
  uint8_T c17_is_active_c17_zeabus_hydrophone_concrete;
  uint8_T c17_JITStateAnimation[1];
  uint8_T c17_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c17_emlrtLocationLoggingDataTables[52];
  void *c17_RuntimeVar;
  int32_T c17_d[5];
  boolean_T c17_d_not_empty;
  emlrtLocationLoggingHistogramType c17_emlrtLocLogHistTables[52];
  boolean_T c17_emlrtLocLogSimulated;
  uint32_T c17_mlFcnLineNumber;
  void *c17_fcnDataPtrs[23];
  char_T *c17_dataNames[23];
  uint32_T c17_numFcnVars;
  uint32_T c17_ssIds[23];
  uint32_T c17_statuses[23];
  void *c17_outMexFcns[23];
  void *c17_inMexFcns[23];
  CovrtStateflowInstance *c17_covrtInstance;
  void *c17_fEmlrtCtx;
  int32_T *c17_u;
  int32_T *c17_y;
} SFc17_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc17_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c17_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c17_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c17_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
