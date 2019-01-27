
-module(xmerl_xml_ext_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-include("../src/xmerl_ext.hrl").

-export([ all/0 ]).
-export([ content_in_CDATA_section_should_be_serialized_properly/1,
          even_in_case_of_double_encoding_CDATA_section_should_contain_raw_characters/1 ]).

-define(SERIALIZE_WITH_CDATA(Data),
        lists:flatten(
          xmerl:export_simple([{element, [{cdata, [Data]}]}], xmerl_xml_ext, ?XML_PROLOG))).

-define(EXPECTED_XML(Data),
        lists:flatten(["<?xml version=\"1.0\" encoding=\"utf-8\"?><element><![CDATA[", Data, "]]></element>"])).

all() ->
  [ content_in_CDATA_section_should_be_serialized_properly,
    even_in_case_of_double_encoding_CDATA_section_should_contain_raw_characters ].

content_in_CDATA_section_should_be_serialized_properly(_Context) ->
  Result = ?SERIALIZE_WITH_CDATA("qwertyu!@#$%^&*()'\"+-[]{}|<>.,/?"),
  ?assertEqual(?EXPECTED_XML("qwertyu!@#$%^&*()'\"+-[]{}|<>.,/?"), Result).

even_in_case_of_double_encoding_CDATA_section_should_contain_raw_characters(_Context) ->
  Result = ?SERIALIZE_WITH_CDATA("qwertyu!@#$%^&amp;*()'\"+-[]{}|&lt;&gt;.,/?"),
  ?assertEqual(?EXPECTED_XML("qwertyu!@#$%^&*()'\"+-[]{}|<>.,/?"), Result).
