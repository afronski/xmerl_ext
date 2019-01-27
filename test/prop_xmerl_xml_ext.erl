-module(prop_xmerl_xml_ext).

-include_lib("proper/include/proper.hrl").

-include("../src/xmerl_ext.hrl").

prop_normalized_string_should_be_encoded_as_is_inside_CDATA_section() ->
  ?FORALL(Content, prop_generators:normalized_string(),
    begin
      Result = lists:flatten(xmerl:export_simple([{element, [{cdata, [Content]}]}], xmerl_xml_ext, ?XML_PROLOG)),
      string:rstr(Result, Content) =/= 0
    end).
