# Universidad del Quindio - Programacion III
# Integrantes: Eric Santiago Correa Alzate,Juan Jose Marin y Nicolay Ramirez Ramirez

Code.require_file("datos.exs", __DIR__)
Code.require_file("Validaciones.exs", __DIR__)
Code.require_file("Calculos.exs", __DIR__)

defmodule Programa do
  @moduledoc "Coordina la entrada adicional, los reportes y el comprobante semanal."
  @meta_diaria 2_000
  @dias_recepcion 1..6
  @centro_vecino %{1 => 1850.5, 2 => 2100, 3 => 1640, 5 => 2350, 7 => 800}

  @doc "Muestra un menu basico y ejecuta la opcion elegida."
  def main do
    """
    Bienvenido al Centro de Acopio de Leche

    1) Mostrar lista de productores
    2) Mostrar lista de tanques
    3) Listar entregas registradas
    4) Validar entregas y generar los reportes
    5) Generar comprobante de un productor
    0) Salir

    Elige una opcion:
    """
    |> IO.gets()
    |> opcion_menu()
    |> ejecutar_opcion()
  end

  @doc "Convierte la opcion escrita en una accion del menu."
  def opcion_menu(nil), do: :salir
  def opcion_menu(opcion) do
    case String.trim(opcion) do
      "1" -> :productores
      "2" -> :tanques
      "3" -> :entregas
      "4" -> :reportes
      "5" -> :comprobante
      "0" -> :salir
      _ -> :opcion_invalida
    end
  end

  @doc "Ejecuta una opcion del menu sin repetir conceptos avanzados."
  def ejecutar_opcion(:productores), do: mostrar_productores()
  def ejecutar_opcion(:tanques), do: mostrar_tanques()
  def ejecutar_opcion(:entregas), do: mostrar_entregas()
  def ejecutar_opcion(:reportes), do: ejecutar_liquidacion()
  def ejecutar_opcion(:comprobante), do: pedir_comprobante()
  def ejecutar_opcion(:salir), do: IO.puts("Listo, hasta luego.")
  def ejecutar_opcion(:opcion_invalida), do: IO.puts("Opcion no valida. Ejecuta el programa e intenta de nuevo.")

  @doc "Muestra los productores registrados y si usan transporte."
  def mostrar_productores do
    IO.puts("\nProductores registrados:")
    Enum.each(Datos.productores(), fn p ->
      transporte = if p.transporte, do: "Si", else: "No"
      IO.puts("#{p.codigo} - #{p.nombre} - Transporte: #{transporte}")
    end)
  end

  @doc "Muestra los tanques y sus capacidades."
  def mostrar_tanques do
    IO.puts("\nTanques registrados:")
    Enum.each(Datos.tanques(), fn t -> IO.puts("#{t.id} - #{t.nombre} - #{t.capacidad} L") end)
  end

  @doc "Muestra las entregas guardadas, incluidas las que despues se rechazan."
  def mostrar_entregas do
    IO.puts("\nEntregas registradas:")
    Enum.each(Datos.entregas(), fn e ->
      IO.puts("Dia #{e.dia} - Productor #{e.productor} - Tanque #{e.tanque} - #{e.litros} L - Grasa #{e.grasa}%")
    end)
  end

  @doc "Valida los registros, pide una entrega opcional y genera todos los reportes.
  ademas de mostrar el tiempo de este proceso de validacion en microsegundos.
  "
  def ejecutar_liquidacion do
    IO.puts("\nRevisando las entregas y preparando los reportes...")
    {microsegundos, resultados} = :timer.tc(fn -> Validaciones.validar_entregas(Datos.entregas()) end)
    IO.puts("Tiempo de validacion: #{microsegundos} microsegundos")
    {entregas, resultados} = agregar_entrega_adicional(resultados)
    generar_reportes(entregas, resultados)
    pedir_comprobante(entregas)
  end

  @doc "Solicita un codigo de productor y muestra el comprobante semanal."
  def pedir_comprobante(entregas \\ nil) do
    codigo = IO.gets("\nCodigo del productor para el comprobante: ")
    if codigo != nil and String.trim(codigo) != "" do
      entregas_validas = if entregas == nil, do: Validaciones.entregas_validas(Validaciones.validar_entregas(Datos.entregas())), else: entregas
      generar_comprobante(String.trim(codigo), entregas_validas)
    end
  end

  @doc "Pide una entrega adicional y la incorpora si cumple formato y reglas de negocio."
  def agregar_entrega_adicional(resultados) do
    IO.puts("Ingrese una entrega adicional (productor;tanque;dia;litros;grasa) o Enter para omitir:")
    validas = Validaciones.entregas_validas(resultados)
    case parsear_entrega(IO.gets("")) do
      :omitir -> IO.puts("No se agrego una entrega adicional."); {validas, resultados}
      {:error, motivo} -> IO.puts("Entrada no agregada: #{motivo}"); {validas, resultados}
      {:ok, entrega} ->
        case Validaciones.validar_entrega(entrega) do
          {:ok, _} -> IO.puts("Entrega adicional valida y agregada."); {validas ++ [entrega], resultados ++ [{entrega, {:ok, entrega}}]}
          {:error, motivo} -> IO.puts("Entrega rechazada: #{motivo}"); {validas, resultados ++ [{entrega, {:error, motivo}}]}
        end
    end
  end
  @doc "Convierte una linea con cinco campos en una entrega o devuelve un error de formato."
  def parsear_entrega(nil), do: :omitir
  def parsear_entrega(linea) do
    linea = String.trim(linea)
    if linea == "" do
      :omitir
    else
      campos = String.split(linea, ";")
      case campos do
        [productor, tanque, dia, litros, grasa] ->
          with {dia_num, ""} <- Integer.parse(String.trim(dia)),
               {:ok, litros_num} <- convertir_numero(litros),
               {:ok, grasa_num} <- convertir_numero(grasa) do
            {:ok, %{productor: String.trim(productor), tanque: String.trim(tanque), dia: dia_num, litros: litros_num, grasa: grasa_num}}
          else
            _ -> {:error, :formato_invalido}
          end
        _ -> {:error, :formato_invalido}
      end
    end
  end

  @doc "Genera los ocho reportes en el orden solicitado por el enunciado."
  def generar_reportes(entregas, resultados) do
    reporte_r1(resultados)
    reporte_r2(entregas)
    reporte_r3(entregas)
    reporte_r4(entregas)
    reporte_r5(entregas)
    reporte_r6(entregas)
    reporte_r7(entregas)
    reporte_r8(entregas)
    reporte_combinacion(entregas)
  end

  @doc "Muestra las entregas rechazadas y el conteo por cada motivo."
  def reporte_r1(resultados) do
    rechazadas = Validaciones.entregas_rechazadas(resultados)
    encabezado("R1 - Entregas rechazadas")
    if rechazadas == [], do: IO.puts("No hubo rechazos."), else: Enum.each(rechazadas, fn {e, m} -> IO.puts("#{inspect(e)} -> #{m}") end)
    motivos = [:productor_desconocido, :tanque_desconocido, :dia_invalido, :litros_fuera_de_rango, :porcentaje_invalido]
    Enum.each(motivos, fn motivo -> IO.puts("#{motivo}: #{Enum.count(rechazadas, fn {_e, m} -> m == motivo end)}") end)
  end

  @doc "Calcula los litros y la ocupacion de cada tanque, de mayor a menor."
  def reporte_r2(entregas) do
    filas = Enum.map(Datos.tanques(), fn tanque ->
      litros = entregas |> Enum.filter(fn e -> e.tanque == tanque.id end) |> Enum.map(fn e -> e.litros end) |> Enum.sum()
      Map.merge(tanque, %{litros: litros, ocupacion: litros / tanque.capacidad * 100})
    end) |> Enum.sort_by(fn t -> t.ocupacion end, :desc)
    encabezado("R2 - Ocupacion de tanques")
    Enum.each(filas, fn t -> IO.puts("#{t.nombre}: #{t.litros} L (#{Float.round(t.ocupacion, 2)}%)") end)
  end

  @doc "Muestra el total diario y si se alcanzo la meta en cada uno de los seis dias."
  def reporte_r3(entregas) do
    mapa = litros_por_dia(entregas)
    encabezado("R3 - Recepcion diaria")
    Enum.each(@dias_recepcion, fn dia ->
      litros = Map.get(mapa, dia, 0)
      IO.puts("Dia #{dia}: #{litros} L - #{if litros >= @meta_diaria, do: "meta cumplida", else: "meta no cumplida"}")
    end)
    valores = Enum.map(@dias_recepcion, fn d -> Map.get(mapa, d, 0) end)
    IO.puts("Meta todos los dias: #{Enum.all?(valores, fn l -> l >= @meta_diaria end)}")
    IO.puts("Meta al menos un dia: #{Enum.any?(valores, fn l -> l >= @meta_diaria end)}")
  end

  @doc "Liquida todos los productores y los ordena por pago neto."
  def reporte_r4(entregas) do
    liquidaciones = liquidaciones(entregas) |> Calculos.ranking(por: :neto)
    encabezado("R4 - Liquidacion de productores")
    liquidaciones |> Enum.with_index(1) |> Enum.each(fn {r, i} ->
      IO.puts("#{i}. #{r.productor.nombre} (#{r.productor.codigo}) | #{r.litros} L | entregas $#{dinero(r.valor)} | bonos $#{r.bonificaciones} | transporte $#{r.transporte} | neto $#{dinero(r.neto)}")
    end)
  end

  @doc "Muestra todos los productores empatados en primer lugar de litros por dia."
  def reporte_r5(entregas) do
    ganadores = Enum.map(@dias_recepcion, fn dia ->
      totales = Enum.map(Datos.productores(), fn p -> %{productor: p, litros: Calculos.litros_productor_dia(p.codigo, dia, entregas)} end)
      maximo = Enum.map(totales, fn x -> x.litros end) |> Enum.max(fn -> 0 end)
      %{dia: dia, ganadores: Enum.filter(totales, fn x -> x.litros == maximo and maximo > 0 end)}
    end)
    encabezado("R5 - Mayor entrega diaria")
    Enum.each(ganadores, fn g -> IO.puts("Dia #{g.dia}: " <> (Enum.map(g.ganadores, fn x -> "#{x.productor.nombre} (#{x.litros} L)" end) |> Enum.join(", "))) end)
    conteo = Enum.flat_map(ganadores, fn g -> Enum.map(g.ganadores, fn x -> x.productor.codigo end) end) |> Enum.frequencies()
    max_dias = conteo |> Map.values() |> Enum.max(fn -> 0 end)
    lideres = Enum.filter(Datos.productores(), fn p -> Map.get(conteo, p.codigo, 0) == max_dias and max_dias > 0 end)
    IO.puts("Primer lugar mas dias: #{Enum.map(lideres, fn p -> p.nombre end) |> Enum.join(", ")} (#{max_dias} dias)")
  end

 @doc """
Calcula la calidad promedio ponderada de cada productor utilizando
la fórmula exigida por el enunciado:

suma(grasa * litros) / suma(litros)

Solo participan los productores con tres o más entregas válidas.
Al final muestra el productor con el mayor porcentaje de grasa
ponderado.
"""
def reporte_r6(entregas) do
  candidatos =
    Enum.map(Datos.productores(), fn p ->
      propias =
        Enum.filter(entregas, fn e ->
          e.productor == p.codigo
        end)
      litros =
        Enum.map(propias, fn e ->
          e.litros
        end)
        |> Enum.sum()
      ponderado =
        if litros == 0 do
          0
        else
          suma_ponderada =
            propias
            |> Enum.map(fn e -> e.grasa * e.litros end)
            |> Enum.sum()
          suma_ponderada / litros
        end
      %{
        productor: p,
        cantidad: length(propias),
        ponderado: ponderado
      }
    end)
    |> Enum.filter(fn p -> p.cantidad >= 3 end)
  encabezado("R6 - Mejor calidad (grasa ponderada)")
  case candidatos do
    [] ->
      IO.puts("No hay productores con al menos tres entregas validas.")
    _ ->
      mejor = Enum.max_by(candidatos, fn p -> p.ponderado end)
      IO.puts(
        "#{mejor.productor.nombre} (#{mejor.productor.codigo}): #{Float.round(mejor.ponderado, 3)}% con #{mejor.cantidad} entregas."
      )
  end
