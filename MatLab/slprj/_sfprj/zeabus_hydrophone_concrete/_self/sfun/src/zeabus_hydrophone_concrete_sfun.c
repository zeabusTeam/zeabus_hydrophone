/* Include files */

#include "zeabus_hydrophone_concrete_sfun.h"
#include "c10_zeabus_hydrophone_concrete.h"
#include "c11_zeabus_hydrophone_concrete.h"
#include "c12_zeabus_hydrophone_concrete.h"
#include "c13_zeabus_hydrophone_concrete.h"
#include "c14_zeabus_hydrophone_concrete.h"
#include "c15_zeabus_hydrophone_concrete.h"
#include "c16_zeabus_hydrophone_concrete.h"
#include "c17_zeabus_hydrophone_concrete.h"
#include "c18_zeabus_hydrophone_concrete.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
void zeabus_hydrophone_concrete_initializer(void)
{
}

void zeabus_hydrophone_concrete_terminator(void)
{
}

/* SFunction Glue Code */
unsigned int sf_zeabus_hydrophone_concrete_method_dispatcher(SimStruct
  *simstructPtr, unsigned int chartFileNumber, const char* specsCksum, int_T
  method, void *data)
{
  if (chartFileNumber==10) {
    c10_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==11) {
    c11_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==12) {
    c12_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==13) {
    c13_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==14) {
    c14_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==15) {
    c15_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==16) {
    c16_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==17) {
    c17_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  if (chartFileNumber==18) {
    c18_zeabus_hydrophone_concrete_method_dispatcher(simstructPtr, method, data);
    return 1;
  }

  return 0;
}

unsigned int sf_zeabus_hydrophone_concrete_process_check_sum_call( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[20];
  if (nrhs<1 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the checksum */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"sf_get_check_sum"))
    return 0;
  plhs[0] = mxCreateDoubleMatrix( 1,4,mxREAL);
  if (nrhs>1 && mxIsChar(prhs[1])) {
    mxGetString(prhs[1], commandName,sizeof(commandName)/sizeof(char));
    commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
    if (!strcmp(commandName,"machine")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2468362201U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3191730937U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3350600620U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3051711596U);
    } else if (nrhs==3 && !strcmp(commandName,"chart")) {
      unsigned int chartFileNumber;
      chartFileNumber = (unsigned int)mxGetScalar(prhs[2]);
      switch (chartFileNumber) {
       case 10:
        {
          extern void sf_c10_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c10_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 11:
        {
          extern void sf_c11_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c11_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 12:
        {
          extern void sf_c12_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c12_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 13:
        {
          extern void sf_c13_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c13_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 14:
        {
          extern void sf_c14_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c14_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 15:
        {
          extern void sf_c15_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c15_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 16:
        {
          extern void sf_c16_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c16_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 17:
        {
          extern void sf_c17_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c17_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       case 18:
        {
          extern void sf_c18_zeabus_hydrophone_concrete_get_check_sum(mxArray
            *plhs[]);
          sf_c18_zeabus_hydrophone_concrete_get_check_sum(plhs);
          break;
        }

       default:
        ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0.0);
      }
    } else if (!strcmp(commandName,"target")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2019869091U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(658008460U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2154569864U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3628330373U);
    } else {
      return 0;
    }
  } else {
    ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1924070876U);
    ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(428864483U);
    ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1701944776U);
    ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(755568693U);
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_zeabus_hydrophone_concrete_get_eml_resolved_functions_info( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[64];
  char instanceChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the get_eml_resolved_functions_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_eml_resolved_functions_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    mxGetString(prhs[2], instanceChksum,sizeof(instanceChksum)/sizeof(char));
    instanceChksum[(sizeof(instanceChksum)/sizeof(char)-1)] = '\0';
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 10:
      {
        if (strcmp(instanceChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern const mxArray
            *sf_c10_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c10_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 11:
      {
        if (strcmp(instanceChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern const mxArray
            *sf_c11_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c11_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 12:
      {
        if (strcmp(instanceChksum, "s5NXWoVxdJOtFXLRuJHMT4F") == 0) {
          extern const mxArray
            *sf_c12_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c12_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 13:
      {
        if (strcmp(instanceChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern const mxArray
            *sf_c13_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c13_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 14:
      {
        if (strcmp(instanceChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern const mxArray
            *sf_c14_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c14_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 15:
      {
        if (strcmp(instanceChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern const mxArray
            *sf_c15_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c15_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 16:
      {
        if (strcmp(instanceChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern const mxArray
            *sf_c16_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c16_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 17:
      {
        if (strcmp(instanceChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern const mxArray
            *sf_c17_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c17_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     case 18:
      {
        if (strcmp(instanceChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern const mxArray
            *sf_c18_zeabus_hydrophone_concrete_get_eml_resolved_functions_info
            (void);
          mxArray *persistentMxArray = (mxArray *)
            sf_c18_zeabus_hydrophone_concrete_get_eml_resolved_functions_info();
          plhs[0] = mxDuplicateArray(persistentMxArray);
          mxDestroyArray(persistentMxArray);
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_zeabus_hydrophone_concrete_third_party_uses_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the third_party_uses_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_third_party_uses_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 10:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c10_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c10_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 11:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c11_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c11_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 12:
      {
        if (strcmp(tpChksum, "s5NXWoVxdJOtFXLRuJHMT4F") == 0) {
          extern mxArray
            *sf_c12_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c12_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 13:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c13_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c13_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 14:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c14_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c14_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 15:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c15_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c15_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 16:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c16_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c16_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 17:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c17_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c17_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     case 18:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c18_zeabus_hydrophone_concrete_third_party_uses_info(void);
          plhs[0] = sf_c18_zeabus_hydrophone_concrete_third_party_uses_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_zeabus_hydrophone_concrete_jit_fallback_info( int nlhs, mxArray *
  plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the jit_fallback_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_jit_fallback_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 10:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray *sf_c10_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c10_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 11:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray *sf_c11_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c11_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 12:
      {
        if (strcmp(tpChksum, "s5NXWoVxdJOtFXLRuJHMT4F") == 0) {
          extern mxArray *sf_c12_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c12_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 13:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray *sf_c13_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c13_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 14:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray *sf_c14_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c14_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 15:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray *sf_c15_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c15_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 16:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray *sf_c16_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c16_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 17:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray *sf_c17_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c17_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     case 18:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray *sf_c18_zeabus_hydrophone_concrete_jit_fallback_info
            (void);
          plhs[0] = sf_c18_zeabus_hydrophone_concrete_jit_fallback_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_zeabus_hydrophone_concrete_get_post_codegen_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get_post_codegen_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_post_codegen_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 10:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          const char *sf_c10_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c10_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 11:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          const char *sf_c11_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c11_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 12:
      {
        if (strcmp(tpChksum, "s5NXWoVxdJOtFXLRuJHMT4F") == 0) {
          const char *sf_c12_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c12_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 13:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          const char *sf_c13_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c13_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 14:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          const char *sf_c14_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c14_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 15:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          const char *sf_c15_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c15_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 16:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          const char *sf_c16_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c16_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 17:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          const char *sf_c17_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c17_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     case 18:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          const char *sf_c18_zeabus_hydrophone_concrete_get_post_codegen_info
            (void);
          const char* encoded_post_codegen_info =
            sf_c18_zeabus_hydrophone_concrete_get_post_codegen_info();
          plhs[0] = sf_mex_decode(encoded_post_codegen_info);
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

unsigned int sf_zeabus_hydrophone_concrete_updateBuildInfo_args_info( int nlhs,
  mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the updateBuildInfo_args_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_updateBuildInfo_args_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 10:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c10_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c10_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 11:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c11_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c11_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 12:
      {
        if (strcmp(tpChksum, "s5NXWoVxdJOtFXLRuJHMT4F") == 0) {
          extern mxArray
            *sf_c12_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c12_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 13:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c13_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c13_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 14:
      {
        if (strcmp(tpChksum, "sfcoMQwMlai0BppVMY0GPPD") == 0) {
          extern mxArray
            *sf_c14_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c14_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 15:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c15_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c15_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 16:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c16_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c16_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 17:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c17_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c17_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     case 18:
      {
        if (strcmp(tpChksum, "s2lfbEDUyQjWCMMTPbwPIdD") == 0) {
          extern mxArray
            *sf_c18_zeabus_hydrophone_concrete_updateBuildInfo_args_info(void);
          plhs[0] = sf_c18_zeabus_hydrophone_concrete_updateBuildInfo_args_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

void zeabus_hydrophone_concrete_register_exported_symbols(SimStruct* S)
{
}

static mxArray* sRtwOptimizationInfoStruct= NULL;
typedef struct SfOptimizationInfoFlagsTag {
  boolean_T isRtwGen;
  boolean_T isModelRef;
  boolean_T isExternal;
} SfOptimizationInfoFlags;

static SfOptimizationInfoFlags sOptimizationInfoFlags;
void unload_zeabus_hydrophone_concrete_optimization_info(void);
mxArray* load_zeabus_hydrophone_concrete_optimization_info(boolean_T isRtwGen,
  boolean_T isModelRef, boolean_T isExternal)
{
  if (sOptimizationInfoFlags.isRtwGen != isRtwGen ||
      sOptimizationInfoFlags.isModelRef != isModelRef ||
      sOptimizationInfoFlags.isExternal != isExternal) {
    unload_zeabus_hydrophone_concrete_optimization_info();
  }

  sOptimizationInfoFlags.isRtwGen = isRtwGen;
  sOptimizationInfoFlags.isModelRef = isModelRef;
  sOptimizationInfoFlags.isExternal = isExternal;
  if (sRtwOptimizationInfoStruct==NULL) {
    sRtwOptimizationInfoStruct = sf_load_rtw_optimization_info(
      "zeabus_hydrophone_concrete", "zeabus_hydrophone_concrete");
    mexMakeArrayPersistent(sRtwOptimizationInfoStruct);
  }

  return(sRtwOptimizationInfoStruct);
}

void unload_zeabus_hydrophone_concrete_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct!=NULL) {
    mxDestroyArray(sRtwOptimizationInfoStruct);
    sRtwOptimizationInfoStruct = NULL;
  }
}
