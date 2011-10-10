begin
  require 'nokogiri'
rescue
  puts 'Please install nokogiri: http://nokogiri.org'
  exit 1
end

FILE_DIR     = File.dirname(__FILE__)
DXF2SVG_EXEC = File.join(FILE_DIR, '..', 'dxf2svg', 'dxf2svg')
TEMPLATE_DIR = File.join(FILE_DIR, '..', 'templates')
TEMPLATE_FILE_FMT = File.join(TEMPLATE_DIR, '%s/p%i_inkscape_english.svg')

class DXF2Ponoko
  Version = [0, 1]

  def initialize(opts)
    @opts = opts
    puts "in DXF2Ponoko.new"
    svg = generate_svg(opts[:type], opts[:template], opts[:dxf])
    if File.exist?(opts[:out])
      puts "Error: #{opts[:out]} exists. Please move or delete it and run dxf2ponoko again."
      exit 1
    else
      File.open(opts[:out], 'w'){|f| f.write svg }
    end
    puts "leaving DXF2Ponoko.new"
  end

  def generate_svg(type, template_number, dxf_file)
    template = get_template(type, template_number)
    svg_part = get_svg_part(dxf_file)
    template.sub('<!-- DXF2SVG -->', svg_part)
  end

  def get_template(type, template_number)
    template_file = TEMPLATE_FILE_FMT % [type, template_number.to_i]
    File.open(template_file).read
  end

  def dxf2svg(dxf_file)
    str = %x[#{DXF2SVG_EXEC} #{dxf_file}]
    p DXF2SVG_EXEC
    p dxf_file
    p str
    str
  end

  def get_svg_part(dxf_file)
    str = dxf2svg(dxf_file)
    doc = Nokogiri::XML(str)
    doc.css('svg')[0].inner_html
  end
end
