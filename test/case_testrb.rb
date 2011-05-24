require 'redtools'

KO.case RedTools::Testrb do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create a Testrb tool" do
    RedTools.Testrb()
  end

  test "run a testrb tool" do
    #TODO: silently do
      @testrb = RedTools.Testrb()
      @testrb.run
    #end
  end

end
