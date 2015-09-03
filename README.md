BuggyMacro
==========

*Update: see the next section for the resolution.*

If a macro uses `String.to_existing_atom/1`, recompilations fail
even when clean compiles succeed. This repo has minimal proof of
this bug.

I discovered this while creating a magic module `Emqttd.Hooks` that
can just be `use`d by any module trying to add hooks to `emqttd`.
The module `BuggyMacro` is a simplified version of the same.

`AwesomeSauce` is just a helper dummy module to allow the compilation
to succeed. In a practical scenario, it will be a module defining
event hooks, like `emqttd_broker` from the `emqttd` project.

`AppleSauce` is the top level module that somehow loads/unloads the
event hooks defined by `BugProofOfConcept` whenever it sees fit.

This is a Developer error
-------------------------

Mix only compiles files that have changed. As a result, if the
`BuggyMacro` does not change but a module using it changes, the atoms
defined at compilation time in `BuggyMacro` will not be available
during subsequent compilations.

The fix should ensure that the atoms are available during compilation
of any module using `BuggyMacro`. The simplest way to do it is to inject
these into any module `use`ing `BuggyMacro` by adding it to `__using__/1`.
