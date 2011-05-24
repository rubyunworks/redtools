require 'redtools'

KO.case RedTools::Yard do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create a Yard tool" do
    RedTools::Yard()
  end

  test "run a Yard tool" do
    #TODO: silently do
      yard = RedTools::Yard()
      dir  = yard.document
    #end
    File.exist?('.yardoc') &&
    File.exist?(File.join(dir, 'index.html'))
  end

end
