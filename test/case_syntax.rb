require 'redtools'

KO.case RedTools::Syntax do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create a Syntax tool" do
    RedTools::Syntax()
  end

  test "run a Syntax tool" do
    #TODO: silently do
      syntax = RedTools::Syntax()
      syntax.check
    #end
  end

end
