//+------------------------------------------------------------------+
//|                                                         test.mqh |
//|                         Copyright 2024, Francisco Gomes da Silva |
//|                    https://www.mql5.com/en/users/franciscogomes5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Francisco Gomes da Silva"
#property link      "https://www.mql5.com/en/users/franciscogomes5"
/*+------------------------------------------------------------------+
//| these tests auto run if you use this include into your program   |
//|+-----------------------------------------------------------------+
#include <CJson\Json\Test\test.mqh>



//+-----------------------------------------------------------------*/
//| init of tests                                                    |
//+------------------------------------------------------------------+
#include "..\Json.mqh"
#include "testAsserts.mqh"
//+------------------------------------------------------------------+
//| func main to tests                                               |
//+------------------------------------------------------------------+
int TestCJson(void)
  {
   CJson json;
   string text;
// json is not defined yet
   ASSERT_EQUALS(json.Type(), JSON_TYPE_UNDEFINED);
   ASSERT_EQUALS(json.Stringfy(), "");

// int
   ASSERT_EQUALS((json="1"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_INT);
   ASSERT_EQUALS(json.Stringfy(), "1");
   ASSERT_EQUALS(json.Value(), "1");
   ASSERT_EQUALS(json.ValueToInt(), 1);

// long
   ASSERT_EQUALS(json="3167042642",true)
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_INT)
   ASSERT_EQUALS(json.Value(),"3167042642")

   ASSERT_EQUALS(json=3167042642,true)
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_INT)
   ASSERT_EQUALS(json.Value(),"3167042642")

   ASSERT_EQUALS(json="-3167042642",true)
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_INT)
   ASSERT_EQUALS(json.Value(),"-3167042642")

