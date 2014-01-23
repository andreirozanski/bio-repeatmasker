# Copyright::   Copyright (C) 2009
#               Andrei Rozanski <rozanski.andrei@gmail.com>
# License::     The Ruby License
# == Description
# This file containts parser for RepeatMasker.

#Define module RptMskr
module RptMskr

	
  class Parser

  def initialize;end

  #input file - raw RepeatMasker output file - http://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/chromOut.tar.gz

  def self.open(filename)
    $rpt_data=Hash.new{ |hash, key| hash[key] = [] }
    File.open(filename).each do |line|
      s_l=line.gsub(/^\s+/, "").gsub(/\s+/,"\t").split("\t") 
      if s_l[0] =~ /[0-9]+/ and s_l[8] !~ /C/
        hash1 = {"repeat_name"=>"#{s_l[9]}","class_name"=>"#{s_l[10]}","chromosome"=>"#{s_l[4]}","start_coordinate"=>"#{s_l[5]}","end_coordinate"=>"#{s_l[6]}","strand" =>"#{s_l[8]}","n_beyond_match"=>"#{s_l[7].gsub(/\(|\)/,"")}","start_match"=>"#{s_l[11]}","end_match"=>"#{s_l[12]}","n_prior_match"=>"#{s_l[13].gsub(/\(|\)/,"")}","sw_score"=>"#{s_l[0]}","subs_percent"=>"#{s_l[1]}","del_percent"=>"#{s_l[2]}","ins_percent"=>"#{s_l[3]}"}
        $rpt_data[:"#{s_l[14]}"] << hash1
      end
      if s_l[0] =~ /[0-9]+/ and s_l[8] =~ /C/
        hash2 = {"repeat_name"=>"#{s_l[9]}","class_name"=>"#{s_l[10]}","chromosome"=>"#{s_l[4]}","start_coordinate"=>"#{s_l[5]}","end_coordinate"=>"#{s_l[6]}","strand" =>"#{s_l[8]}","n_beyond_match"=>"#{s_l[7].gsub(/\(|\)/,"")}","start_match"=>"#{s_l[13]}","end_match"=>"#{s_l[12]}","n_prior_match"=>"#{s_l[11].gsub(/\(|\)/,"")}","sw_score"=>"#{s_l[0]}","subs_percent"=>"#{s_l[1]}","del_percent"=>"#{s_l[2]}","ins_percent"=>"#{s_l[3]}"}
        $rpt_data[:"#{s_l[14]}"] << hash2
      end
    end
    #return hash of hashes - key for main hash = id
    return $rpt_data  
  end

  #search for events based on its ids - input is an array of ids
  def self.search_by_id(ids)
    ids.each do |id|
    $rpt_data.each do |key,value|
      puts "#{key},#{value}" if key.to_s == id.to_s
      end
    end  
  end  

  #search for events based on given fields and values - input one field and array of values (i.e, chromosome, ["chr1","chr2","chr3","chr4"]) - returns all events matching this pattern
  #fiels, based on RepeatMasker output documentation (http://www.repeatmasker.org/) are : id, repeat_name, class_name, chromosome, start_coordinate, end_coordinate, strand, n_beyond_match, start_match, end_match, n_prior_match, sw_score, subs_percent, del_percent, ins_percent

  def self.search_by_field(field,array_of_values)
  result=[]
    array_of_values.each do |search_vals|
  $rpt_data.each do |key,value|
    value.each do |ab|
	if ab["#{field}"] == search_vals.to_s
		res="#{key},#{value}"
		result.push(res)
      end
    end
  end
  return result.uniq
    end
  end

  #search for events that are located into a coordinate interval - chromosome 1, from 10000 to 20000 - chr1,10000,20000)
  def self.search_by_coordinate_interval(chr,start_c,end_c)
  result=[]
  $rpt_data.each do |key,value|
          value.each do |ab|
      if ab["chromosome"] == chr.to_s and ab["start_coordinate"] >= start_c.to_s and ab["end_coordinate"] <= end_c.to_s and ab["start_coordinate"] < end_c.to_s and ab["end_coordinate"] > start_c.to_s
        res="#{key},#{value}"
        result.push(res)
      end
    end
  end
  return result.uniq
  end
end  #Parser
end  #RptMskr

#2Cor3:18
