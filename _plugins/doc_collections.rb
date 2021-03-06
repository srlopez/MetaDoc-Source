module Jekyll
  class DocCollections < Generator
    VERSION = '0.1.0'
    safe true
    priority :high

=begin
    Inspiration 

        https://github.com/fj/spicy-jekyll/blob/master/spicy_collections.rb

    Configuration collections in _config.yml sample:

        collections:
           doc_FolderA_FolderB_MetaDron-v1:
             title: Manual de Operaciones
             output: true 

    folder and filename format samples:

        _doc_FolderA_FolderB_MetaDron-v1
          0000-index.md (mandatory and always first, and in no other subfolder)
          9999-My_cool_chapter.md
          01_section1 (optionaly you can add subfolders)
            0010-Other_file.md (but all files are ordered by the seq number)

    Autogenerated data

        permalink    (you know)
        prev         (link to prev page)
        next         (link to next page)
        page-num     (page number in doc)
        sections     (subfolders = subheaders )
        doc-seq      (info: prefix number in file)
        doc-title    (collection title)
        docs-size    (number of pages in collection)
        title        (only for index = collection title)


    Jekyll.logger.info "Page: #{d.data['permalink']}"
=end

    def generate(site)
      site.collections.select{|name| name.start_with?('doc')}.each do |name, collection|
          collection.metadata['docs-size'] = collection.docs.size - 1 # Remove 0000000_index

          set_page_metadata name, collection
          assign_navigation_links collection
      end
      generate_menu(site)
    end

    def set_page_metadata(collection_name, collection)
      collection_path = collection_path_for(collection_name)
      Jekyll.logger.info "collection: /#{collection_path.join("/")}"
      #collection.docs.sort_by!(&:basename_without_ext).reverse.each_with_index do |d,idx|

      collection.docs.each do |d|
       
        _, doc_seq, doc_name = segments_for(d.basename_without_ext)
        raise ArgumentError, "Incorrect document name format" unless doc_name

        doc_sections = d.path.partition(collection_name).last.split("/").drop(1).slice(0..-2)
        doc_sections.each do |s|
          _, sec_seq, sec_name = segments_for(s)
          doc_seq.prepend(sec_seq)
          s.replace(sec_name) 
        end


        d.data['permalink'] = "/#{collection_path.join("/")}/#{doc_name}/"
        d.data['sections']  = doc_sections if doc_sections.size > 0
        d.data['doc-seq']   = doc_seq.ljust(12,"0")
        d.data['doc-title'] = collection.metadata['title']
        d.data['docs-size'] = collection.metadata['docs-size']
        d.data['doc-index'] = collection.metadata['doc-index']

        d.data['title']     = collection.metadata['title'] if doc_name == 'index'
       
        #Jekyll.logger.info "permalink: #{d.data['permalink']}"
        
      end
    end


    def doc_segments_for(document)
      segments_for(document.basename_without_ext)
    end

    def collection_path_for(collection_name)
      r = %r{^(doc)[-,_]+(.*)$}
      r.match(collection_name)[2].split("_")
    end

    def segments_for(s)
      r = %r{^(.*)[-,_]+(.*)$}
      r.match(s).to_a
    end

    def assign_navigation_links(collection)
      sorted_collection(collection).each_cons(2).each_with_index  do |(d1, d2),idx|
        #d1.data['next']     = navigation_hash_for_document d2
        d1.data['page-num'] = idx
        #d2.data['previous'] = navigation_hash_for_document d1
        d2.data['page-num'] = (idx + 1)
      end
    end

    def sorted_collection(collection)
      sort_field = collection.metadata.fetch 'sort-by', 'doc-seq' 
      collection_sorted_by_field(collection, sort_field)
    end

    def collection_sorted_by_field(collection, field)
      # Need the ! otherwise does not work
      # With ! do not need to assign next and previous links
      collection.docs.sort_by! { |d| d.data[field] }
    end

    def navigation_hash_for_document(d)
      {'title' => d.data['title'], 'url' => d.url}
    end

    def generate_menu(site)
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