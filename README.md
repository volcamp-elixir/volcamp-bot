# Volcamp

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `volcamp_bot` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:volcamp_bot, "~> 0.1.0"}
  ]
end
```

```shell
#connect via USB
sudo adb tcpip 5555
sudo adb connect $DEVICE_IP
scrcpy
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/volcamp_bot](https://hexdocs.pm/volcamp_bot).


## STEPS
1. pattern match sur /movie et repondre text
2. Introduction la lib Movie, retour title dans message text
3. Retourne image, dans media et title media
4. Ajouter le genre
5. Je veux voir film d'horreur, et on hot reload en local (mega bonus faire depuis machine distante) <!--  iex --sname node2 --remsh conn1 -->
6. Ajouter plusieurs avec Enum
7. Ajouter plusieurs avec Stream
8. Ajouter plusieurs avec Task.async_stream



# TODO:
- url complete dans movie "path_cover"
- get cover est juste un sleep
