defmodule BuggyMacro do
  @valid_events [
    :"something.abouttohappen",
    :"something.happened"
  ]
  defmacro __using__(_opts) do
    quote do
      Module.register_attribute __MODULE__, :super_awesome_hooks, [
        accumulate: true,
        persist: false
      ]
      import unquote(__MODULE__), only: [defhook: 2]
      @before_compile unquote(__MODULE__)
    end
  end
  defmacro defhook(definition = {name, _ctx, _args}, do: content) do
    event = name
            |> Atom.to_string
            |> String.replace("on_", "", global: false)
            |> String.replace("_", ".")
            |> String.to_existing_atom
    quote do
      @super_awesome_hooks {unquote(event),unquote(name)}
      def unquote(definition) do
        unquote(content)
      end
    end
  end
  defmacro __before_compile__(_env) do
    quote do
      def load(opts \\ []) do
        Enum.each @super_awesome_hooks, fn
          {event,func_name} ->
            AwesomeSauce.register_hook event, {__MODULE__, func_name}
        end
      end
      def unload(opts \\ []) do
        Enum.each @super_awesome_hooks, fn
          {event,func_name} ->
            AwesomeSauce.unregister_hook event, {__MODULE__, func_name}
        end
      end
    end
  end
end
