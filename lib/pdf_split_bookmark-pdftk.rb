require 'crowd_support'

class Bookmark
  attr_accessor :level, :title, :page, :pdf
end

class PDF  
  attr_reader :filename, :bookmarks
    
  def initialize(filename)
    @filename = filename
    @bookmarks = []
  end
  
  def length
    if @length.nil?
      @length = pdftk_data.select { |d| d =~ /NumberOfPages: [0-9]+/}.first.gsub('NumberOfPages: ', '').to_i
    end
    @length
  end
  
  def split_by_bookmark_at_level(level, result_directory = Dir.pwd)
    splitmarks = bookmarks_at_level(level)
    startpages = splitmarks.collect { |bookmark| bookmark.page }
    endpage = length
    result_filenames = []
    splitmarks.reverse.each do |splitmark|
      startpage = splitmark.page
      result_filename = File.join(result_directory, splitmark.title.sanitize_filename)
      command = "pdftk A=\"#{filename}\" cat A#{startpage}-#{endpage} output \"#{result_filename}.pdf\" dont_ask"
      `#{command}`
      endpage = startpage - 1
      result_filenames << result_filename
    end
    result_filenames
  end
  
  def bookmarks_at_level(level)
    bookmarks.reject { |bookmark| bookmark.level != level }
  end
  
  def bookmarks
    if @bookmarks.empty?
      o = pdftk_data.reject { |i| i.scan(/^Bookmark/).empty? }
      o.each_slice(3) do |bmark|
        b = Bookmark.new
        b.title = bmark[0].gsub('BookmarkTitle: ', '')
        b.level = bmark[1].gsub('BookmarkLevel: ', '').to_i
        b.page = bmark[2].gsub('BookmarkPageNumber: ', '').to_i
        b.pdf = self
        @bookmarks << b
      end
      @bookmarks.sort { |f, b| f.page <=> b.page }
    end
    @bookmarks
  end
  
  def pdftk_data
    if @pdftk_data.nil?
      @pdftk_data = `pdftk "#{@filename}" dump_data`.split("\n")
    end
    @pdftk_data
  end
end
