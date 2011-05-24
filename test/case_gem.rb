require 'redtools'

KO.case RedTools::Gem do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create a Gem tool" do
    RedTools.Gem()
  end

  test "build a gemspec" do
    #TODO: silently do
      gem = RedTools.Gem()
      gem.spec
    #end
  end

  test "build a gemspec and gem" do
    #TODO: silently do
      gem = RedTools.Gem(:autospec=>true)
      gem.build
    #end
  end

end
