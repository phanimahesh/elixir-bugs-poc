defmodule AwesomeSauce do
  def register_hook(hook, {mod,func}) do
    # Do whatever and call func from mod whenever event happens
  end
  def unregister_hook(hook, {mod,func}) do
    # Do whatever and stop calling func from mod whenever event happens
  end
end
