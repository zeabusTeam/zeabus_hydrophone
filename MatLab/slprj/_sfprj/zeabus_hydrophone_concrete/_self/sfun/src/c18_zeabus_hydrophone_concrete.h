#ifndef __c18_zeabus_hydrophone_concrete_h__
#define __c18_zeabus_hydrophone_concrete_h__

/* Type Definitions */
#ifndef typedef_SFc18_zeabus_hydrophone_concreteInstanceStruct
#define typedef_SFc18_zeabus_hydrophone_concreteInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  int32_T c18_sfEvent;
  boolean_T c18_doneDoubleBufferReInit;
  uint8_T c18_is_active_c18_zeabus_hydrophone_concrete;
  uint8_T c18_JITStateAnimation[1];
  uint8_T c18_JITTransitionAnimation[1];
  emlrtLocationLoggingDataType c18_emlrtLocationLoggingDataTables[52];
  void *c18_RuntimeVar;
  int32_T c18_d[5];
  boolean_T c18_d_not_empty;
  emlrtLocationLoggingHistogramType c18_emlrtLocLogHistTables[52];
  boolean_T c18_emlrtLocLogSimulated;
  uint32_T c18_mlFcnLineNumber;
  void *c18_fcnDataPtrs[23];
  char_T *c18_dataNames[23];
  uint32_T c18_numFcnVars;
  uint32_T c18_ssIds[23];
  uint32_T c18_statuses[23];
  void *c18_outMexFcns[23];
  void *c18_inMexFcns[23];
  CovrtStateflowInstance *c18_covrtInstance;
  void *c18_fEmlrtCtx;
  int32_T *c18_u;
  int32_T *c18_y;
} SFc18_zeabus_hydrophone_concreteInstanceStruct;

#endif                                 /*typedef_SFc18_zeabus_hydrophone_concreteInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c18_zeabus_hydrophone_concrete_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c18_zeabus_hydrophone_concrete_get_check_sum(mxArray *plhs[]);
extern void c18_zeabus_hydrophone_concrete_method_dispatcher(SimStruct *S, int_T
  method, void *data);

#endif
