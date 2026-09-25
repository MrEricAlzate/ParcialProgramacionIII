#Universidad del Quindío
#Programa de Ingeniería de Sistemas y Computación
#Programación III - Parcial 1
#Docente: Julián E. Gutiérrez Posada
#Integrantes:
#- Eric Santiago Correa Alzate
#- Juan José Marín

# ACA SE VA A VALIDAR LAS LISTAS

defmodule Validaciones do
  def validar_entrega(entrega) do
    with {:ok, _} <- validar_productor(entrega.productor),
        {:ok, _} <- validar_tanque(entrega.tanque),
        {:ok, _} <- validar_dia(entrega.dia),
        {:ok, _} <- validar_litros(entrega.litros),
        {:ok, _} <- validar_grasa(entrega.grasa) do
      {:ok, entrega}
    end
  end

  defp validar_productor(codigo) do
    if Enum.any?(Datos.productores(), fn p -> p.codigo == codigo end) do
      {:ok, codigo}
    else
      {:error, :productor_desconocido}
    end
  end

  defp validar_tanque(id) do
    if Enum.any?(Datos.tanques(), fn t -> t.id == id end) do
      {:ok, id}
    else
      {:error, :tanque_desconocido}
    end
  end

  defp validar_dia(dia) do
    if is_integer(dia) and dia >= 1 and dia <= 6 do
      {:ok, dia}
    else
      {:error, :dia_invalido}
    end
  end

  defp validar_litros(litros) do
    if is_number(litros) and litros > 0 and litros <= 800 do
      {:ok, litros}
    else
      {:error, :litros_fuera_de_rango}
    end
  end

  defp validar_grasa(grasa) do
    if is_number(grasa) and grasa >= 0 and grasa <= 15 do
      {:ok, grasa}
    else
      {:error, :porcentaje_invalido}
    end
  end

  def validar_entregas(entregas) do
    entregas
    |> Enum.map(fn e -> {e, validar_entrega(e)} end)
  end

  def entregas_validas(resultados) do
    resultados
    |> Enum.filter(fn {_e, r} -> match?({:ok, _}, r) end)
    |> Enum.map(fn {_e, {:ok, entrega}} -> entrega end)
  end

  def entregas_rechazadas(resultados) do
    resultados
    |> Enum.reject(fn {_e, r} -> match?({:ok, _}, r) end)
    |> Enum.map(fn {e, {:error, motivo}} -> {e, motivo} end)
  end
end
