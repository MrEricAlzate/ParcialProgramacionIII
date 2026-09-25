#Universidad del Quindío
#Programa de Ingeniería de Sistemas y Computación
#Programación III - Parcial 1
#Docente: Julián E. Gutiérrez Posada
#Integrantes:
#- Eric Santiago Correa Alzate
#- Juan José Marín


defmodule Programa do
  def main do
    """
    Bienvenido a el menu del Centro de acopio de leche

    1)Mostrar lista de productores
    2)Mostrar lista de tanques
    3)Listar entregas registradas

    """
    |> Util.ingresar(:texto)
    |> opcion_menu()
    |> ejecutar_opcion()
  end

  def opcion_menu(opcion) do
    case String.trim(opcion) do
      "1" -> :productores
      "2" -> :tanques
      "3" -> :entregas
      _ -> :opcion_invalida
    end
  end

  def ejecutar_opcion(:productores) do
    IO.puts("\n Lista de Proovedores")

    Enum.each(Datos.productores(), fn p ->
      transporte = if p.transporte, do: "Si", else: "No"
      IO.puts("[#{p.codigo}] #{p.nombre} - Transporte: #{transporte}")
    end)
  end

  def ejecutar_opcion(:tanques) do
    IO.puts("\n Lista de Tanques")

    Enum.each(Datos.tanques(), fn t ->
      IO.puts("[#{t.id}] #{t.nombre} - Capacidad: #{t.capacidad} Litros")
    end)
  end

  def ejecutar_opcion(:entregas) do
    IO.puts("\n Entregas Registradas")

    Enum.each(Datos.entregas(), fn e ->
      IO.puts(
        "Dia #{e.dia}, Productor #{e.productor}, Tanque #{e[:Tanque]}, #{e.litros} L, Grasa: #{e.grasa}"
      )
    end)
  end

  def ejecutar_opcion(:opcion_invalida) do
    IO.puts("opcion no valida")
  end
end

Programa.main()
