# Centro de acopio de leche - Parcial 1

Solucion en Elixir organizada en cuatro archivos, siguiendo el estilo sencillo del repositorio original:

- `datos.exs`: productores, tanques y registros de prueba.
- `Validaciones.exs`: validacion en el orden indicado en el enunciado.
- `Calculos.exs`: pagos, bonificaciones, transporte y ranking.
- `programa.exs`: entrada adicional, reportes R1 a R8 y comprobante.
- `pensamiento_computacional.docx`: analisis del problema, ordenado y aclarado.

## Menu

Al iniciar, el programa muestra una opcion por ejecucion: listar productores, listar tanques, listar entregas, validar y generar los reportes, o generar un comprobante. Escribe `0` para salir. Para elegir otra opcion, vuelve a ejecutar `elixir programa.exs`.

## Como ejecutar

Con Elixir instalado, abre una terminal en esta carpeta y ejecuta:

```powershell
elixir programa.exs
```

El programa pregunta por una entrega adicional con este formato: `productor;tanque;dia;litros;grasa`. Pulsa Enter para omitirla. Al final puedes escribir un codigo, por ejemplo `P01`, para ver el comprobante.

Los datos incluyen 91 entregas, de las cuales 81 son validas, y mantienen ejemplos de rechazo para cada motivo. Las tarifas y limites se declaran como atributos de modulo. No se usan Mix, librerias externas, structs, archivos de datos, recursividad, procesos ni try/rescue.

## Antes de entregar

Ejecuten el programa en el equipo del grupo y guarden la salida completa para incluirla en el documento final que pide el parcial. Completen las mediciones que les solicite el curso y la bitacora/reflexion de la Parte D con hechos del grupo. En la sustentacion, aseguren que todos puedan explicar las funciones.

Registren de forma transparente el apoyo de IA: se utilizo para ordenar el analisis y preparar una implementacion inicial. Revisen, entiendan y ajusten el resultado antes de presentarlo.
