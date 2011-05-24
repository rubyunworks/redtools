require 'redtools'

KO.case RedTools::RSpec do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create a RSpec tool" do
    RedTools.RSpec()
  end

  test "run the RSpec tool" do
    #TODO: silently do
      rspec = RedTools.RSpec()
      rspec.run
    #end
  end

end
