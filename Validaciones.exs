# Universidad del Quindio - Programacion III
# Integrantes: Eric Santiago Correa Alzate y Juan Jose Marin

defmodule Validaciones do
  @moduledoc "Valida entregas siguiendo exactamente el orden indicado en el parcial."
  @primer_dia 1
  @ultimo_dia 6
  @max_litros 800
  @grasa_minima 0
  @grasa_maxima 15

  @doc "Valida una entrega y devuelve {:ok, entrega} o el primer motivo de rechazo."
  def validar_entrega(entrega) do
    with {:ok, _} <- validar_productor(entrega.productor),
         {:ok, _} <- validar_tanque(entrega.tanque),
         {:ok, _} <- validar_dia(entrega.dia),
         {:ok, _} <- validar_litros(entrega.litros),
         {:ok, _} <- validar_grasa(entrega.grasa) do
      {:ok, entrega}
    end
  end

  @doc "Valida todas las entregas y conserva junto a cada una su resultado."
  def validar_entregas(entregas), do: Enum.map(entregas, fn e -> {e, validar_entrega(e)} end)

  @doc "Extrae las entregas que pasaron todas las validaciones."
  def entregas_validas(resultados) do
    resultados |> Enum.filter(fn {_e, r} -> match?({:ok, _}, r) end) |> Enum.map(fn {_e, {:ok, e}} -> e end)
  end

  @doc "Extrae las entregas rechazadas junto con su motivo."
  def entregas_rechazadas(resultados) do
    resultados |> Enum.reject(fn {_e, r} -> match?({:ok, _}, r) end) |> Enum.map(fn {e, {:error, motivo}} -> {e, motivo} end)
  end

  # Las funciones privadas mantienen las reglas en el mismo orden del enunciado.
  defp validar_productor(codigo) do
    if Enum.any?(Datos.productores(), fn p -> p.codigo == codigo end), do: {:ok, codigo}, else: {:error, :productor_desconocido}
  end
  defp validar_tanque(id) do
    if Enum.any?(Datos.tanques(), fn t -> t.id == id end), do: {:ok, id}, else: {:error, :tanque_desconocido}
  end
  defp validar_dia(dia) do
    if is_integer(dia) and dia >= @primer_dia and dia <= @ultimo_dia, do: {:ok, dia}, else: {:error, :dia_invalido}
  end
  defp validar_litros(litros) do
    if is_number(litros) and litros > 0 and litros <= @max_litros, do: {:ok, litros}, else: {:error, :litros_fuera_de_rango}
  end
  defp validar_grasa(grasa) do
    if is_number(grasa) and grasa >= @grasa_minima and grasa <= @grasa_maxima, do: {:ok, grasa}, else: {:error, :porcentaje_invalido}
  end
end
