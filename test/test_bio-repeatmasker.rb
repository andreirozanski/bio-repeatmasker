#!/usr/bin/ruby

require  "bio-repeatmasker"

foo=RptMskr::Parser.open("chr1.fa.out_head100")
#IDs=RptMskr::Parser.search_by_id(["2","38"])
#fields=RptMskr::Parser.search_by_field("repeat_name",["AT_rich"])
#coord_interval=RptMskr::Parser.search_by_coordinate_interval("chr1","73845","76697")
puts RptMskr::Parser.search_by_field("repeat_name",["AT_rich"])
