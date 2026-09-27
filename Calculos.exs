# Universidad del Quindío
# Programa de Ingeniería de Sistemas y Computación
# Programación III - Parcial 1
# Docente: Julián E. Gutiérrez Posada
# Integrantes:
# - Eric Santiago Correa Alzate
# - Juan José Marín

# ACA SE HACEN LOS CALCULOS DE VALOR, BONIFICACION Y TRANSPORTE

defmodule Calculos do
  @tarifa_base 1800
  @litros_bonificacion 450
  @monto_bonificacion 25_000
  @costo_transporte 18_000

  def valor_entrega(entrega) do
    base = entrega.litros * @tarifa_base # Valor de una entrega litros * tarifa base, ajustado segun el % de grasa

    cond do
      entrega.grasa >= 3.5 -> base * 1.06
      entrega.grasa >= 3.0 -> base
      entrega.grasa >= 2.5 -> base * 0.92
      true -> base * 0.80
    end
  end

  # Suma de litros de un productor, en un da, usando solo entregas válidas
  def litros_productor_dia(codigo, dia, entregas_validas) do
    entregas_validas
    |> Enum.filter(fn e -> e.productor == codigo and e.dia == dia end)
    |> Enum.map(fn e -> e.litros end)
    |> Enum.sum()
  end

  # Suma del valor de las entregas de un productor, en un día
  def valor_entregas_dia(codigo, dia, entregas_validas) do
    entregas_validas
    |> Enum.filter(fn e -> e.productor == codigo and e.dia == dia end)
    |> Enum.map(&valor_entrega/1)
    |> Enum.sum()
  end

  # Bonificación por volumen: depende solo del total de litros del día
  def bonificacion(litros_dia) do
    if litros_dia >= @litros_bonificacion do
      @monto_bonificacion
    else
      0
    end
  end

  # Días (sin repetir) en los que un productor tuvo al menos una entrega válida
  def dias_con_entrega(codigo, entregas_validas) do
    entregas_validas
    |> Enum.filter(fn e -> e.productor == codigo end)
    |> Enum.map(fn e -> e.dia end)
    |> Enum.uniq()
    |> Enum.sort()
  end

  # Descuento de transporte: solo si el productor usa el servicio,
  # se cobra por cada día en que tuvo entrega válida
  def descuento_transporte(productor, entregas_validas) do
    if productor.transporte do
      dias = dias_con_entrega(productor.codigo, entregas_validas)
      length(dias) * @costo_transporte
    else
      0
    end
  end
end
