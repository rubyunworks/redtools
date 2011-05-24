require 'redtools'

KO.case RedTools::Turn do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create a Turn tool" do
    RedTools.Turn()
  end

  test "run Turn tool" do
    #TODO: silently do
      turn = RedTools.Turn()
      turn.run
    #end
  end

end
