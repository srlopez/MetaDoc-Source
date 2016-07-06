require 'pathname'

module Jekyll
  class MenuCollections < Generator
    VERSION = '0.1.0'
    safe true
    priority :low

    def generate(site)
      filename = '_data/' + Jekyll.configuration({})['menu']['docs']
      generate_collection_menu site, 
          Pathname(Jekyll.sanitized_path(site.source, filename))
    end

    def generate_collection_menu (site, filename) 
      meta = {}    
      site.collections.select{|name| name.start_with?('doc')}.each do |name,collection|
        sections = {} 
        meta[name] = []
        collection.docs.drop(1).each do |d|
          prev = meta[name]
          name_sec = ""
          d.data['sections'].each_with_index do |s,i|
            name_sec << s
            begin
              sections[name_sec] = [] 
              sec = {}
              sec['name']=s
              sec['submenu']=sections[name_sec]
              prev.push sec
            end if not sections[name_sec]
            prev = sections[name_sec]
          end if d.data['sections']
          doc = {}
          doc['name']=d.data['title']
          doc['url']=d.data['permalink']
          prev.push doc
        end 
      end

      Jekyll.logger.info "Generated: #{filename.basename}"
      File.open(filename, 'w'){|f| f.write meta.to_yaml }
    end

  end
end