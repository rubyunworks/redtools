require 'redtools'

KO.case RedTools::RDoc do

  before(:all) do
    stage_copy('fixtures')
  end

  test "create an RDoc tool" do
    RedTools::RDoc()
  end

  test "run an RDoc tool" do
    #TODO: silently do
      rdoc = RedTools::RDoc()
      dir  = rdoc.document
    #end
    File.exist?(File.join(dir, 'index.html'))
  end

end
