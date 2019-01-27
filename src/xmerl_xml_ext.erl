-module(xmerl_xml_ext).

-export([
  cdata/4,
  '#xml-inheritance#'/0
]).

-include_lib("xmerl/include/xmerl.hrl").

'#xml-inheritance#'() -> [xmerl_xml].

unescape_cdata(AmpAmpEsc) ->
  GtEsc  = re:replace(AmpAmpEsc, "&amp;", "\\&", [global]),

  LtEsc  = re:replace(GtEsc,  "&gt;",  ">",   [global]),
  AmpEsc = re:replace(LtEsc,  "&lt;",  "<",   [global]),
  Text   = re:replace(AmpEsc, "&amp;", "\\&", [global]),

  binary_to_list(iolist_to_binary(Text)).

cdata(Data, _, _, _) -> ["<![CDATA[", unescape_cdata(Data), "]]>"].
