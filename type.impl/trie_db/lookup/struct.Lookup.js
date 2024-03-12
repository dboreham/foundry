(function() {var type_impls = {
"anvil_core":[["<details class=\"toggle implementors-toggle\" open><summary><section id=\"impl-Lookup%3C'a,+L,+Q%3E\" class=\"impl\"><a href=\"#impl-Lookup%3C'a,+L,+Q%3E\" class=\"anchor\">§</a><h3 class=\"code-header\">impl&lt;'a, L, Q&gt; Lookup&lt;'a, L, Q&gt;<div class=\"where\">where\n    L: TrieLayout,\n    Q: Query&lt;&lt;L as TrieLayout&gt;::Hash&gt;,</div></h3></section></summary><div class=\"impl-items\"><details class=\"toggle method-toggle\" open><summary><section id=\"method.look_up\" class=\"method\"><h4 class=\"code-header\">pub fn <a class=\"fn\">look_up</a>(\n    self,\n    key: NibbleSlice&lt;'_&gt;\n) -&gt; <a class=\"enum\" href=\"https://doc.rust-lang.org/nightly/core/result/enum.Result.html\" title=\"enum core::result::Result\">Result</a>&lt;<a class=\"enum\" href=\"https://doc.rust-lang.org/nightly/core/option/enum.Option.html\" title=\"enum core::option::Option\">Option</a>&lt;&lt;Q as Query&lt;&lt;L as TrieLayout&gt;::Hash&gt;&gt;::Item&gt;, <a class=\"struct\" href=\"https://doc.rust-lang.org/nightly/alloc/boxed/struct.Box.html\" title=\"struct alloc::boxed::Box\">Box</a>&lt;TrieError&lt;&lt;&lt;L as TrieLayout&gt;::Hash as Hasher&gt;::Out, &lt;&lt;L as TrieLayout&gt;::Codec as NodeCodec&gt;::Error&gt;&gt;&gt;</h4></section></summary><div class=\"docblock\"><p>Look up the given key. If the value is found, it will be passed to the given\nfunction to decode or copy.</p>\n</div></details></div></details>",0,"anvil_core::eth::trie::RefLookup","anvil_core::eth::trie::RefLookupNoExt"]]
};if (window.register_type_impls) {window.register_type_impls(type_impls);} else {window.pending_type_impls = type_impls;}})()