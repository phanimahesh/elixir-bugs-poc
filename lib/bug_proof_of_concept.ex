defmodule BugProofOfConcept do
  use BuggyMacro
  defhook on_something_abouttohappen(_some, _args, _specific, _to, _this, _event) do
  end
  defhook on_something_happened(_some, _other, _args, _specific, _to, _this, _event) do
  end
end