end

  @doc "Calcula el total neto pagado y el promedio por litro recibido."
  def reporte_r7(entregas) do
    total = liquidaciones(entregas) |> Enum.map(fn r -> r.neto end) |> Enum.sum()
    litros = Enum.map(entregas, fn e -> e.litros end) |> Enum.sum()
    promedio = if litros == 0, do: 0, else: total / litros
    encabezado("R7 - Total semanal")
    IO.puts("Total neto pagado: $#{dinero(total)} | Costo promedio por litro: $#{Float.round(promedio, 2)}")
  end

  @doc "Lista productores con al menos una entrega valida en cada tanque."
  def reporte_r8(entregas) do
    tanques = Enum.map(Datos.tanques(), fn t -> t.id end)
    productores = Enum.filter(Datos.productores(), fn p -> Enum.all?(tanques, fn t -> Enum.any?(entregas, fn e -> e.productor == p.codigo and e.tanque == t end) end) end)
    encabezado("R8 - Productores presentes en todos los tanques")
    if productores == [], do: IO.puts("Ninguno con los datos actuales."), else: Enum.each(productores, fn p -> IO.puts("#{p.nombre} (#{p.codigo})") end)
  end

  @doc "Demuestra la union de los litros del centro y el centro vecino con Map.merge/3."
  def reporte_combinacion(entregas) do
    mapa = Calculos.combinar_litros(litros_por_dia(entregas), @centro_vecino)
    encabezado("Combinacion con el centro vecino (Map.merge/3)")
    IO.inspect(mapa, label: "Litros combinados")
    IO.puts("Map.merge/2 habria reemplazado los valores de dias repetidos por los del segundo mapa. El dia 7 se conserva porque solo aparece en el mapa vecino.")
  end

  @doc "Solicita un codigo y muestra el comprobante del productor si existe."
  def comprobante_interactivo(entregas) do
    entrada = IO.gets("\nCódigo del productor para el comprobante (Enter para terminar): ")
    codigo = if entrada == nil, do: "", else: String.trim(entrada)
    if codigo != "", do: generar_comprobante(codigo, entregas)
  end

  @doc "Imprime el detalle semanal de un productor o informa si el codigo no existe."
  def generar_comprobante(codigo, entregas) do
    case Enum.find(Datos.productores(), fn p -> p.codigo == codigo end) do
      nil -> IO.puts("No existe el productor #{codigo}.")
      productor ->
        resumen = Calculos.resumen_productor(productor, entregas)
        encabezado("Comprobante - #{productor.nombre} (#{codigo})")
        Calculos.dias_con_entrega(codigo, entregas) |> Enum.each(fn dia ->
          litros = Calculos.litros_productor_dia(codigo, dia, entregas)
          valor = Calculos.valor_entregas_dia(codigo, dia, entregas)
          IO.puts("Dia #{dia}: #{litros} L | valor $#{dinero(valor)} | bonificacion $#{Calculos.bonificacion(litros)}")
        end)
        propias = Enum.count(entregas, fn e -> e.productor == codigo end)
        IO.puts("Total entregas: #{propias} | litros: #{resumen.litros} | valor entregas: $#{dinero(resumen.valor)}")
        IO.puts("Bonificaciones: $#{resumen.bonificaciones} | transporte: $#{resumen.transporte} | neto a pagar: $#{dinero(resumen.neto)}")
    end
  end

  # Convierte enteros o decimales sin excepciones; un texto restante significa error.
  defp convertir_numero(texto) do
    case Float.parse(String.trim(texto)) do
      {numero, ""} -> {:ok, numero}
      _ -> {:error, :formato_invalido}
    end
  end

  # Construye un mapa de totales diarios a partir de las entregas validas.
  defp litros_por_dia(entregas) do
    Enum.reduce(entregas, %{}, fn e, mapa -> Map.update(mapa, e.dia, e.litros, fn total -> total + e.litros end) end)
  end

  # Liquida tambien a productores sin entregas, cuyos valores quedan en cero.
  defp liquidaciones(entregas), do: Enum.map(Datos.productores(), fn p -> Calculos.resumen_productor(p, entregas) end)
  # Imprime el titulo de cada seccion del reporte.
  defp encabezado(titulo), do: IO.puts("\n" <> String.duplicate("=", 60) <> "\n" <> titulo <> "\n" <> String.duplicate("=", 60))
  # Redondea valores monetarios solo para mostrarlos, sin alterar el calculo interno.
  defp dinero(valor), do: valor |> Float.round(2) |> :erlang.float_to_binary(decimals: 2)
end

Programa.main()
