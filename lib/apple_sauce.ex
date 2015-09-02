defmodule AppleSauce do
  def init do
    BugProofOfConcept.load
  end

  def terminate do
    BugProofOfConcept.unload
  end
end