// double
   ASSERT_EQUALS((json="1.123"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_DOUBLE);
   ASSERT_EQUALS(json.Stringfy(), "1.123");
   ASSERT_EQUALS(json.Value(), "1.123");
   ASSERT_EQUALS(json.ValueToInt(), 1);
   ASSERT_EQUALS(json.ValueToDouble(), 1.123);

   ASSERT_EQUALS((json="-1.123"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_DOUBLE);
   ASSERT_EQUALS(json.Stringfy(), "-1.123");
   ASSERT_EQUALS(json.Value(), "-1.123");
   ASSERT_EQUALS(json.ValueToInt(), -1);
   ASSERT_EQUALS(json.ValueToDouble(), -1.123);

// string
   ASSERT_EQUALS((json="name"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"name\"");
   ASSERT_EQUALS(json.Value(), "name");

// double as string
   ASSERT_EQUALS((json="\"1.123\""), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS((json="'1.123'"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json.Stringfy(), "\"1.123\"");
   ASSERT_EQUALS(json.Value(), "1.123");

// array
   ASSERT_EQUALS((json="[]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[]");
   ASSERT_EQUALS(json.Total(), 0);

// object
   ASSERT_EQUALS((json="{}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{}");
   ASSERT_EQUALS(json.Total(), 0);

   ASSERT_EQUALS((json="{Name1:\"Willian\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyName(0),"Name1")
   ASSERT_EQUALS(json.At(0).Value(),"Willian")
   ASSERT_EQUALS(json.Key(0).Value(),"Willian")
   ASSERT_EQUALS(json.Stringfy(), "{\"Name1\":\"Willian\"}");
   ASSERT_EQUALS(json.Total(), 1);

   ASSERT_EQUALS((json="{Name1:\"Wil\\\"lian\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyName(0),"Name1")
   ASSERT_EQUALS(json.At(0).Value(),"Wil\\\"lian")
   ASSERT_EQUALS(json.Key(0).Value(),"Wil\\\"lian")
   ASSERT_EQUALS(json.Stringfy(), "{\"Name1\":\"Wil\\\"lian\"}");
   ASSERT_EQUALS(json.Total(), 1);

   ASSERT_EQUALS((json="{Name1:\"Willian\",\"Name2\":\"Rose\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyName(0),"Name1")
   ASSERT_EQUALS(json.KeyName(1),"Name2")
   ASSERT_EQUALS(json.At(0).Value(),"Willian")
   ASSERT_EQUALS(json.Key(0).Value(),"Willian")
   ASSERT_EQUALS(json.At(1).Value(),"Rose")
   ASSERT_EQUALS(json.Key(1).Value(),"Rose")
   ASSERT_EQUALS(json.Stringfy(), "{\"Name1\":\"Willian\",\"Name2\":\"Rose\"}");
   ASSERT_EQUALS(json.Total(), 2);

   ASSERT_EQUALS((json="{}"), true);
   ASSERT_EQUALS(json["undefined key"].Type(),JSON_TYPE_UNDEFINED)
   ASSERT_EQUALS(json["undefined key"].Value(),"")

   ASSERT_EQUALS((json="{\"buy\":{\"open\":{\"rule\":\"C=O\"}},\"sell\":{\"open\":{\"rule\":\"C!=O\"}}}"),true);
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyExist("buy"),true);
   ASSERT_EQUALS(json["buy"].KeyExist("open"),true);
   ASSERT_EQUALS(json["buy"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].Value(),"C=O");

   ASSERT_EQUALS(json["sell"].KeyExist("open"),true);
   ASSERT_EQUALS(json["sell"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].Value(),"C!=O");

   ASSERT_EQUALS((json="{\"buy\":{\"open\":{\"rule\":\"C=O\"}},\"sell\":{\"open\":{\"rule\":\"C!=O\"}}} "),true);
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.KeyExist("buy"),true);
   ASSERT_EQUALS(json["buy"].KeyExist("open"),true);
   ASSERT_EQUALS(json["buy"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["buy"]["open"]["rule"].Value(),"C=O");

   ASSERT_EQUALS(json["sell"].KeyExist("open"),true);
   ASSERT_EQUALS(json["sell"]["open"].KeyExist("rule"),true);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].JsonType(),JSON_TYPE_STRING);
   ASSERT_EQUALS(json["sell"]["open"]["rule"].Value(),"C!=O");

// any json can be a object
// example convert json to string
   ASSERT_EQUALS(json = "oneString",true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_STRING);
// example convert json to object
   ASSERT_EQUALS(json["one key"] = "one value",true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(),"{\"one key\":\"one value\"}");

// array with 1 object
   ASSERT_EQUALS((json="[{}]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[{}]");
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Stringfy(), "{}");
   ASSERT_EQUALS(json[0].Total(), 0);

   text =
      ""
      + "[\r\n"
      + "    {\r\n"
      + "      \"index\": 0,\r\n"
      + "      \"message\": {\r\n"
      + "        \"role\": \"assistant\",\r\n"
      + "        \"content\": \"The image features a scenic landscape with a wooden pathway leading through a lush green area. The path is surrounded by tall grasses and various types of vegetation. In the background, there are trees and a blue sky with some clouds, indicating a clear day. The overall scene conveys a sense of tranquility and natural beauty.\",\r\n"
      + "        \"refusal\": null\r\n"
      + "      },\r\n"
      + "      \"logprobs\": null,\r\n"
      + "      \"finish_reason\": \"stop\"\r\n"
      + "    }\r\n"
      + "  ]\r\n"
      + "";
   ASSERT_EQUALS((json=text), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json[0].JsonType(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0]["index"].JsonType(), JSON_TYPE_INT);
   ASSERT_EQUALS(json[0]["message"].JsonType(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0]["logprobs"].JsonType(), JSON_TYPE_NULL);
   ASSERT_EQUALS(json[0]["finish_reason"].JsonType(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json[0].Total(), 4);
   ASSERT_EQUALS(json[0]["message"]["role"].JsonType(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json[0]["message"]["content"].JsonType(), JSON_TYPE_STRING);
   ASSERT_EQUALS(json[0]["message"]["refusal"].JsonType(), JSON_TYPE_NULL);
   ASSERT_EQUALS(json[0]["message"]["content"].Value(), "The image features a scenic landscape with a wooden pathway leading through a lush green area. The path is surrounded by tall grasses and various types of vegetation. In the background, there are trees and a blue sky with some clouds, indicating a clear day. The overall scene conveys a sense of tranquility and natural beauty.");

   text =
      ""
      +"{\r\n"
      +"  \"choices\": [\r\n"
      +"    {\r\n"
      +"    }\r\n"
      +"  ]\r\n"
      +"}\r\n";
   ASSERT_EQUALS((json=text), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json["choices"].JsonType(),ARRAY);
   ASSERT_EQUALS(json["choices"][0].JsonType(),OBJECT);

   text =
      ""
      +"{\r\n"
      +"  \"choices\": [\r\n"
      +"    {\r\n"
      +"    }\r\n"
      +"  ],\r\n"
      +"}\r\n";
   ASSERT_EQUALS((json=text), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json["choices"].JsonType(),ARRAY);
   ASSERT_EQUALS(json["choices"][0].JsonType(),OBJECT);

   text =
      ""
      +"{\r\n"
      +"  \"id\": \"chatcmpl-Au0fgUlQJUeYsNRdovn5inP60GPIC\",\r\n"
      +"  \"object\": \"chat.completion\",\r\n"
      +"  \"created\": 1737912312,\r\n"
      +"  \"model\": \"gpt-4o-mini-2024-07-18\",\r\n"
      +"  \"choices\": [\r\n"
      +"    {\r\n"
      +"      \"index\": 0,\r\n"
      +"      \"message\": {\r\n"
      +"        \"role\": \"assistant\",\r\n"
      +"        \"content\": \"Ação: Comprar; Preço De Entrada: 1.4900; Stop: 1.4800; Take: 1.5100; Motivo: A recente recuperação do preço acima da média móvel, juntamente com o RSI em tendência de alta, sugere um impulso positivo.\",\r\n"
      +"        \"refusal\": null\r\n"
      +"      },\r\n"
      +"      \"logprobs\": null,\r\n"
      +"      \"finish_reason\": \"stop\"\r\n"
      +"    }\r\n"
      +"  ],\r\n"
      +"  \"usage\": {\r\n"
      +"    \"prompt_tokens\": 391,\r\n"
      +"    \"completion_tokens\": 61,\r\n"
      +"    \"total_tokens\": 452,\r\n"
      +"    \"prompt_tokens_details\": {\r\n"
      +"      \"cached_tokens\": 0,\r\n"
      +"      \"audio_tokens\": 0\r\n"
      +"    },\r\n"
      +"    \"completion_tokens_details\": {\r\n"
      +"      \"reasoning_tokens\": 0,\r\n"
      +"      \"audio_tokens\": 0,\r\n"
      +"      \"accepted_prediction_tokens\": 0,\r\n"
      +"      \"rejected_prediction_tokens\": 0\r\n"
      +"    }\r\n"
      +"  },\r\n"
      +"  \"service_tier\": \"default\",\r\n"
      +"  \"system_fingerprint\": \"fp_bd83329f63\"\r\n"
      +"}\r\n";
   ASSERT_EQUALS((json=text), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json["choices"].JsonType(),ARRAY);
   ASSERT_EQUALS(json["choices"][0].JsonType(),OBJECT);
   ASSERT_EQUALS(json["choices"][0]["message"].JsonType(),OBJECT);
   ASSERT_EQUALS(json["choices"][0]["message"]["content"].JsonType(),STRING);
   ASSERT_EQUALS(json["choices"][0]["message"]["content"].Value(), "Ação: Comprar; Preço De Entrada: 1.4900; Stop: 1.4800; Take: 1.5100; Motivo: A recente recuperação do preço acima da média móvel, juntamente com o RSI em tendência de alta, sugere um impulso positivo.");

// array with 2 object
   ASSERT_EQUALS((json="[{},{}]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[{},{}]");
   ASSERT_EQUALS(json.Total(), 2);
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Stringfy(), "{}");
   ASSERT_EQUALS(json[0].Total(), 0);
   ASSERT_EQUALS(json[1].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[1].Stringfy(), "{}");
   ASSERT_EQUALS(json[1].Total(), 0);

// array with 2 object with spaces
   ASSERT_EQUALS((json="[ { }  , { } ]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Stringfy(), "[{},{}]");
   ASSERT_EQUALS(json.Total(), 2);
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Stringfy(), "{}");
   ASSERT_EQUALS(json[0].Total(), 0);
   ASSERT_EQUALS(json[1].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[1].Stringfy(), "{}");
   ASSERT_EQUALS(json[1].Total(), 0);

// object with 1 key
   ASSERT_EQUALS((json="{name:\"default\"}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"name\":\"default\"}");
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json.KeyExist("name"),true);
   ASSERT_EQUALS(json["name"].Value(),"default");
   ASSERT_EQUALS(json["name"].Type(),JSON_TYPE_STRING);

// object with 1 key without aspos and single aspos on string
   ASSERT_EQUALS((json="{name:'default'}"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"name\":\"default\"}");
   ASSERT_EQUALS(json.Total(), 1);

// object with 2 key
   ASSERT_EQUALS((json="{v1:'defaultV1',v2:'defaultV2'}"), true);
   ASSERT_EQUALS(json.Stringfy(), "{\"v1\":\"defaultV1\",\"v2\":\"defaultV2\"}");
   ASSERT_EQUALS(json.Total(), 2);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json.Stringfy(), "{\"v1\":\"defaultV1\",\"v2\":\"defaultV2\"}");

// array with sequence of objects
   ASSERT_EQUALS((json="[{value1:'value1IsAString',entry:{description:'textDescription'}}]"), true);
   ASSERT_EQUALS(json.Type(), JSON_TYPE_ARRAY);
   ASSERT_EQUALS(json.Total(), 1);
   ASSERT_EQUALS(json.Stringfy(), "[{\"value1\":\"value1IsAString\",\"entry\":{\"description\":\"textDescription\"}}]");
   ASSERT_EQUALS(json[0].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0].Total(), 2);
   ASSERT_EQUALS(json[0].KeyExist("value1"), true);
   ASSERT_EQUALS(json[0]["value1"].Value(), "value1IsAString");
   ASSERT_EQUALS(json[0].KeyExist("value2"), false);
   ASSERT_EQUALS(json[0].KeyExist("entry"), true);
   ASSERT_EQUALS(json[0]["entry"].Type(), JSON_TYPE_OBJECT);
   ASSERT_EQUALS(json[0]["entry"].Total(), 1);
   ASSERT_EQUALS(json[0]["entry"].KeyExist("description"), true);
   ASSERT_EQUALS(json[0]["entry"]["description"].Value(), "textDescription");

   ASSERT_EQUALS(json = "{sell:{open:'1.67'}}",true);
   ASSERT_EQUALS(json==JSON_TYPE_OBJECT,true);
   ASSERT_EQUALS(json.Stringfy(),"{\"sell\":{\"open\":1.67}}");
   ASSERT_EQUALS(json["open"].JsonType(),JSON_TYPE_UNDEFINED);
   ASSERT_EQUALS(json["sell"]==JSON_TYPE_OBJECT,true);
   ASSERT_EQUALS(json["sell"].Stringfy(),"{\"open\":1.67}");
   ASSERT_EQUALS(json["sell"]["open"]==JSON_TYPE_DOUBLE,true);
   ASSERT_EQUALS(json["sell"]["open"].Stringfy(),"1.67");

// operators
   ASSERT_EQUALS(json = new CJson,true);
   ASSERT_EQUALS(json == JSON_TYPE_UNDEFINED,true);
   ASSERT_EQUALS(json != JSON_TYPE_STRING,true);

// insert value directly to object string
   ASSERT_EQUALS(json = "foo",true);
   ASSERT_EQUALS(json == JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json.Value(),"foo");
   ASSERT_EQUALS(json.Value("{}"),true);
   ASSERT_EQUALS(json == JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json.Value(),"{}");

//scape and decode to normalize strings inside json
   text = "\" \'";
   CJsonBase::EscapeXml(text);
   ASSERT_EQUALS(text,"&quot; &apos;")
   CJsonBase::DecodeXml(text);
   ASSERT_EQUALS(text,"\" \'")

// it was not a array but now it is
   ASSERT_EQUALS(json[1]="now I am a array",true);
   ASSERT_EQUALS(json==JSON_TYPE_ARRAY,true);
   ASSERT_EQUALS(json[1]==JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json[0]==JSON_TYPE_UNDEFINED,true);
   ASSERT_EQUALS(json[0]=1,true);
   ASSERT_EQUALS(json[0]==JSON_TYPE_INT,true);
   ASSERT_EQUALS(json[1]==JSON_TYPE_STRING,true);
   ASSERT_EQUALS(json.Total(),2);
   ASSERT_EQUALS(json[2]==JSON_TYPE_UNDEFINED,true);
   ASSERT_EQUALS(json.Total(),3);

// you can acess an index and a key directly
   ASSERT_EQUALS(json="any value",true);
   ASSERT_EQUALS(json[1]["key1"]="value1",true);
   ASSERT_EQUALS(json[1]["key2"]="value2",true);
   ASSERT_EQUALS(json[2]["key1"]="value3",true);
   ASSERT_EQUALS(json[2]["key2"]="value4",true);
   ASSERT_EQUALS(json.Total(),3);
   ASSERT_EQUALS(json[1].Total(),2);
   ASSERT_EQUALS(json[2].Total(),2);
   ASSERT_EQUALS(json.Stringfy(),"[null,{\"key1\":\"value1\",\"key2\":\"value2\"},{\"key1\":\"value3\",\"key2\":\"value4\"}]");

// string space ' '
   ASSERT_EQUALS(json=" ",true)
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_STRING)
   ASSERT_EQUALS(json.Value()," ")

// string breakline \n
   ASSERT_EQUALS(json="\n",true)
   ASSERT_EQUALS(json.JsonType(),JSON_TYPE_STRING)
   ASSERT_EQUALS(json.Value(),"\n")

   ASSERT_EQUALS(json="{\"positions\":[{\"magic\":239898,\"ticket\":1376269651}]}",true)
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376269651")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\"}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),1)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":239898}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),2)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":239898,\"ticket\":1376269651}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),3)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376269651")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":239898,\"ticket\":1376269651,\"type\":\"POSITION_TYPE_BUY\"}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),4)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376269651")
   ASSERT_EQUALS(json["positions"][0]["type"].Value(),"POSITION_TYPE_BUY")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":239898,\"ticket\":1376269651,\"type\":\"POSITION_TYPE_BUY\",\"lot\":1}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),5)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376269651")
   ASSERT_EQUALS(json["positions"][0]["type"].Value(),"POSITION_TYPE_BUY")
   ASSERT_EQUALS(json["positions"][0]["lot"].Value(),"1")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":239898,\"ticket\":1376269651,\"type\":\"POSITION_TYPE_BUY\",\"lot\":1,\"price\":\"103642\"}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),6)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].JsonType(),JSON_TYPE_INT)
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376269651")
   ASSERT_EQUALS(json["positions"][0]["type"].Value(),"POSITION_TYPE_BUY")
   ASSERT_EQUALS(json["positions"][0]["lot"].Value(),"1")
   ASSERT_EQUALS(json["positions"][0]["price"].Value(),"103642")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":239898,\"ticket\":1376269651,\"type\":\"POSITION_TYPE_BUY\",\"lot\":1,\"price\":\"1.03642\"}]}",true)
   ASSERT_EQUALS(json["positions"][0].Total(),6)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].JsonType(),JSON_TYPE_INT)
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"239898")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376269651")
   ASSERT_EQUALS(json["positions"][0]["type"].Value(),"POSITION_TYPE_BUY")
   ASSERT_EQUALS(json["positions"][0]["lot"].Value(),"1")
   ASSERT_EQUALS(json["positions"][0]["price"].Value(),"1.03642")
   ASSERT_EQUALS(json["positions"][0]["price"].JsonType(),JSON_TYPE_DOUBLE)

   ASSERT_EQUALS(json="{\"comment\":\"\"}",true)
   ASSERT_EQUALS(json["comment"].JsonType(),JSON_TYPE_STRING)
   ASSERT_EQUALS(json["comment"].Value(),"")
   ASSERT_EQUALS(json["comment"].Stringfy(),"\"\"")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":0,\"ticket\":1376821300,\"type\":\"POSITION_TYPE_BUY\",\"lot\":0.01,\"price\":1.03656,\"comment\":\"\"}]}",true)
   ASSERT_EQUALS(json["positions"].JsonType(),JSON_TYPE_ARRAY)
   ASSERT_EQUALS(json["positions"].Total(),1)
   ASSERT_EQUALS(json["positions"][0].JsonType(),JSON_TYPE_OBJECT)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"0")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376821300")
   ASSERT_EQUALS(json["positions"][0]["type"].Value(),"POSITION_TYPE_BUY")
   ASSERT_EQUALS(json["positions"][0]["lot"].Value(),"0.01")
   ASSERT_EQUALS(json["positions"][0]["price"].Value(),"1.03656")
   ASSERT_EQUALS(json["positions"][0]["comment"].Value(),"")

   ASSERT_EQUALS(json="{\"positions\":[{\"symbol\":\"EURUSD\",\"magic\":0,\"ticket\":1376821300,\"type\":\"POSITION_TYPE_BUY\",\"lot\":0.01,\"price\":1.03656,\"comment\":\"\"},{\"symbol\":\"EURUSD\",\"magic\":0,\"ticket\":1376821306,\"type\":\"POSITION_TYPE_BUY\",\"lot\":0.01,\"price\":1.03656,\"comment\":\"\"}]}",true)
   ASSERT_EQUALS(json["positions"].JsonType(),JSON_TYPE_ARRAY)
   ASSERT_EQUALS(json["positions"].Total(),2)
   ASSERT_EQUALS(json["positions"][0].JsonType(),JSON_TYPE_OBJECT)
   ASSERT_EQUALS(json["positions"][0]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][0]["magic"].Value(),"0")
   ASSERT_EQUALS(json["positions"][0]["ticket"].Value(),"1376821300")
   ASSERT_EQUALS(json["positions"][0]["type"].Value(),"POSITION_TYPE_BUY")
   ASSERT_EQUALS(json["positions"][0]["lot"].Value(),"0.01")
   ASSERT_EQUALS(json["positions"][0]["price"].Value(),"1.03656")
   ASSERT_EQUALS(json["positions"][0]["comment"].Value(),"")
   ASSERT_EQUALS(json["positions"][1]["symbol"].Value(),"EURUSD")
   ASSERT_EQUALS(json["positions"][1]["magic"].Value(),"0")
   ASSERT_EQUALS(json["positions"][1]["ticket"].Value(),"1376821306")
   ASSERT_EQUALS(json["positions"][1]["type"].Value(),"POSITION_TYPE_BUY")
   ASSERT_EQUALS(json["positions"][1]["lot"].Value(),"0.01")
   ASSERT_EQUALS(json["positions"][1]["price"].Value(),"1.03656")
   ASSERT_EQUALS(json["positions"][1]["comment"].Value(),"")

   return 1;
  }
#ifdef _DEBUG
int autoRunTestCJson = TestCJson();
#endif
//+------------------------------------------------------------------+
