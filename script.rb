#!/usr/bin/env ruby

PROJECT_DIR  = ARGV[0] || '.'
PALETTE_FILE = ARGV[1] || 'palette'

EXTENSIONS = %w[.tscn .tres .gd]

def load_palette(file)
  palette = {}

  File.readlines(file).each_with_index do |line, index|
    line = line.strip
    next if line.empty? || line.start_with?('#')

    if line =~ /^(\(.*?\))\s*->\s*(\(.*?\))$/
      from = Regexp.last_match(1)
      to   = Regexp.last_match(2)
      palette[from] = to
    else
      warn "Invalid palette line #{index + 1}: #{line}"
    end
  end

  palette
end

palette = load_palette(PALETTE_FILE)

abort 'Palette is empty or invalid' if palette.empty?

Dir.glob("#{PROJECT_DIR}/**/*").each do |file|
  next unless EXTENSIONS.include?(File.extname(file))
  next unless File.file?(file)

  content  = File.read(file)
  original = content.dup

  palette.each do |from, to|
    content = content.gsub(from, to)
  end

  if content != original
    File.write(file, content)
    puts "Updated: #{file}"
  end
end
