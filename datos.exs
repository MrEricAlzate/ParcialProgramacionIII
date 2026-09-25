#Universidad del Quindío
#Programa de Ingeniería de Sistemas y Computación
#Programación III - Parcial 1
#Docente: Julián E. Gutiérrez Posada
#Integrantes:
#- Eric Santiago Correa Alzate
#- Juan José Marín

defmodule Datos do
  def productores do
    [
      %{codigo: "P01", nombre: "Marta Gómez", transporte: true},
      %{codigo: "P02", nombre: "Eric Alzate", transporte: false},
      %{codigo: "P03", nombre: "Eileen Adriana", transporte: true},
      %{codigo: "P04", nombre: "Sandra Alzate", transporte: true},
      %{codigo: "P05", nombre: "Pedro Sanchez", transporte: true},
      %{codigo: "P06", nombre: "Mike Clinton", transporte: false},
      %{codigo: "P07", nombre: "LeBron James", transporte: false},
      %{codigo: "P08", nombre: "James Rodriguez", transporte: true},
      %{codigo: "P09", nombre: "David Arteaga", transporte: false},
      %{codigo: "P10", nombre: "Liam Martinez", transporte: false},
      %{codigo: "P11", nombre: "Julio Jaramillo", transporte: false}
    ]
  end

  def tanques do
    [
      %{id: "T1", nombre: "Tanque Norte", capacidad: 4000},
      %{id: "T2", nombre: "Tanque Central", capacidad: 5000},
      %{id: "T3", nombre: "Tanque Sur", capacidad: 6000},
      %{id: "T4", nombre: "Tanque Este", capacidad: 900}
    ]
  end

  # Para fines practicos los errores se colocaron en la parte de arriba el resto que no esta comentado son entregas validas

  def entregas do
    [

      %{productor: "P04", Tanque: "T2", dia: 8, litros: 500, grasa: 3.5},# Error en el dia
      %{productor: "P03", Tanque: "T1", dia: 6, litros: 790, grasa: 1.3},

      %{productor: "P01", Tanque: "T1", dia: 3, litros: 950, grasa: 4.2},# Error en los litros
      %{productor: "P09", Tanque: "T1", dia: 5, litros: 350, grasa: 10.7},

      %{productor: "P07", Tanque: "T3", dia: 5, litros: 300, grasa: 18.5},# Error en la grasa
      %{productor: "P01", Tanque: "T2", dia: 6, litros: 640, grasa: 5.1},

      %{productor: "P03", Tanque: "T2", dia: 0, litros: 450, grasa: 3.0},# Error en el dia
      %{productor: "P02", Tanque: "T3", dia: 3, litros: 430, grasa: 12.1},

      %{productor: "P12", Tanque: "T3", dia: 5, litros: 250, grasa: 4.0}, # Error en el productor
      %{productor: "P11", Tanque: "T3", dia: 5, litros: 340, grasa: 10.6},

      %{productor: "P99", Tanque: "T1", dia: 2, litros: 400, grasa: 3.5},# Error en el productor
      %{productor: "P02", Tanque: "T4", dia: 3, litros: 680, grasa: 9.5},
      %{productor: "P06", Tanque: "T2", dia: 3, litros: 550, grasa: 3.1},

      %{productor: "P04", Tanque: "T1", dia: 2, litros: 0, grasa: 3.8}, # Error en los litros
      %{productor: "P04", Tanque: "T2", dia: 4, litros: 580, grasa: 4.0},

      %{productor: "P06", Tanque: "T2", dia: 3, litros: 500, grasa: -0.5},# Error en la grasa
      %{productor: "P01", Tanque: "T2", dia: 1, litros: 500, grasa: 6.0},
      %{productor: "P02", Tanque: "T2", dia: 5, litros: 500, grasa: 3.2},
      %{productor: "P08", Tanque: "T4", dia: 6, litros: 680, grasa: 2.1},
      %{productor: "P03", Tanque: "T2", dia: 6, litros: 780, grasa: 3.9},

      %{productor: "P02", Tanque: "T5", dia: 1, litros: 300, grasa: 3.2},# Error en el tanque

      %{productor: "P08", Tanque: "T8", dia: 4, litros: 550, grasa: 2.1}, # Error en el tanque
      %{productor: "P03", Tanque: "T2", dia: 6, litros: 640, grasa: 8.9},
      %{productor: "P07", Tanque: "T4", dia: 5, litros: 690, grasa: 7.9},
      %{productor: "P09", Tanque: "T1", dia: 6, litros: 240, grasa: 10.2},
      %{productor: "P09", Tanque: "T3", dia: 6, litros: 530, grasa: 1.7},
      %{productor: "P07", Tanque: "T2", dia: 4, litros: 100, grasa: 14.3},
      %{productor: "P05", Tanque: "T2", dia: 5, litros: 230, grasa: 13.1},
      %{productor: "P05", Tanque: "T2", dia: 2, litros: 570, grasa: 11.4},
      %{productor: "P09", Tanque: "T1", dia: 5, litros: 510, grasa: 7.3},
      %{productor: "P02", Tanque: "T3", dia: 3, litros: 400, grasa: 0.9},
      %{productor: "P10", Tanque: "T1", dia: 1, litros: 720, grasa: 12.2},
      %{productor: "P09", Tanque: "T2", dia: 2, litros: 700, grasa: 14.2},
      %{productor: "P03", Tanque: "T3", dia: 5, litros: 640, grasa: 14.5},
      %{productor: "P09", Tanque: "T2", dia: 6, litros: 490, grasa: 6.0},
      %{productor: "P11", Tanque: "T3", dia: 4, litros: 760, grasa: 6.8},
      %{productor: "P04", Tanque: "T2", dia: 1, litros: 530, grasa: 0.3},
      %{productor: "P09", Tanque: "T2", dia: 5, litros: 380, grasa: 0.1},
      %{productor: "P11", Tanque: "T1", dia: 2, litros: 180, grasa: 13.6},
      %{productor: "P06", Tanque: "T1", dia: 5, litros: 400, grasa: 4.2},
      %{productor: "P08", Tanque: "T2", dia: 5, litros: 260, grasa: 10.9},
      %{productor: "P10", Tanque: "T4", dia: 2, litros: 700, grasa: 12.1},
      %{productor: "P04", Tanque: "T1", dia: 1, litros: 650, grasa: 5.3},
      %{productor: "P07", Tanque: "T4", dia: 6, litros: 160, grasa: 10.1},
      %{productor: "P11", Tanque: "T1", dia: 1, litros: 610, grasa: 10.9},
      %{productor: "P02", Tanque: "T2", dia: 2, litros: 340, grasa: 8.0},
      %{productor: "P03", Tanque: "T4", dia: 2, litros: 450, grasa: 6.9},
      %{productor: "P02", Tanque: "T4", dia: 5, litros: 220, grasa: 0.8},
      %{productor: "P09", Tanque: "T1", dia: 1, litros: 400, grasa: 2.5},
      %{productor: "P08", Tanque: "T4", dia: 2, litros: 610, grasa: 13.5},
      %{productor: "P03", Tanque: "T4", dia: 1, litros: 590, grasa: 4.0},
      %{productor: "P08", Tanque: "T3", dia: 4, litros: 720, grasa: 2.3},
      %{productor: "P05", Tanque: "T2", dia: 1, litros: 790, grasa: 0.9},
      %{productor: "P06", Tanque: "T1", dia: 1, litros: 710, grasa: 7.5},
      %{productor: "P09", Tanque: "T2", dia: 1, litros: 750, grasa: 1.2},
      %{productor: "P03", Tanque: "T1", dia: 5, litros: 180, grasa: 10.1},
      %{productor: "P04", Tanque: "T4", dia: 1, litros: 410, grasa: 8.7},
      %{productor: "P01", Tanque: "T1", dia: 4, litros: 760, grasa: 4.7},
      %{productor: "P05", Tanque: "T2", dia: 6, litros: 500, grasa: 3.6},
      %{productor: "P07", Tanque: "T2", dia: 6, litros: 480, grasa: 6.9},
      %{productor: "P02", Tanque: "T1", dia: 4, litros: 220, grasa: 1.1},
      %{productor: "P04", Tanque: "T3", dia: 2, litros: 540, grasa: 13.2},
      %{productor: "P04", Tanque: "T3", dia: 3, litros: 300, grasa: 6.6},
      %{productor: "P09", Tanque: "T3", dia: 5, litros: 770, grasa: 0.1},
      %{productor: "P09", Tanque: "T3", dia: 6, litros: 230, grasa: 14.1},
      %{productor: "P03", Tanque: "T3", dia: 1, litros: 230, grasa: 11.1},
      %{productor: "P03", Tanque: "T3", dia: 3, litros: 360, grasa: 10.8},
      %{productor: "P04", Tanque: "T3", dia: 5, litros: 720, grasa: 3.8},
      %{productor: "P01", Tanque: "T1", dia: 6, litros: 640, grasa: 12.4},
      %{productor: "P01", Tanque: "T1", dia: 3, litros: 260, grasa: 9.6},
      %{productor: "P05", Tanque: "T2", dia: 6, litros: 660, grasa: 8.3},
      %{productor: "P07", Tanque: "T1", dia: 1, litros: 190, grasa: 14.2},
      %{productor: "P03", Tanque: "T1", dia: 3, litros: 800, grasa: 2.2},
      %{productor: "P03", Tanque: "T1", dia: 3, litros: 560, grasa: 13.5},
      %{productor: "P01", Tanque: "T3", dia: 2, litros: 410, grasa: 10.0},
      %{productor: "P06", Tanque: "T4", dia: 5, litros: 290, grasa: 13.9},
      %{productor: "P04", Tanque: "T2", dia: 2, litros: 620, grasa: 0.4},
      %{productor: "P06", Tanque: "T4", dia: 6, litros: 410, grasa: 4.0},
      %{productor: "P02", Tanque: "T4", dia: 1, litros: 700, grasa: 3.3},
      %{productor: "P08", Tanque: "T3", dia: 3, litros: 390, grasa: 3.3}
    ]
  end
end
