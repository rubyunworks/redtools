require 'redtools'

KO.case RedTools::RDoc do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create an RI tool" do
    RedTools::RI()
  end

  test "run an RI tool" do
    #TODO: silently do
      ri  = RedTools::RI()
      dir = ri.document
    #end
    File.exist?(dir)
  end

end
