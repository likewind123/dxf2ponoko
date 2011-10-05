begin
  require 'nokogiri'
rescue
  puts 'Please install nokogiri: http://nokogiri.org'
  exit 1
end

FILE_DIR     = File.dirname(__FILE__)
TEMPLATE_DIR = File.join(FILE_DIR, 'templates')
TEMPLATE_FILE_FMT = File.join(TEMPLATE_DIR, 'p%i_inkscape_English.svg')

class Libre2Ponoko
  Version = [0, 1]

  def initialize(opts)
    @opts = opts
  end

  def generate_svg(template_number, dxf_file)
    @template = get_template(template_number)
    
  end

  def get_template(template_number)
    @template_file = TEMPLATE_FILE_FMT % template_number.to_i
    File.open(@template_file).read
  end

  def get_svg_part(str)
    doc = Nokogiri::XML(str)
    doc.css('svg')[0].inner_html
  end
end
