require File.dirname(__FILE__) + '/spec_helper'

describe PDF do
  it 'reads pdfs' do
    p = PDF.new(File.dirname(__FILE__) + '/bb dep.pdf')
    p.length.should == 33
  end
  
  it 'splits pdfs' do
    p = PDF.new(File.dirname(__FILE__) + '/bb dep.pdf')
    p.split_by_bookmark_at_level 2, 'tmp'
    pwd = Dir.pwd
    Dir.mkdir('tmp') if !Dir.exist?('tmp')
    Dir.chdir('tmp')
    Dir.glob('*.pdf').should include('1_1._160_DEPARTURES.pdf', '1_2._160_EXEMPTION_REQUESTS.pdf')
    Dir.chdir(pwd)
  end
end
