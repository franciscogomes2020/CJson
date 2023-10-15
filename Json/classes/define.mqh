//+------------------------------------------------------------------+
//|                                                       define.mqh |
//|                         Copyright 2023, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"

enum ENUM_JSON_TYPE
  {
   JSON_TYPE_ARRAY = 1,
   JSON_TYPE_OBJECT,
   JSON_TYPE_KEY_VALUE,
   JSON_TYPE_INT,
   JSON_TYPE_STRING,
   JSON_TYPE_UNDEFINED,
  };
//+------------------------------------------------------------------+
//| this code is to create a instace of CJson from any place         |
//+------------------------------------------------------------------+
#ifndef CJSON_CLASS
//+------------------------------------------------------------------+
//| this code will generate a warning no #inport declaration in your |
//| metaeditor, but is not a error                                   |
//| it is because CJson file is not referencied yet                  |
//+------------------------------------------------------------------+
class CJsonBase;
CJsonBase *GetCJsonNewPointer(void);
#endif
//+------------------------------------------------------------------+
