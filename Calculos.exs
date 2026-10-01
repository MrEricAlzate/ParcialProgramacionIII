# Universidad del Quindio - Programacion III
# Integrantes: Eric Santiago Correa Alzate, Juan Jose Marin y Nicolay Ramirez Ramirez

defmodule Calculos do
  @moduledoc "Funciones sencillas para liquidar entregas y resumir datos del centro."
  @tarifa_base 1800
  @litros_bonificacion 450
  @monto_bonificacion 25_000
  @costo_transporte 18_000

  @doc "Calcula el valor de una entrega aplicando el ajuste segun la grasa."
  def valor_entrega(entrega) do
    base = entrega.litros * @tarifa_base
    cond do
      entrega.grasa >= 3.5 -> base * 1.06
      entrega.grasa >= 3.0 -> base
      entrega.grasa >= 2.5 -> base * 0.92
      true -> base * 0.80
    end
  end

  @doc "Suma los litros de un productor en un dia usando entregas validas."
  def litros_productor_dia(codigo, dia, entregas) do
    entregas |> Enum.filter(fn e -> e.productor == codigo and e.dia == dia end) |> Enum.map(fn e -> e.litros end) |> Enum.sum()
  end

  @doc "Suma el valor de las entregas de un productor en un dia."
  def valor_entregas_dia(codigo, dia, entregas) do
    entregas |> Enum.filter(fn e -> e.productor == codigo and e.dia == dia end) |> Enum.map(&valor_entrega/1) |> Enum.sum()
  end

  @doc "Devuelve la bonificacion de volumen para un total de litros diario."
  def bonificacion(litros) do
    if litros >= @litros_bonificacion, do: @monto_bonificacion, else: 0
  end

  @doc "Lista en orden los dias en los que el productor tuvo una entrega valida."
  def dias_con_entrega(codigo, entregas) do
    entregas |> Enum.filter(fn e -> e.productor == codigo end) |> Enum.map(fn e -> e.dia end) |> Enum.uniq() |> Enum.sort()
  end

  @doc "Calcula el descuento de transporte por dia con entrega valida."
  def descuento_transporte(productor, entregas) do
    if productor.transporte, do: length(dias_con_entrega(productor.codigo, entregas)) * @costo_transporte, else: 0
  end

  @doc "Devuelve el total de litros y el valor pagado por productor."
  def resumen_productor(productor, entregas) do
    propias = Enum.filter(entregas, fn e -> e.productor == productor.codigo end)
    litros = Enum.map(propias, fn e -> e.litros end) |> Enum.sum()
    valor = Enum.map(propias, &valor_entrega/1) |> Enum.sum()
    dias = dias_con_entrega(productor.codigo, entregas)
    bonos = Enum.map(dias, fn dia -> bonificacion(litros_productor_dia(productor.codigo, dia, entregas)) end) |> Enum.sum()
    transporte = descuento_transporte(productor, entregas)
    %{productor: productor, litros: litros, valor: valor, bonificaciones: bonos, transporte: transporte, neto: valor + bonos - transporte}
  end

  @doc "Ordena una lista de mapas por la clave indicada de mayor a menor."
  def ranking(elementos, opciones) do
    campo = Keyword.fetch!(opciones, :por)
    Enum.sort_by(elementos, fn elemento -> Map.fetch!(elemento, campo) end, :desc)
  end

  @doc "Combina dos mapas de litros sumando las claves repetidas."
  def combinar_litros(mapa_centro, centro_vecino) do
    Map.merge(mapa_centro, centro_vecino, fn _dia, litros_a, litros_b -> litros_a + litros_b end)
  end
end
