require "redtools/tool"

tools = Dir[File.dirname(__FILE__) + '/redtools/*.rb']
tools.each do |file|
  require file
end

