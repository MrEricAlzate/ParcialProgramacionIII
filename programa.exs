# Universidad del Quindío
# Programa de Ingeniería de Sistemas y Computación
# Programación III - Parcial 1
# Docente: Julián E. Gutiérrez Posada
# Integrantes:
# - Eric Santiago Correa Alzate
# - Juan José Marín

Code.require_file("datos.exs", __DIR__)
Code.require_file("validaciones.exs", __DIR__)

defmodule Programa do
  def main do
    """
    Bienvenido a el menu del Centro de acopio de leche

    1)Mostrar lista de productores
    2)Mostrar lista de tanques
    3)Listar entregas registradas
    4)Validar entregas

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
      "4" -> :validar
      _ -> :opcion_invalida
    end
  end

  def ejecutar_opcion(:productores) do
    Datos.productores()
    |> generar_lista_productores()
    |> Util.mostrar_mensaje()
  end

  def ejecutar_opcion(:tanques) do
    Datos.tanques()
    |> generar_lista_tanques()
    |> Util.mostrar_mensaje()
  end

  def ejecutar_opcion(:entregas) do
    Datos.entregas()
    |> generar_lista_entregas()
    |> Util.mostrar_mensaje()
  end

  def ejecutar_opcion(:validar) do
    Datos.entregas()
    |> Validaciones.validar_entregas()
    |> generar_reporte_validacion()
    |> Util.mostrar_mensaje()
end

  defp generar_lista_productores(productores) do
    contenido =
      productores
      |> Enum.map(fn p ->
          transporte = if p.transporte, do: "Si", else: "No"
          "[#{p.codigo}] #{p.nombre} - Transporte: #{transporte}"
        end)
        |> Enum.join("\n")


    "\n Lista de proovedores: \n" <> contenido
  end

  defp generar_lista_tanques(tanques) do
    contenido =
      tanques
      |> Enum.map(
        fn t ->
          "[#{t.id}] #{t.nombre} - Capacidad #{t.capacidad} Litros"
        end)
        |> Enum.join("\n")


    "\n Lista de tanques: \n" <> contenido
  end

  defp generar_lista_entregas(entregas) do
    contenido =
      entregas
      |> Enum.map(
        fn e ->
          "Dia #{e.dia}, Productor #{e.productor}, Tanque #{e.tanque}, #{e.litros} L, Grasa: #{e.grasa}"
        end)

        |> Enum.join("\n")

    "\n Lista de entregas: \n" <> contenido
  end

  defp generar_reporte_validacion(resultados) do
    validas = Validaciones.entregas_validas(resultados)
    rechazadas = Validaciones.entregas_rechazadas(resultados)

    texto_validas =
      validas
      |> Enum.map(fn e -> "OK -> #{e.productor}, Tanque #{e.tanque}, Día #{e.dia}, #{e.litros} L, Grasa #{e.grasa}%" end)
      |> Enum.join("\n")

    texto_rechazadas =
      rechazadas
      |> Enum.map(fn {e, motivo} -> "RECHAZADA (#{motivo}) -> #{inspect(e)}" end)
      |> Enum.join("\n")

    "\n Entregas válidas (#{length(validas)}):\n" <> texto_validas <>
    "\n\n Entregas rechazadas (#{length(rechazadas)}):\n" <> texto_rechazadas
end

  # def ejecutar_opcion(:productores) do
  #   IO.puts("\n Lista de Proovedores")

  #   Enum.each(Datos.productores(), fn p ->
  #     transporte = if p.transporte, do: "Si", else: "No"
  #     IO.puts("[#{p.codigo}] #{p.nombre} - Transporte: #{transporte}")
  #   end)
  # end

  # def ejecutar_opcion(:tanques) do
  #   IO.puts("\n Lista de Tanques")

  #   Enum.each(Datos.tanques(), fn t ->
  #     IO.puts("[#{t.id}] #{t.nombre} - Capacidad: #{t.capacidad} Litros")
  #   end)
  # end

  # def ejecutar_opcion(:entregas) do
  #   IO.puts("\n Entregas Registradas")

  #   Enum.each(Datos.entregas(), fn e ->
  #     IO.puts("Dia #{e.dia}, Productor #{e.productor}, Tanque #{e[:Tanque]}, #{e.litros} L, Grasa: #{e.grasa}"
  #     )
  #   end)
  # end

  def ejecutar_opcion(:opcion_invalida) do
    IO.puts("opcion no valida")
  end
end

Programa.main()
