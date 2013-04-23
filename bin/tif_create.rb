#!/usr/bin/env ruby  
# encoding: UTF-8

require "rexml/document" 

# 创建xml
def create_xml(name="TemplateInfo")  
  file = File.new("#{name}.xml","w+")    #新建XML文件， 将以下内容写入 。
  file.puts '<?xml version="1.0" encoding="UTF-8"?>'
  file.puts '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'

  doc = REXML::Document.new       #创建XML内容 

  el = doc.add_element 'plist', { "version"=>"1.0"}
  el = el.add_element 'dict', {}

  k1 = el.add_element 'key', {}
  k1.add_text "Description"

  k1_s = el.add_element 'string', {}
  k1_s.add_text "This is a template description."

  k2 = el.add_element 'key', {}
  k2.add_text "Identifier"
  k2_s = el.add_element 'string', {}
  current_dir_name = Dir.pwd.split('/').last
  p "#{current_dir_name}-----"
  
  id_name =current_dir_name[0,current_dir_name.index('.')] # 用当前文件名
  k2_s.add_text "com.beeframework.#{id_name}.lib"

  k3 = el.add_element 'key', {}
  k3.add_text "Kind"
  k3_s = el.add_element 'string', {}
  k3_s.add_text "Xcode.Xcode3.ProjectTemplateUnitKind"

  k4 = el.add_element 'key', {}
  k4.add_text "Definitions"

  # section 1
  dict = el.add_element 'dict', {}

  Dir["./**/*.h","./**/*.m","./**/*.mm"].each do |x|  
    r = x.split('/')
    r = r[2,r.length-3].join('/')
    # -x.splite('/').first - x.splite('/').last
  
    x = x[2,x.length]
    # p x
  
    k = dict.add_element 'key', {}
    k.add_text x
  
    d = dict.add_element 'dict', {}
  
    d_key = d.add_element 'key', {}
    d_key.add_text "Group"
  
    d_array = d.add_element 'array', {}

    _d_array_x1 = d_array.add_element 'string', {}
    _d_array_x1.add_text 'libs'
    _d_array_x2 = d_array.add_element 'string', {}
    _d_array_x2.add_text id_name
    _d_array_x3 = d_array.add_element 'string', {}
    _d_array_x3.add_text r
  
    d_key_2 = d.add_element 'key', {}
    d_key_2.add_text "Path"
  
    d_key_s2 = d.add_element 'string', {}
    d_key_s2.add_text x
  
    # .h文件多了TargetIndices
    if /\.h/ =~ x
      # p ".h=#{x}"
      d_key_3 = d.add_element 'key', {}
      d_key_3.add_text "TargetIndices"
      d_key_array = d.add_element 'array', {}
    end
  end

  nodes = el.add_element 'key', {}
  nodes.add_text "Nodes"
  nodes_array = el.add_element 'array', {}

  # section 2
  Dir["./**/*.h","./**/*.m","./**/*.mm"].each{
    |x|  
    x = x[2,x.length]
    # p x
    me = nodes_array.add_element 'string', {}
    me.add_text x
  }
  
  # 以4个tab进行格式化
  formatter = REXML::Formatters::Pretty.new(4)

  # Compact uses as little whitespace as possible
  formatter.compact = true
  formatter.write(doc, file)
  file.close
end

# 把xml转行成plist
# 把<string>|<key>分行的内容合并到1行处理，否则xcode里会不识别
def format_templateInfo_xml_to_plist(name='TemplateInfo')
  text = []
  s1,s2 = '',''
  string_start_flag = false
  out = File.new("#{name}.plist",'w') ;
  source = File.open("#{name}.xml",'r') ;
  
  t = source.readlines
  t.each do |line|
    if /(<string>|<key>)\n/ =~ line
      # 以<string>开头
      string_start_flag = true
      s1 = line.sub(/\n/,'')
    elsif /^\s*(<\/string>|<\/key>)\n$/ =~ line
      # 以</string>开头
      string_start_flag = false
    else
      # 正常的   
      if string_start_flag
        s2 = line
        line = line.sub(/\n/,'').gsub(/\s/,'');
        #p "#{s1}#{line}</string>\n"
        text.push "#{s1}#{line}</string>\n"
      else
        text.push  "#{line}"
      end
    end
    
  end

  out.puts  text.join
  out.close
end

# main
def main(name='TemplateInfo')
  p name
  create_xml(name)
  format_templateInfo_xml_to_plist(name)
end

# call main
if Dir.pwd.split('/').last.index('.')
  if ARGV[0].to_s.length >0 
    main(ARGV[0])
  else
    main()
  end
else
  p '目录名应该有“.”，否则不符合Xcode4 模板目录约定，请确认后再执行'
end